#if defined(__APPLE__)
#define _DARWIN_C_SOURCE
#elif !defined(_XOPEN_SOURCE)
#define _XOPEN_SOURCE 700
#endif

#include <getopt.h>
#include <locale.h>
#include <math.h>
#include <ncurses.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

#define VERSION "3.0.0"

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#define MAX_PETALS  768
#define MAX_SOURCES 4096
#define MAX_BLOBS   32

/*
 * A terminal cell is roughly twice as tall as it is wide. The tree is laid out
 * in *square* units and divided back down, so the crown keeps one silhouette
 * whatever the terminal's rows-to-columns ratio happens to be.
 */
#define CELL_AR 2.0

enum { K_NONE = 0, K_WOOD, K_CANOPY, K_GROUND };
enum { PK_NONE = 0, PK_WOOD, PK_BLOOM, PK_GROUND };   /* detail-mode pixels */

/*
 * Foreground tones. The eight ramp steps run light (0) to deep (7); a cell
 * picks one by how much light reaches it.
 */
enum {
    F_P0 = 0, F_P1, F_P2, F_P3, F_P4, F_P5, F_P6, F_P7,
    F_TRUNK_D, F_TRUNK_M, F_TRUNK_L,
    F_GRASS, F_GRASS_M, F_GRASS_D,
    F_FADED,
    NFG
};

/*
 * Background tones. Canopy cells sit on a haze — a dark tint of the blossom
 * colour — so that partial block glyphs (░▒▓) blend the ramp step toward the
 * mass instead of toward the bare terminal. Cells deep inside the crown sit on
 * a ramp step directly, so a blossom drawn there stays flush with its
 * neighbours rather than punching a hole in the mass.
 */
enum {
    B_DEF = 0, B_HAZE,
    B_P0, B_P1, B_P2, B_P3, B_P4, B_P5, B_P6, B_P7,
    NBG
};

#define NPAIRS (1 + NFG * NBG)

/*
 * Detail-mode tones are the foreground tones shifted up by one, 0 standing for
 * an empty pixel. Their pairs sit after the cell-mode ones: one for every
 * upper and lower tone a half-block cell can combine.
 */
#define HC(f)    ((unsigned char)((f) + 1))
#define NHC      (NFG + 1)
#define HD_PAIR0 (NPAIRS + 1)
#define HD_PAIRS (NHC * NHC)

typedef struct {
    const char   *glyph;
    unsigned char fg, bg, kind;
    bool          bold;
} Cell;

typedef struct {
    double x, y;
    double vy;
    double phase, freq, amp;
    const char *glyph;
    unsigned char fg;
    double rest;
    bool active;
} Petal;

typedef struct { short x, y; } Coord;
typedef struct { double x, y, rx, ry; } Blob;

static Cell *grid = NULL;
static int gw = 0, gh = 0;

/* Detail mode's pixel canvas: two pixels to a cell, top and bottom. */
static unsigned char *pix = NULL, *pkind = NULL, *frame = NULL;
static int pw = 0, ph = 0;

static Coord sources[MAX_SOURCES];
static int nsources = 0;

static Blob blobs[MAX_BLOBS];
static int nblobs = 0;

typedef struct { double x, y; } Point;

#define MAX_TIPS 24
static Point tips[MAX_TIPS];
static int ntips = 0;

static Petal petals[MAX_PETALS];
static int npetals = 0;

static double wind = 0.0, wind_target = 0.0;

static volatile sig_atomic_t running = 1;

static int    opt_fps     = 20;
static int    opt_density = 5;
static double opt_wind    = 1.0;
static bool   opt_ascii   = false;
static bool   opt_flat    = false;   /* keep the terminal background visible */
static bool   opt_detail  = false;   /* half-block pixel tree, see gen_tree_hd */
static bool   opt_anykey   = false;  /* -k: any key quits (idle-screensaver dismiss) */
static int    opt_cycle    = 0;      /* -C N: auto-advance palette every N seconds (0 = off) */
/*
 * Canopy shadow override. HAZE_PALETTE keeps the shade the palette ships,
 * -1 leaves the shadow unpainted so a transparent terminal shows through it,
 * and 0-255 is an xterm index for matching your own background.
 */
#define HAZE_PALETTE (-2)
static int    opt_haze    = HAZE_PALETTE;
static int    opt_palette = 0;

/*
 * Tree form. Somei-yoshino is the spreading, vase-shaped cherry most people
 * picture; bush is the same cherry at full bloom, its crown closed into one
 * rounded cloud of blossom; shidare-zakura is the weeping cherry, its blossom
 * hanging in curtains that nearly reach the ground. Random picks one on every
 * regrow.
 */
enum { STYLE_YOSHINO = 0, STYLE_BUSH, STYLE_SHIDARE, NFORMS,
       STYLE_RANDOM = NFORMS, NSTYLES };
static const char *STYLE_NAMES[NSTYLES] = { "yoshino", "bush", "shidare", "random" };
static int    opt_style   = STYLE_YOSHINO;

/* Whether cell backgrounds are actually painted (needs 256 colours). */
static bool shaded = false;
/* Whether detail mode can be shown: 256 colours and every pair it needs. */
static bool hd_ok = false;

static double frand(void) { return rand() / ((double)RAND_MAX + 1.0); }
static double frange(double a, double b) { return a + frand() * (b - a); }
static double clampd(double v, double a, double b)
{
    return v < a ? a : (v > b ? b : v);
}

static void on_signal(int sig) { (void)sig; running = 0; }

/*
 * With backgrounds off there is only one background tone, so the pair table
 * collapses to one entry per foreground and stays inside the 64-pair limit of
 * a plain 8-colour terminal.
 */
static short pair_of(int fg, int bg)
{
    return shaded ? (short)(1 + fg * NBG + bg) : (short)(1 + fg);
}

static short hd_pair(int fg, int bg)
{
    return (short)(HD_PAIR0 + fg * NHC + bg);
}

typedef struct {
    const char *name;
    short ramp[8];
    short haze;     /* canopy shadow: a dark tone the ramp can sink into */
} Palette;

static const Palette PALETTES[] = {
    { "sakura",   { 225, 224, 218, 212, 211, 175, 168, 132 }, 235 },
    { "rose",     { 224, 218, 211, 204, 203, 161, 125,  88 }, 235 },
    { "blush",    { 225, 218, 217, 211, 210, 168, 131,  95 }, 236 },
    { "magenta",  { 219, 213, 207, 200, 163, 127,  90,  53 }, 234 },
    { "peach",    { 223, 216, 215, 209, 173, 130,  94,  58 }, 235 },
    { "coral",    { 217, 210, 209, 203, 167, 131,  88,  52 }, 235 },
    { "sunset",   { 223, 216, 209, 203, 167, 131,  88,  52 }, 235 },
    { "gold",     { 229, 222, 221, 179, 136,  94,  58,  52 }, 235 },
    { "lavender", { 189, 183, 147, 141, 140,  98,  61,  54 }, 234 },
    { "violet",   { 183, 177, 141, 135,  98,  91,  54,  53 }, 234 },
    { "sky",      { 153, 117, 111,  75,  68,  31,  25,  24 }, 234 },
    { "mint",     { 158, 122, 115,  79,  72,  35,  29,  22 }, 234 },
    { "matcha",   { 193, 150, 149, 107,  70,  64,  28,  22 }, 234 },
    { "white",    { 255, 225, 224, 218, 211, 175, 168, 132 }, 236 },
    { "ink",      { 255, 252, 251, 248, 245, 242, 239, 236 }, 234 },
};
#define NPALETTES ((int)(sizeof(PALETTES) / sizeof(PALETTES[0])))

static int find_palette(const char *name)
{
    for (int i = 0; i < NPALETTES; i++)
        if (strcmp(PALETTES[i].name, name) == 0)
            return i;
    return -1;
}

/*
 * -H takes an xterm colour index so the canopy shadow can be matched to your
 * own background, or "none" to leave it unpainted while the blossom keeps its
 * shading. Anything else is a usage error rather than a silent fallback.
 */
static bool parse_haze(const char *s, int *out)
{
    if (strcmp(s, "none") == 0 || strcmp(s, "off") == 0) {
        *out = -1;
        return true;
    }

    char *end;
    long v = strtol(s, &end, 10);
    if (end == s || *end != '\0' || v < 0 || v > 255)
        return false;

    *out = (int)v;
    return true;
}

static void update_shaded(void)
{
    shaded = !opt_flat && has_colors() && COLORS >= 256 && COLOR_PAIRS >= NPAIRS;
    hd_ok  = has_colors() && COLORS >= 256 && COLOR_PAIRS >= HD_PAIR0 + HD_PAIRS;
}

/* The half blocks are unicode, so ASCII mode falls back to the cell tree. */
static bool use_hd(void)
{
    return opt_detail && hd_ok && !opt_ascii;
}

static void apply_palette(void)
{
    if (!has_colors())
        return;

    const Palette *p = &PALETTES[opt_palette];
    short fg[NFG], bg[NBG];

    if (COLORS >= 256) {
        for (int i = 0; i < 8; i++)
            fg[F_P0 + i] = p->ramp[i];
        fg[F_TRUNK_D] = 52;  fg[F_TRUNK_M] = 94;  fg[F_TRUNK_L] = 137;
        fg[F_GRASS]   = 108; fg[F_GRASS_M] = 65;  fg[F_GRASS_D] = 238;
        fg[F_FADED]   = p->ramp[5];

        bg[B_DEF]  = -1;
        bg[B_HAZE] = opt_haze == HAZE_PALETTE ? p->haze : (short)opt_haze;
        for (int i = 0; i < 8; i++)
            bg[B_P0 + i] = p->ramp[i];
    } else {
        short base = COLOR_MAGENTA;
        if (opt_palette == 7)  base = COLOR_YELLOW;
        if (opt_palette == 10) base = COLOR_CYAN;
        if (opt_palette == 11 || opt_palette == 12) base = COLOR_GREEN;
        if (opt_palette == 14) base = COLOR_WHITE;

        fg[F_P0] = COLOR_WHITE;
        fg[F_P1] = COLOR_WHITE;
        for (int i = 2; i < 6; i++)
            fg[F_P0 + i] = base;
        fg[F_P6] = COLOR_RED;
        fg[F_P7] = COLOR_RED;
        fg[F_TRUNK_D] = COLOR_YELLOW;
        fg[F_TRUNK_M] = COLOR_YELLOW;
        fg[F_TRUNK_L] = COLOR_YELLOW;
        fg[F_GRASS]   = COLOR_GREEN;
        fg[F_GRASS_M] = COLOR_GREEN;
        fg[F_GRASS_D] = COLOR_GREEN;
        fg[F_FADED]   = base;

        for (int i = 0; i < NBG; i++)
            bg[i] = -1;
    }

    if (shaded) {
        for (int f = 0; f < NFG; f++)
            for (int b = 0; b < NBG; b++)
                init_pair((short)(1 + f * NBG + b), fg[f], bg[b]);
    } else {
        for (int f = 0; f < NFG; f++)
            init_pair((short)(1 + f), fg[f], -1);
    }

    if (hd_ok) {
        for (int f = 1; f < NHC; f++)
            for (int b = 0; b < NHC; b++)
                init_pair(hd_pair(f, b), fg[f - 1], b ? fg[b - 1] : -1);
    }
}

static void init_colors(void)
{
    start_color();
    use_default_colors();
    update_shaded();
    apply_palette();
}

static const char *G_FULL = "█";
static const char *G_DARK = "▓";
static const char *G_MED  = "▒";
static const char *G_LITE = "░";
static const char *G_DOT  = "·";

static const char *bloom_uni[] = { "❀", "✿", "❁", "✽" };
static const char *bloom_asc[] = { "&", "%", "@", "*" };

static const char *petal_uni[] = { "❀", "✿", "*", "·", "∘" };
static const char *petal_asc[] = { "*", "*", "o", ".", "'" };

static const char *g_full(void) { return opt_ascii ? "@" : G_FULL; }
static const char *g_dark(void) { return opt_ascii ? "%" : G_DARK; }
static const char *g_med(void)  { return opt_ascii ? ":" : G_MED;  }
static const char *g_lite(void) { return opt_ascii ? "." : G_LITE; }
static const char *g_dot(void)  { return opt_ascii ? "." : G_DOT;  }

/* ---------- generation ---------- */

static unsigned char cur_kind = K_NONE;

static void put_bg(int x, int y, const char *glyph, int fg, int bg, bool bold)
{
    if (x < 0 || y < 0 || x >= gw || y >= gh)
        return;
    Cell *c = &grid[(size_t)y * gw + x];
    c->glyph = glyph;
    c->fg    = (unsigned char)fg;
    c->bg    = (unsigned char)bg;
    c->bold  = bold;
    c->kind  = cur_kind;
}

static void put(int x, int y, const char *glyph, int fg, bool bold)
{
    put_bg(x, y, glyph, fg, B_DEF, bold);
}

static unsigned char kind_at(int x, int y)
{
    if (x < 0 || y < 0 || x >= gw || y >= gh)
        return K_NONE;
    return grid[(size_t)y * gw + x].kind;
}

/*
 * Falloff sits between a tight 2.2 and a soft 1.25. Too tight and the coverage
 * ramp is crossed inside a single row, giving a hard horizontal cut across the
 * crown; too soft and the per-tip blobs smear together into one smooth dome
 * instead of reading as separate clumps of blossom.
 */
static double field(double x, double y)
{
    double s = 0.0;
    for (int i = 0; i < nblobs; i++) {
        double dx = (x - blobs[i].x) / blobs[i].rx;
        double dy = (y - blobs[i].y) / blobs[i].ry;
        s += exp(-(dx * dx + dy * dy) * 1.70);
    }
    return s;
}

static double hash01(int i)
{
    unsigned h = (unsigned)i * 2654435761u;
    h ^= h >> 13;
    h *= 1274126177u;
    h ^= h >> 16;
    return (double)(h & 0xffff) / 65535.0;
}

static double hash2(int x, int y)
{
    unsigned h = (unsigned)x * 374761393u + (unsigned)y * 668265263u;
    h = (h ^ (h >> 13)) * 1274126177u;
    return (double)((h ^ (h >> 16)) & 0xffff) / 65535.0;
}

/* Smooth value noise in [0,1]; inputs are already divided by the feature size. */
static double vnoise(double x, double y)
{
    int xi = (int)floor(x), yi = (int)floor(y);
    double tx = x - xi, ty = y - yi;
    tx = tx * tx * (3.0 - 2.0 * tx);
    ty = ty * ty * (3.0 - 2.0 * ty);
    double a = hash2(xi, yi),     b = hash2(xi + 1, yi);
    double c = hash2(xi, yi + 1), d = hash2(xi + 1, yi + 1);
    return (a + (b - a) * tx) * (1.0 - ty) + (c + (d - c) * tx) * ty;
}

/*
 * Per-column wobble in [-0.5, 0.5], one control point every `period` cells.
 * Sampling the field at y + wobble breaks the canopy's contour: the crown is
 * only a dozen or so rows tall, so an unperturbed outline flattens into a
 * straight cut across the top.
 */
static double wobble(int x, double period)
{
    double p = x / period;
    int c = (int)floor(p);
    double t = p - c;
    double a = hash01(c) - 0.5, b = hash01(c + 1) - 0.5;
    t = t * t * (3.0 - 2.0 * t);
    return a + (b - a) * t;
}

static void add_source(int x, int y)
{
    if (nsources < MAX_SOURCES) {
        sources[nsources].x = (short)x;
        sources[nsources].y = (short)y;
        nsources++;
    }
}

static void gen_canopy(double cx, double rx, double ry_design)
{
    const char **blooms = opt_ascii ? bloom_asc : bloom_uni;

    double bx0 = 1e9, bx1 = -1e9, by0 = 1e9, by1 = -1e9;
    for (int i = 0; i < nblobs; i++) {
        if (blobs[i].x - blobs[i].rx < bx0) bx0 = blobs[i].x - blobs[i].rx;
        if (blobs[i].x + blobs[i].rx > bx1) bx1 = blobs[i].x + blobs[i].rx;
        if (blobs[i].y - blobs[i].ry < by0) by0 = blobs[i].y - blobs[i].ry;
        if (blobs[i].y + blobs[i].ry > by1) by1 = blobs[i].y + blobs[i].ry;
    }
    if (by0 < 0.0)
        by0 = 0.0;
    int x0 = (int)(bx0 - 3), x1 = (int)(bx1 + 3);
    int y0 = (int)(by0 - 1), y1 = (int)(by1 + 3);
    if (y0 < 0)
        y0 = 0;

    double cy = (by0 + by1) / 2.0;
    double ry = fmax((by1 - by0) / 2.0, 2.0);

    /* Feature sizes tied to the tree, so texture scales with the terminal. */
    double wob_amp = fmax(ry_design * 0.18, 0.8);
    double wob_per = fmax(rx * 0.11, 2.0);
    double clump_x = fmax(rx * 0.22, 2.0);
    double clump_y = fmax(ry_design * 0.26, 1.2);

    cur_kind = K_CANOPY;

    for (int y = y0; y <= y1; y++) {
        if (y < 0 || y >= gh) continue;
        for (int x = x0; x <= x1; x++) {
            if (x < 0 || x >= gw) continue;

            double wob = wobble(x, wob_per) * wob_amp;
            double f = field(x, y + wob);
            if (f < 0.20)
                continue;

            /* Coverage: 1 deep inside the mass, falling to 0 at the rim. */
            double cov0 = clampd((f - 0.20) / 0.60, 0.0, 1.0);
            cov0 = cov0 * cov0 * (3.0 - 2.0 * cov0);
            double cov = cov0;

            /*
             * Break the mass into blossom clumps. Without this the crown is a
             * single smooth blob — a generic tree. Two octaves, stretched
             * horizontally, give the layered clusters a cherry reads as.
             */
            double cl = 0.62 * vnoise(x / clump_x, y / clump_y)
                      + 0.38 * vnoise(x / (clump_x * 0.45), y / (clump_y * 0.5));
            cov = clampd(cov * (0.50 + 1.00 * cl), 0.0, 1.0);

            /*
             * Ragged silhouette, and gaps where the clumps thin out. Gaps deep
             * inside the crown fall back to the deepest blossom tone. Dropping
             * to the terminal background, or even to the dark haze, punches
             * holes that read as black specks rather than as shadow.
             */
            if (cov < 0.55 && frand() > cov * 1.5) {
                if (cov0 > 0.60 && kind_at(x, y) != K_WOOD)
                    put_bg(x, y, g_dark(), F_P7, B_HAZE, false);
                continue;
            }

            double h = clampd((y - (cy - ry)) / (2.0 * ry), 0.0, 1.0);

            /* Thin the underside so the canopy trails off into wisps. */
            if (h > 0.72) {
                double open = (h - 0.72) * 2.2 * (1.3 - cov);
                if (frand() < open)
                    continue;
            }

            /*
             * Let limbs show through between clusters — dark branches
             * threading the blossom is most of the character. Driven by the
             * noise field, not a coin flip, so a limb emerges as a continuous
             * run rather than a scatter of disconnected dashes. The exposed
             * wood still takes the canopy's shadow tone, so it reads as being
             * inside the crown rather than a gap punched through it. A small
             * crown keeps its limbs covered: at that scale a limb is a lone
             * cell, and reads as a hole.
             */
            if (rx >= 16.0 && (cov < 0.50 || cl < 0.30)
                    && kind_at(x, y) == K_WOOD) {
                grid[(size_t)y * gw + x].bg = B_HAZE;
                continue;
            }

            /*
             * Light falls from the upper left; the mass shades what's below.
             * Thin rim cells take a deep, saturated tone on purpose: a pale
             * tint blended toward a dark background turns grey, not pink.
             */
            double shade = 1.1
                         + h * 5.2
                         + ((x - cx) / fmax(rx, 1.0)) * 0.70
                         + (1.0 - cov) * 2.0
                         + (0.5 - cl) * 2.8       /* clumps read as clusters  */
                         + frange(-1.05, 1.05);   /* dither across ramp steps */

            double fu = field(x, y + wob - 1.6);
            if (fu > f * 1.10)      shade += 1.6;
            else if (fu < f * 0.85) shade -= 1.4;

            int idx = (int)clampd(shade, 0.0, 7.0);

            /*
             * Solid well before the rim, so the mass stays saturated and only
             * the outer fringe dissolves. The partial blocks are doing real
             * work here: ▓ over the haze is three-quarters of the ramp step,
             * ░ is a quarter, which is how the crown fades out smoothly with
             * only eight colours to spend.
             */
            const char *g = cov > 0.62 ? g_full()
                          : cov > 0.42 ? g_dark()
                          : cov > 0.24 ? g_med()
                          : g_lite();
            int fg = F_P0 + idx, bg = B_HAZE;
            bool bold = false;

            /*
             * Blossoms ride on top of the mass, densest around the rim, and
             * step away from the local tone rather than always lightening — a
             * pale flower on the pale crown is invisible. Inside the mass the
             * blossom sits on the tone its neighbours already render as.
             */
            if (frand() < 0.06 + 0.16 * cl + 0.14 * (1.0 - cov)) {
                g   = blooms[rand() % 4];
                bg  = cov > 0.62 ? B_P0 + idx
                    : cov > 0.38 ? B_P0 + (idx < 7 ? idx + 1 : 7)
                    : B_HAZE;
                fg  = F_P0 + (idx <= 2 ? idx + 3 : idx - 3);
                if (idx > 2 && frand() < 0.35)
                    bold = true;
            }

            put_bg(x, y, g, fg, bg, bold);

            if ((cov < 0.55 || fu > f * 1.10) && frand() < 0.5)
                add_source(x, y);
        }
    }

    cur_kind = K_NONE;
}

/*
 * Lay down one horizontal slice of wood centred on x with half-width w, using
 * partial block glyphs where the edge falls inside a cell so the taper reads as
 * a smooth curve rather than a staircase. `sides` shades the slice dark on the
 * left and light on the right. That only means something for upright wood: a
 * limb running sideways takes one tone along its length instead.
 */
static void wood_span(double x, int y, double w, int dark, int mid, int lite,
                      bool sides)
{
    int i0 = (int)floor(x - w), i1 = (int)ceil(x + w);
    for (int xi = i0; xi <= i1; xi++) {
        double l  = fmax((double)xi, x - w);
        double rr = fmin(xi + 1.0, x + w);
        double cov = rr - l;
        if (cov <= 0.06)
            continue;

        /* Limbs are drawn as many overlapping slices. A slice's soft edge must
         * not eat into wood an earlier slice already laid down solid. */
        if (cov <= 0.85 && kind_at(xi, y) == K_WOOD)
            continue;

        double d = (xi + 0.5 - x) / fmax(w, 0.5);
        int fg = !sides ? mid : d < -0.30 ? dark : (d > 0.40 ? lite : mid);
        const char *g = cov > 0.85 ? g_full()
                      : cov > 0.55 ? g_dark()
                      : cov > 0.28 ? g_med()
                      : g_lite();
        put(xi, y, g, fg, false);
    }
}

static void gen_trunk(double bx, double tx, double ty, double maxw)
{
    double base_y = gh - 2.0;
    double h = base_y - ty;
    if (h < 2.0) h = 2.0;

    double bend = frange(-1.0, 1.0) * fmax(maxw * 0.7, 0.6);

    for (int y = (int)ty; y <= (int)base_y; y++) {
        double t = clampd((base_y - y) / h, 0.0, 1.0);
        double x = bx + (tx - bx) * t + sin(t * M_PI) * bend;
        /* Gentle root flare — a steep one reads as a wedge, not a trunk. */
        double w = maxw * (1.0 - 0.45 * t) * (1.0 + 0.55 * exp(-t * 7.0));
        wood_span(x, y, fmax(w, 0.55), F_TRUNK_D, F_TRUNK_M, F_TRUNK_L, true);
    }
}

static void add_tip(double x, double y)
{
    if (ntips < MAX_TIPS)
        tips[ntips++] = (Point){ x, y };
}

static Point bez(Point a, Point q, Point b, double t)
{
    double u = 1.0 - t;
    return (Point){ u * u * a.x + 2.0 * u * t * q.x + t * t * b.x,
                    u * u * a.y + 2.0 * u * t * q.y + t * t * b.y };
}

/*
 * One limb, drawn as a quadratic curve from p0 bending toward q and ending at
 * p1, tapering from w0 to w1. A curve rather than a random walk: the walk
 * wandered off to one side often enough that the crown, which grows around
 * the limb tips, came out lopsided.
 */
static void gen_limb(Point p0, Point q, Point p1, double w0, double w1, int mid)
{
    double len = hypot(q.x - p0.x, (q.y - p0.y) * CELL_AR)
               + hypot(p1.x - q.x, (p1.y - q.y) * CELL_AR);
    int steps = (int)(len * 2.5) + 4;

    for (int i = 0; i <= steps; i++) {
        double t = (double)i / steps, u = 1.0 - t;
        double w = w0 + (w1 - w0) * t;
        /* The finest twigs are sub-cell width; drawing them only scatters
         * disconnected specks through the blossom. */
        if (w < 0.32)
            break;
        Point p = bez(p0, q, p1, t);
        double dx = u * (q.x - p0.x) + t * (p1.x - q.x);
        double dy = (u * (q.y - p0.y) + t * (p1.y - q.y)) * CELL_AR;
        wood_span(p.x, (int)floor(p.y), w, F_TRUNK_D, mid, F_TRUNK_L,
                  fabs(dy) > fabs(dx));
    }
}

static void gen_ground(double cx, double rx)
{
    const char **blooms = opt_ascii ? bloom_asc : bloom_uni;
    int y = gh - 1;

    cur_kind = K_GROUND;

    for (int x = 0; x < gw; x++) {
        double dx = (x - cx) / (rx * 1.25);
        double p = exp(-dx * dx * 2.2);
        double rr = frand();
        /* Grass fades out with distance instead of ruling a hard line. */
        int grass = p > 0.55 ? F_GRASS : p > 0.20 ? F_GRASS_M : F_GRASS_D;

        if (rr < p * 0.55) {
            double r2 = frand();
            const char *g = r2 < 0.28 ? blooms[rand() % 4]
                          : r2 < 0.62 ? g_dot()
                          : ",";
            put(x, y, g, F_P2 + rand() % 4, false);
        } else if (rr < p * 0.55 + 0.10) {
            put(x, y, "\"", grass, false);
        } else if (rr < p * 0.55 + 0.16) {
            put(x, y, ",", grass, false);
        } else {
            put(x, y, "_", grass, false);
        }

        /* A drift of fallen petals gathering around the roots. */
        if (gh > 4 && frand() < p * 0.28)
            put(x, y - 1, frand() < 0.35 ? blooms[rand() % 4] : g_dot(),
                F_P2 + rand() % 3, false);
    }

    cur_kind = K_NONE;
}

static void add_blob_clamped(double x, double y, double brx, double bry,
                             double y_top)
{
    if (nblobs >= MAX_BLOBS)
        return;
    if (y - bry < y_top)
        y = y_top + bry;
    blobs[nblobs++] = (Blob){ x, y, brx, bry };
}

/*
 * Hang the weeping cherry's curtains: strands of blossom falling from the
 * underside of the crown. They lengthen toward the sides, so the tree reads as
 * a dome with a veil round it, and thin out as they fall rather than ending in
 * a hard line.
 */
static void gen_curtain(double cx, double rx)
{
    const char **blooms = opt_ascii ? bloom_asc : bloom_uni;
    double floor_y = gh - 2.0;

    cur_kind = K_CANOPY;

    for (int x = (int)(cx - rx * 1.05); x <= (int)(cx + rx * 1.05); x++) {
        if (x < 0 || x >= gw || frand() < 0.25)
            continue;

        /* The lowest blossom in the column is where the strand hangs from. */
        int y0 = -1;
        for (int y = gh - 2; y >= 0; y--) {
            if (kind_at(x, y) == K_CANOPY) {
                y0 = y;
                break;
            }
        }
        if (y0 < 0)
            continue;

        double frac = fmin(fabs(x - cx) / rx, 1.0);
        double len  = (floor_y - y0) * (0.25 + 0.65 * pow(frac, 0.8))
                    * frange(0.55, 1.0);

        for (int k = 1; k <= (int)len; k++) {
            int y = y0 + k;
            if (y >= gh - 1 || kind_at(x, y) == K_WOOD)
                break;
            double t = k / fmax(len, 1.0);
            if (frand() < t * 0.45)
                continue;

            int idx = (int)clampd(1.5 + t * 3.5 + frange(-1.0, 1.0), 0.0, 7.0);
            const char *g = frand() < 0.22 ? blooms[rand() % 4]
                          : t < 0.55       ? g_med()
                          : g_lite();
            put(x, y, g, F_P0 + idx, false);

            if (frand() < 0.15)
                add_source(x, y);
        }
    }

    cur_kind = K_NONE;
}

/*
 * Each form is a set of ranges rather than fixed numbers. Every tree draws its
 * own proportions from inside them, so no two come out alike, but none strays
 * outside what that kind of cherry actually looks like.
 */
typedef struct {
    double crown[2];   /* crown height, as a share of the tree's height     */
    double spread[2];  /* crown width over tree height                      */
    double maxw;       /* widest the crown may get, as a share of the width */
    double dome[2];    /* how far the centre limbs out-reach the outer ones */
    double lift[2];    /* where the outermost limb tips sit, in crown radii */
    double lean;       /* largest offset of the crown from the roots        */
    double bend;       /* how soon a limb turns upward: low spreads first   */
    int    limbs[2];
} Form;

static const Form FORMS[NFORMS] = {
    /* yoshino: wide and spreading, vase-shaped to umbrella-topped */
    { { 0.54, 0.64 }, { 1.15, 1.40 }, 0.80, { 0.40, 0.65 }, { -0.15, -0.05 },
      0.12, 0.30, { 4, 5 } },
    /* bush: a full, rounded cloud of blossom */
    { { 0.58, 0.68 }, { 1.05, 1.25 }, 0.78, { 0.50, 0.70 }, { -0.10, 0.00 },
      0.08, 0.35, { 4, 5 } },
    /* shidare: a low dome, the curtains do the rest */
    { { 0.46, 0.54 }, { 0.95, 1.15 }, 0.70, { 0.45, 0.60 }, { -0.12, -0.04 },
      0.06, 0.35, { 4, 5 } },
};

static double pick_in(const double r[2]) { return frange(r[0], r[1]); }

/* Random picks a form afresh on every regrow, yoshino more often since it is
 * the cherry most people picture. */
static int pick_form(void)
{
    if (opt_style == STYLE_RANDOM)
        return frand() < 0.45 ? STYLE_YOSHINO
             : frand() < 0.55 ? STYLE_BUSH : STYLE_SHIDARE;
    return opt_style;
}

static void gen_tree(void)
{
    memset(grid, 0, sizeof(Cell) * (size_t)gw * gh);
    nsources = 0;
    nblobs = 0;
    ntips = 0;

    int form = pick_form();
    const Form *F = &FORMS[form];

    /*
     * The tree is sized as one shape, in square units (a row is CELL_AR
     * columns tall), so it keeps its proportions at every terminal size. It
     * takes the full height when the terminal is wide enough for that, and is
     * otherwise sized off the width and stands at the bottom with sky above
     * it. Sizing the crown and the trunk separately is what grew a lamppost in
     * a narrow pane and a pancake in a short one.
     */
    double ground  = gh - 1.0;
    double top_pad = gh < 20 ? 1.0 : clampd(gh * 0.06, 1.0, 4.0);
    double avail   = fmax(ground - top_pad, 5.0) * CELL_AR;

    double tall  = fmin(avail, gw * 0.95);
    double crown = tall * pick_in(F->crown);             /* crown height */
    /* A short, wide terminal gets a broader crown rather than a small one
     * lost in the middle of the screen. */
    double wide   = 1.0 + 0.30 * clampd((gw / tall - 2.0) / 2.0, 0.0, 1.0);
    double width  = fmin(gw * F->maxw, tall * pick_in(F->spread) * wide);

    double rx = fmax(width * 0.5, 5.0);
    double ry = fmax(crown * 0.5 / CELL_AR, 2.2);

    /*
     * Real trees lean. The crown sits off to one side of the roots and the
     * trunk curves under it; the pair is kept centred together so the tree as
     * a whole still sits in the middle of the screen.
     */
    double mid  = gw * 0.5 + frange(-1.0, 1.0) * fmin(1.5, gw * 0.02);
    double lean = frange(-1.0, 1.0) * F->lean * rx;

    double y_top = ground - tall / CELL_AR;
    double cx = mid + lean * 0.5;
    double cy = y_top + ry;

    /* Where the trunk splits: below the crown, so the fork is on show. */
    double fy = cy + ry * 0.95;
    fy = fmin(fy + (gh - 2.0 - fy) * 0.15, gh - 3.0);
    /* Sized off the whole tree, not the crown, so the trunk keeps its
     * proportion whatever width the crown drew. */
    double trunk_w = fmax(tall * 0.042, 1.0);
    double limb_w  = fmax(trunk_w * 0.62, 0.7);

    double bx = mid - lean * 0.5;
    double tx = cx - lean * 0.2 + frange(-1.0, 1.0) * fmax(rx * 0.03, 0.4);

    gen_ground(cx, rx);

    cur_kind = K_WOOD;
    gen_trunk(bx, tx, fy, trunk_w);

    /*
     * Limbs fan across the crown. The centre ones reach highest and the outer
     * ones spread wide before turning up, the silhouette a cherry is
     * recognised by. Each limb throws one twig off its outer half.
     */
    double dome = pick_in(F->dome), lift = pick_in(F->lift);
    int limbs = rx < 12.0 ? 3
              : F->limbs[0] + rand() % (F->limbs[1] - F->limbs[0] + 1);
    for (int i = 0; i < limbs; i++) {
        double s = ((i + 0.5) / limbs) * 2.0 - 1.0 + frange(-0.14, 0.14);
        s = clampd(s, -0.95, 0.95);

        Point p0 = { tx + s * trunk_w * 0.5, fy + frange(-0.3, 0.6) };
        Point p1 = { cx + s * rx * 0.72 + frange(-0.05, 0.05) * rx,
                     cy - ry * (lift + dome * (1.0 - s * s))
                        + frange(-0.12, 0.12) * ry };
        Point q  = { p0.x + (p1.x - p0.x) * 0.60,
                     p0.y - (p0.y - p1.y) * (F->bend + frange(-0.08, 0.08)) };

        gen_limb(p0, q, p1, limb_w, limb_w * 0.35,
                 fabs(s) < 0.4 ? F_TRUNK_M : F_TRUNK_L);
        add_tip(p1.x, p1.y);

        double side = s < 0.0 ? -1.0 : 1.0;
        if (fabs(s) < 0.2)
            side = frand() < 0.5 ? -1.0 : 1.0;
        Point b0 = bez(p0, q, p1, frange(0.55, 0.75));
        Point b1 = { b0.x + side * rx * frange(0.18, 0.30),
                     b0.y - ry * frange(0.20, 0.45) };
        b1.x = clampd(b1.x, cx - rx * 0.85, cx + rx * 0.85);
        Point bq = { b0.x + (b1.x - b0.x) * 0.6, b0.y - (b0.y - b1.y) * 0.2 };
        gen_limb(b0, bq, b1, limb_w * 0.45, limb_w * 0.2, F_TRUNK_L);
        add_tip(b1.x, b1.y);
    }
    cur_kind = K_NONE;

    /*
     * The canopy grows out of the limbs: one core blob, then a puff of blossom
     * at every branch tip. Laying the crown out as a fixed arrangement of blobs
     * instead gives a smooth, generic dome — the silhouette has to follow the
     * tree that was actually grown.
     */
    double lim = fmax(y_top - ry * 0.15, 0.0);
    add_blob_clamped(cx, cy + ry * 0.05, rx * 0.52, ry * 0.58, lim);
    for (int i = 0; i < ntips && nblobs < MAX_BLOBS - 4; i++) {
        add_blob_clamped(
            tips[i].x + frange(-0.8, 0.8),
            tips[i].y - frange(0.0, 0.25) * ry,
            rx * frange(0.24, 0.32),
            ry * frange(0.36, 0.48),
            lim);
    }
    /* Low clumps so the underside hangs down in wisps. */
    for (int i = 0; i < 4 && nblobs < MAX_BLOBS; i++) {
        double s = ((i + 0.5) / 4.0) * 2.0 - 1.0;
        add_blob_clamped(
            cx + (s * 0.70 + frange(-0.08, 0.08)) * rx,
            cy + frange(0.35, 0.55) * ry,
            rx * frange(0.18, 0.26),
            ry * frange(0.26, 0.36),
            lim);
    }

    gen_canopy(cx, rx, ry);
    if (form == STYLE_SHIDARE)
        gen_curtain(cx, rx);
}

/* ---------- detail mode ---------- */

/*
 * Detail mode draws the tree on a pixel canvas, two pixels to a cell: each cell
 * is a "▀" whose foreground is the upper pixel and whose background is the
 * lower one. A cell is twice as tall as it is wide, so the pixels come out
 * square, and at that resolution the tree can be grown as a real branching
 * structure rather than assembled from blobs.
 *
 * The branches come from space colonisation (Runions et al., 2007). The crown
 * is filled with attraction points and the tree grows toward them from the top
 * of the trunk, a node at a time, each point dropped once a branch reaches it.
 * Branches competing for those points is what gives the structure its natural
 * look: heavy limbs that split and taper into a fine mesh of twigs.
 */

#define HD_MAX_NODES 8000
#define HD_MAX_ATTR  2000

typedef struct { float x, y, r; int parent, kids, last; } HNode;
typedef struct { float x, y, d; int near; } Attr;   /* near < 0: consumed */

static HNode   hnodes[HD_MAX_NODES];
static int     nhnodes = 0;
static Attr    attrs[HD_MAX_ATTR];
static int     nattrs = 0;
static float   hgx[HD_MAX_NODES], hgy[HD_MAX_NODES];
static int     hgc[HD_MAX_NODES];
static double  hacc[HD_MAX_NODES];

static int px_get_kind(int x, int y)
{
    if (x < 0 || y < 0 || x >= pw || y >= ph)
        return PK_NONE;
    return pkind[(size_t)y * pw + x];
}

static void px_set(int x, int y, int f, int kind)
{
    if (x < 0 || y < 0 || x >= pw || y >= ph)
        return;
    pix[(size_t)y * pw + x]   = HC(f);
    pkind[(size_t)y * pw + x] = (unsigned char)kind;
}

static int hd_add_node(float x, float y, int parent)
{
    if (nhnodes >= HD_MAX_NODES)
        return -1;
    hnodes[nhnodes] = (HNode){ x, y, 0.0f, parent, 0, -1 };
    if (parent >= 0) {
        hnodes[parent].kids++;
        hnodes[parent].last = nhnodes;
    }
    return nhnodes++;
}

/*
 * Wood is stamped as discs along each segment. A pixel's tone comes from where
 * it sits across the limb, never along it, relative to the light, which falls
 * from the upper right as it does on the canopy: a trunk reads dark on its left
 * and a sideways limb is lit along its top. A limb seen inside the crown is in
 * the blossom's shade, so it keeps to the two darker tones.
 */
static void hd_wood_segment(const HNode *a, const HNode *b, bool inner)
{
    double dx = b->x - a->x, dy = b->y - a->y;
    double len = hypot(dx, dy);
    int steps = (int)(len / 0.35) + 1;
    double nx = len > 0.0 ? -dy / len : 1.0, ny = len > 0.0 ? dx / len : 0.0;
    double face = nx * 0.6 - ny * 0.8 >= 0.0 ? 1.0 : -1.0;

    for (int s = 0; s <= steps; s++) {
        double t  = (double)s / steps;
        double x  = a->x + dx * t, y = a->y + dy * t;
        double rr = a->r + (b->r - a->r) * t;

        if (rr < 0.75) {
            px_set((int)floor(x), (int)floor(y),
                   rr < 0.5 || inner ? F_TRUNK_D : F_TRUNK_M, PK_WOOD);
            continue;
        }
        int x0 = (int)floor(x - rr), x1 = (int)ceil(x + rr);
        int y0 = (int)floor(y - rr), y1 = (int)ceil(y + rr);
        for (int py = y0; py <= y1; py++) {
            for (int px = x0; px <= x1; px++) {
                double ox = px + 0.5 - x, oy = py + 0.5 - y;
                if (ox * ox + oy * oy > rr * rr)
                    continue;
                double lit = (ox * nx + oy * ny) / rr * face;
                int f = inner ? (lit > 0.35 ? F_TRUNK_M : F_TRUNK_D)
                      : lit < -0.35 ? F_TRUNK_D : lit > 0.35 ? F_TRUNK_L : F_TRUNK_M;
                px_set(px, py, f, PK_WOOD);
            }
        }
    }
}

static void hd_draw_wood(void)
{
    for (int i = 0; i < nhnodes; i++) {
        const HNode *n = &hnodes[i];
        if (n->parent >= 0)
            hd_wood_segment(&hnodes[n->parent], n, false);
    }

    /* Cherry bark is ringed with horizontal lenticels: short dark dashes
     * across the trunk and the heavy limbs. */
    for (int i = 0; i < nhnodes; i++) {
        const HNode *n = &hnodes[i];
        if (n->r < 2.2 || frand() > 0.12)
            continue;
        int y = (int)floor(n->y);
        double half = n->r * frange(0.25, 0.55);
        for (int x = (int)ceil(n->x - half); x <= (int)floor(n->x + half); x++)
            if (px_get_kind(x, y) == PK_WOOD)
                px_set(x, y, F_TRUNK_D, PK_WOOD);
    }
}

/*
 * The blossom, built the way pixel artists build foliage: one small bundle of
 * flowers, consistent in size and shape, drawn in a dark, a mid and a light
 * tone and layered toward the light. Every bundle goes down dark first; the
 * mid tone lands over it nudged toward the light, then the light tone over
 * that, nudged further, on the clusters the light reaches. The dark left
 * showing reads as the shadow under and behind each cluster, so the crown
 * takes its depth from layering alone. Shading from a smooth field instead
 * reads as embossing, or as the contour lines of a depth map.
 */
static const char *const BUNDLES[4][5] = {
    { "..###..", ".#####.", "#######", ".#####.", "..#.#.." },
    { ".##.##.", "#######", "#######", ".#####.", "...#..." },
    { "..##...", ".####.#", "#######", "######.", ".##.#.." },
    { ".###...", "#####..", "######.", ".######", "..#.##." },
};
static const char *const SPRIG[4] = { ".###.", "#####", "#####", ".#.#." };

typedef struct { float x, y; unsigned char shape, lo; bool mid, lit; } Bundle;
static Bundle bundles[HD_MAX_NODES * 2];

/*
 * Stamp a bundle shape scaled by k, which need not be whole: the bundles have
 * to keep the same size against the branches at every tree size, or a larger
 * tree comes out as thin strings of blossom. An occasional petal catches the
 * light when asked for.
 */
static void hd_stamp(const char *const *rows, int nrows, double x0, double y0, double k,
                     int f, bool sparkle)
{
    int ncols = (int)strlen(rows[0]);
    int w = (int)ceil(ncols * k), h = (int)ceil(nrows * k);
    for (int py = 0; py < h; py++) {
        int r = (int)(py / k);
        for (int px = 0; px < w; px++) {
            int c = (int)(px / k);
            if (r >= nrows || c >= ncols || rows[r][c] != '#')
                continue;
            px_set((int)floor(x0) + px, (int)floor(y0) + py,
                   sparkle && frand() < 0.06 ? F_P0 : f, PK_BLOOM);
        }
    }
}

static void hd_foliage(int form, double cy, double ry, double scale)
{
    bool   bush   = form == STYLE_BUSH;
    double k      = fmax(1.0, scale * 0.75);
    double twig   = fmax(0.9, scale * 0.8);
    double spread = k * (bush ? 2.2 : 1.6);
    int    nb     = 0;

    /* Bundles sit along the twigs the tree grew, two at each tip. */
    for (int i = 1; i < nhnodes; i++) {
        const HNode *nd = &hnodes[i];
        int w = nd->kids == 0 ? 2 : nd->r < twig ? 1 : bush && nd->r < twig * 2.5 ? 1 : 0;
        if (nd->y > cy + ry)
            continue;
        for (int j = 0; j < w && nb < HD_MAX_NODES * 2; j++) {
            double y = nd->y + frange(-spread, spread) * 0.6;
            double h = clampd((y - (cy - ry)) / (2.0 * ry), 0.0, 1.0);
            bundles[nb++] = (Bundle){
                (float)(nd->x + frange(-spread, spread)), (float)y,
                (unsigned char)(rand() % 4),
                /* The lower crown sits a step deeper, the line between left
                 * ragged so it never reads as a band across the crown. */
                (unsigned char)(h > 0.62 + frange(-0.15, 0.15) ? 1 : 0),
                frand() < 0.88,
                frand() < 0.62 - h * 0.5,                /* the light favours the top */
            };
        }
    }

    for (int i = 0; i < nb; i++) {
        const Bundle *b = &bundles[i];
        hd_stamp(BUNDLES[b->shape], 5, b->x - 3.5 * k, b->y - 2.5 * k, k, F_P5 + b->lo, false);
    }
    for (int i = 0; i < nb; i++) {
        const Bundle *b = &bundles[i];
        if (!b->mid)
            continue;
        hd_stamp(BUNDLES[b->shape], 5, b->x - 2.5 * k, b->y - 3.5 * k, k, F_P3 + b->lo, false);
        if (frand() < 0.5)
            add_source((int)b->x, (int)b->y / 2);
    }
    for (int i = 0; i < nb; i++) {
        const Bundle *b = &bundles[i];
        if (!b->lit)
            continue;
        hd_stamp(SPRIG, 4, b->x - 0.5 * k, b->y - 4.0 * k, k, F_P1 + b->lo, true);
    }

    /*
     * Here and there a limb crosses in front of the blossom, dark against the
     * pink and slimmer than it is below the crown, where it is further off.
     * The choice is made once per branch, at the fork it grows from, so a limb
     * in front is one continuous run rather than loose sticks on the crown.
     */
    static bool front[HD_MAX_NODES];
    front[0] = false;
    for (int i = 1; i < nhnodes; i++) {
        int pa = hnodes[i].parent;
        front[i] = hnodes[pa].kids > 1 ? frand() < 0.35 : front[pa];
    }
    double limb = fmax(0.9, scale * 0.7);
    for (int i = 1; i < nhnodes; i++) {
        const HNode *nd = &hnodes[i];
        if (!front[i] || nd->r < limb || nd->y > cy + ry * 0.9)
            continue;
        HNode a = hnodes[nd->parent], b = *nd;
        a.r *= 0.7f;
        b.r *= 0.7f;
        hd_wood_segment(&a, &b, true);
    }
}

/*
 * The weeping cherry's strands: fine hanging twigs so thick with flower that
 * they read as continuous threads of pink, lengthening toward the edge of the
 * crown, swaying a little, and thinning out toward their tips.
 */
static void hd_curtains(double cx, double rx, double ground)
{
    for (int i = 0; i < nhnodes; i++) {
        const HNode *n = &hnodes[i];
        double frac = fabs(n->x - cx) / fmax(rx, 1.0);
        if (n->kids != 0 || frac < 0.20 || frand() < 0.40)
            continue;

        double len   = (ground - n->y) * (0.30 + 0.60 * fmin(frac, 1.0)) * frange(0.6, 1.0);
        double drift = frange(0.02, 0.06) * (n->x < cx ? -1.0 : 1.0);
        double phase = frange(0.0, 2.0 * M_PI);

        for (int k = 1; k < (int)len; k++) {
            double t = k / len;
            double x = n->x + drift * k + sin(k * 0.35 + phase) * 0.35;
            double y = n->y + k;
            if (y >= ground - 1.0)
                break;
            if (frand() < t * t * 0.6)
                continue;
            /* Inside the crown the strand is hidden by the blossom; it only
             * shows once it hangs clear of it. */
            if (px_get_kind((int)floor(x), (int)floor(y)) == PK_BLOOM)
                continue;
            int idx = (int)clampd(1.0 + t * 3.2 + frange(-0.7, 0.7), 0.0, 7.0);
            px_set((int)floor(x), (int)floor(y), F_P0 + idx, PK_BLOOM);
            /* Flowers bunch along the strand. */
            if (frand() < 0.30 * (1.0 - t))
                px_set((int)floor(x) + (frand() < 0.5 ? -1 : 1), (int)floor(y),
                       F_P0 + (idx < 7 ? idx + 1 : 7), PK_BLOOM);
            if (frand() < 0.05)
                add_source((int)floor(x), (int)floor(y) / 2);
        }
    }
}

static void hd_ground(double bx, double rx)
{
    for (int x = 0; x < pw; x++) {
        double dx = (x - bx) / (rx * 1.3);
        double p  = exp(-dx * dx * 2.0);
        int grass = p > 0.55 ? F_GRASS : p > 0.20 ? F_GRASS_M : F_GRASS_D;

        px_set(x, ph - 1, grass, PK_GROUND);
        if (frand() < 0.45 + 0.45 * p)
            px_set(x, ph - 2, frand() < 0.3 ? F_GRASS_M : grass, PK_GROUND);

        /* Fallen petals carpet the ground under the crown. */
        if (frand() < p * 0.45)
            px_set(x, ph - 2, F_P1 + rand() % 3, PK_GROUND);
        if (frand() < p * 0.15)
            px_set(x, ph - 3, F_P1 + rand() % 3, PK_GROUND);
    }
}

static void hd_grow(int form, double fit)
{
    memset(pix,   0, (size_t)pw * ph);
    memset(pkind, 0, (size_t)pw * ph);
    nsources = 0;
    nhnodes = 0;
    nattrs = 0;

    const Form *F = &FORMS[form];
    bool weep = form == STYLE_SHIDARE;

    /* The same layout as the cell tree, in square pixels. */
    double ground  = ph - 3.0;
    double top_pad = gh < 20 ? 2.0 : clampd(ph * 0.06, 2.0, 8.0);
    double tall    = fmax(fmin(ground - top_pad, pw * 0.95) * fit, 8.0);
    double crown   = tall * pick_in(F->crown);
    double wide    = 1.0 + 0.30 * clampd((pw / tall - 2.0) / 2.0, 0.0, 1.0);
    double width   = fmin(pw * F->maxw * fit, tall * pick_in(F->spread) * wide);

    double rx = fmax(width * 0.5, 4.0);
    double ry = fmax(crown * 0.5, 3.0);
    double mid  = pw * 0.5 + frange(-1.0, 1.0) * fmin(2.0, pw * 0.02);
    double lean = frange(-1.0, 1.0) * F->lean * rx;
    double cx = mid + lean * 0.5;
    double cy = ground - tall + ry;
    double bx = mid - lean * 0.5;

    /* Growth step and the two colonisation radii, scaled to the tree. The kill
     * distance has to exceed the step or branches circle their points. */
    double step  = fmax(1.0, tall / 70.0);
    double infl  = step * 7.0;
    double kill  = step * 2.0;
    double scale = clampd(tall / 70.0, 1.0, 3.5);

    hd_ground(bx, rx);

    /*
     * Attraction points fill the crown, whose outline is an ellipse with a
     * few slow lobes so it bulges into clumps instead of tracing a clean oval.
     * The underside is cut off higher on a weeping cherry, which is a dome
     * with its strands doing the rest.
     */
    double ph1 = frange(0.0, 2.0 * M_PI), ph2 = frange(0.0, 2.0 * M_PI);
    double ph3 = frange(0.0, 2.0 * M_PI);
    double cut = weep ? 0.40 : 0.72;
    int want = (int)clampd(M_PI * rx * ry / (kill * kill * 1.6), 40.0, HD_MAX_ATTR);
    for (int tries = 0; nattrs < want && tries < want * 20; tries++) {
        double u = frange(-1.15, 1.15), v = frange(-1.15, 1.15);
        if (v > cut)
            continue;
        double th = atan2(v, u);
        double lobe = 1.0 + 0.13 * sin(3.0 * th + ph1) + 0.08 * sin(5.0 * th + ph2)
                          + 0.05 * sin(7.0 * th + ph3);
        if (u * u + v * v > lobe * lobe)
            continue;
        attrs[nattrs++] = (Attr){ (float)(cx + u * rx), (float)(cy + v * ry), 0.0f, -1 };
    }

    /*
     * A cherry forks low: the trunk splits into a few heavy scaffold limbs
     * that fan out and up into the crown, rather than running straight up to
     * it. A trail of points from the fork out to the underside of the crown
     * draws each of those limbs out, spaced closely enough that the growth
     * never loses sight of the next one.
     */
    double fork_y = ground - tall * (weep ? frange(0.34, 0.42) : frange(0.26, 0.34));
    double crown_b = cy + ry * cut;
    if (fork_y > crown_b) {
        int limbs = 3 + rand() % 3;
        for (int i = 0; i < limbs; i++) {
            /* Kept well inside the crown's underside, which narrows there:
             * a trail ending past its edge grows a lone bare limb. */
            double sx = ((i + 0.5) / limbs * 2.0 - 1.0) * rx * 0.50
                      + frange(-0.06, 0.06) * rx;
            double ex = cx + sx, ey = crown_b + frange(-0.10, 0.15) * ry;
            double len = hypot(ex - bx, ey - fork_y);
            int n = (int)(len / (infl * 0.5)) + 1;
            for (int k = 1; k <= n && nattrs < HD_MAX_ATTR; k++) {
                double t = (double)k / n;
                /* Out first, then up: a scaffold limb spreads before it rises. */
                double tx = 1.0 - (1.0 - t) * (1.0 - t);
                attrs[nattrs++] = (Attr){ (float)(bx + (ex - bx) * tx),
                                          (float)(fork_y + (ey - fork_y) * t),
                                          0.0f, -1 };
            }
        }
    }

    /*
     * The trunk grows up to the fork until the points take over, not
     * straight but along a gentle S: a cherry trunk twists and leans on its
     * way up, and a straight column reads as a post.
     */
    int tip = hd_add_node((float)bx, (float)(ground + 1.0), -1);
    double target_x = cx - lean * 0.1;
    double target_y = fork_y > crown_b ? fork_y : cy + ry * 0.55;
    double sway = frange(-1.0, 1.0) * tall * 0.05;
    for (int guard = 0; guard < 600 && tip >= 0; guard++) {
        HNode *n = &hnodes[tip];
        bool near = false;
        for (int a = 0; a < nattrs && !near; a++)
            near = hypot(attrs[a].x - n->x, attrs[a].y - n->y) < infl;
        if (near || n->y <= target_y)
            break;
        double span = fmax(ground + 1.0 - target_y, 1.0);
        double t    = clampd((ground + 1.0 - (n->y - step)) / span, 0.0, 1.0);
        double want = bx + (target_x - bx) * t + sway * sin(t * M_PI);
        double dx = (want - n->x) / step, dy = -1.0;
        double l = hypot(dx, dy);
        tip = hd_add_node((float)(n->x + dx / l * step), (float)(n->y + dy / l * step), tip);
    }

    for (int a = 0; a < nattrs; a++) {
        attrs[a].d = 1e9f;
        for (int i = 0; i < nhnodes; i++) {
            float d = (float)hypot(attrs[a].x - hnodes[i].x, attrs[a].y - hnodes[i].y);
            if (d < attrs[a].d) {
                attrs[a].d = d;
                attrs[a].near = i;
            }
        }
    }

    /*
     * Colonise. Each point pulls on its nearest node; every node pulled grows
     * one step along the average pull, bent by a tropism: a yoshino's limbs
     * spread outward and their ends arch over, a weeping cherry's droop hard.
     * Points only ever need checking against the nodes added since the last
     * round, since nodes never move.
     */
    double out_k  = weep ? 0.25 : 0.20;
    double down_k = weep ? 0.35 : 0.10;
    for (int iter = 0; iter < 500; iter++) {
        int n0 = nhnodes;
        bool pulled = false;
        memset(hgc, 0, sizeof(int) * (size_t)n0);
        memset(hgx, 0, sizeof(float) * (size_t)n0);
        memset(hgy, 0, sizeof(float) * (size_t)n0);

        /* Should the growth stall with points still out of reach, widen the
         * reach for the round rather than leave part of the crown bare. */
        for (double reach = infl; !pulled && reach <= infl * 8.0; reach *= 2.0) {
            for (int a = 0; a < nattrs; a++) {
                Attr *at = &attrs[a];
                if (at->near < 0 || at->d > reach)
                    continue;
                const HNode *n = &hnodes[at->near];
                hgx[at->near] += (float)((at->x - n->x) / fmax(at->d, 1e-3));
                hgy[at->near] += (float)((at->y - n->y) / fmax(at->d, 1e-3));
                hgc[at->near]++;
                pulled = true;
            }
        }
        if (!pulled)
            break;

        for (int i = 0; i < n0; i++) {
            if (!hgc[i] || hnodes[i].kids >= 3)
                continue;
            const HNode *n = &hnodes[i];
            double dx = hgx[i], dy = hgy[i];
            double l = hypot(dx, dy);
            if (l < 1e-3) {
                dx = frange(-1.0, 1.0);
                dy = -1.0;
                l = hypot(dx, dy);
            }
            double off = (n->x - cx) / rx;
            dx = dx / l + off * out_k;
            dy = dy / l + fabs(off) * down_k;
            l = hypot(dx, dy);
            float nx = (float)(n->x + dx / l * step), ny = (float)(n->y + dy / l * step);

            /* Two points pulling a node the same way would stack children on
             * one spot, round after round. */
            if (n->last >= 0 && hypot(hnodes[n->last].x - nx, hnodes[n->last].y - ny) < step * 0.5)
                continue;
            if (hd_add_node(nx, ny, i) < 0)
                break;
        }
        if (nhnodes == n0)
            break;

        for (int a = 0; a < nattrs; a++) {
            Attr *at = &attrs[a];
            if (at->near < 0)
                continue;
            for (int j = n0; j < nhnodes; j++) {
                float d = (float)hypot(at->x - hnodes[j].x, at->y - hnodes[j].y);
                if (d < at->d) {
                    at->d = d;
                    at->near = j;
                }
            }
            if (at->d < kill)
                at->near = -1;
        }
    }

    /*
     * Thickness follows the pipe model: a limb carries what its branches
     * carry, r^2.4 summed at each fork. Children always come after their
     * parent, so one backward pass settles every radius. The result is scaled
     * so the trunk keeps the same proportion to the tree at every size.
     */
    memset(hacc, 0, sizeof(double) * (size_t)nhnodes);
    for (int i = nhnodes - 1; i >= 0; i--) {
        HNode *n = &hnodes[i];
        n->r = n->kids == 0 ? 0.35f : (float)pow(hacc[i], 1.0 / 2.4);
        if (n->parent >= 0)
            hacc[n->parent] += pow(n->r, 2.4);
    }
    double k = clampd(tall * 0.040 / fmax(hnodes[0].r, 0.1), 0.4, 3.0);
    for (int i = 0; i < nhnodes; i++) {
        HNode *n = &hnodes[i];
        n->r = (float)fmax(n->r * k, 0.35);
        /* Gentle root flare where the trunk meets the ground. */
        double up = (ground - n->y) / (tall * 0.08);
        if (up < 1.0)
            n->r *= (float)(1.0 + 0.6 * (1.0 - fmax(up, 0.0)));
    }

    hd_draw_wood();
    hd_foliage(form, cy, ry, scale);
    if (weep)
        hd_curtains(cx, rx, ground);
}

/*
 * The blossom spreads past the outline the tree was laid out in: the flower
 * round the branch tips, strands hanging off them. So the tree is
 * measured once it has grown, and grown again a little smaller should it run
 * off the top or the sides of the screen, rather than being cut off there.
 */
static void gen_tree_hd(void)
{
    int form = pick_form();
    double margin = gh < 20 ? 1.0 : 2.0;
    double ground = ph - 3.0, mid = pw * 0.5;
    double fit = 1.0;

    for (int attempt = 0; attempt < 4; attempt++) {
        hd_grow(form, fit);

        int top = ph, left = pw, right = -1;
        for (int y = 0; y < ph - 3; y++) {
            for (int x = 0; x < pw; x++) {
                int k = pkind[(size_t)y * pw + x];
                if (k != PK_WOOD && k != PK_BLOOM)
                    continue;
                if (y < top)   top = y;
                if (x < left)  left = x;
                if (x > right) right = x;
            }
        }
        if (right < 0 || (top >= margin && left >= margin && right <= pw - 1 - margin))
            return;

        double s = 1.0;
        if (top < margin)
            s = fmin(s, (ground - margin) / (ground - top));
        if (left < margin && left < mid)
            s = fmin(s, (mid - margin) / (mid - left));
        if (right > pw - 1 - margin && right > mid)
            s = fmin(s, (pw - 1 - margin - mid) / (right - mid));
        fit *= s * 0.97;
    }
}

static void draw_hd(void)
{
    memcpy(frame, pix, (size_t)pw * ph);

    /* Petals fall at pixel resolution, half a cell at a time. */
    for (int i = 0; i < npetals; i++) {
        const Petal *p = &petals[i];
        if (!p->active)
            continue;
        int x = (int)p->x, y = (int)(p->y * 2.0);
        if (x < 0 || x >= pw || y < 0 || y >= ph)
            continue;
        frame[(size_t)y * pw + x] = HC(p->fg);
    }

    for (int y = 0; y < gh; y++) {
        for (int x = 0; x < gw; x++) {
            int top = frame[(size_t)(2 * y) * pw + x];
            int bot = frame[(size_t)(2 * y + 1) * pw + x];
            if (!top && !bot)
                continue;
            /* An empty pixel stays the terminal's own background, so a
             * transparent terminal still shows through round the tree. */
            short pair = top ? hd_pair(top, bot) : hd_pair(bot, 0);
            attron(COLOR_PAIR(pair));
            mvaddstr(y, x, top ? "▀" : "▄");
            attroff(COLOR_PAIR(pair));
        }
    }
}

/* ---------- petals ---------- */

static void spawn_petal(Petal *p, bool scatter)
{
    const char **glyphs = opt_ascii ? petal_asc : petal_uni;

    p->active = true;
    p->rest   = -1.0;

    if (nsources > 0 && frand() < 0.85) {
        Coord c = sources[rand() % nsources];
        p->x = c.x + frange(-1.0, 1.0);
        p->y = c.y + frange(0.0, 1.0);
    } else {
        p->x = frand() * gw;
        p->y = -frange(0.0, 3.0);
    }
    if (scatter)
        p->y = frange(0.0, gh - 2.0);

    p->vy    = frange(0.10, 0.28);
    p->amp   = frange(0.10, 0.45);
    p->freq  = frange(0.05, 0.18);
    p->phase = frand() * 2.0 * M_PI;
    p->glyph = glyphs[rand() % 5];
    /* Keep petals in the light half of the ramp — the dark end vanishes
     * against the canopy they fall out of. */
    p->fg    = (unsigned char)(F_P0 + rand() % 4);
}

static void reset_petals(bool scatter)
{
    npetals = gw * opt_density / 4;
    if (npetals < 16)          npetals = 16;
    if (npetals > MAX_PETALS)  npetals = MAX_PETALS;

    for (int i = 0; i < MAX_PETALS; i++)
        petals[i].active = false;
    for (int i = 0; i < npetals; i++)
        if (frand() < 0.6)
            spawn_petal(&petals[i], scatter);
}

static void update_petals(double dt)
{
    if (frand() < 0.008)
        wind_target = frange(-0.12, 0.45) * opt_wind;
    wind += (wind_target - wind) * 0.02;

    for (int i = 0; i < npetals; i++) {
        Petal *p = &petals[i];

        if (!p->active) {
            if (frand() < 0.03)
                spawn_petal(p, false);
            continue;
        }

        if (p->rest >= 0.0) {
            p->rest -= dt;
            if (p->rest < 0.0)
                p->active = false;
            continue;
        }

        p->phase += p->freq;
        p->x += wind + p->amp * sin(p->phase);
        p->y += p->vy;

        if (p->x < -2.0)          p->x = gw + 1.0;
        else if (p->x > gw + 2.0) p->x = -1.0;

        if (p->y >= gh - 1.0) {
            p->y     = gh - 1.0;
            p->rest  = frange(2.0, 7.0);
            p->fg    = F_FADED;
            p->glyph = g_dot();
        }
    }
}

/* ---------- rendering ---------- */

static void draw(void)
{
    erase();

    if (use_hd()) {
        draw_hd();
        refresh();
        return;
    }

    for (int y = 0; y < gh; y++) {
        for (int x = 0; x < gw; x++) {
            const Cell *c = &grid[(size_t)y * gw + x];
            if (!c->glyph)
                continue;
            attr_t a = COLOR_PAIR(pair_of(c->fg, c->bg)) | (c->bold ? A_BOLD : 0);
            attron(a);
            mvaddstr(y, x, c->glyph);
            attroff(a);
        }
    }

    for (int i = 0; i < npetals; i++) {
        const Petal *p = &petals[i];
        if (!p->active)
            continue;
        int px = (int)p->x, py = (int)p->y;
        if (px < 0 || px >= gw || py < 0 || py >= gh)
            continue;
        /* A petal passes behind solid blossom and wood. Drawn over them it
         * replaces the block with the cell's dark background, a black speck in
         * the middle of the crown. Over the thin fringe it keeps that
         * background, so it doesn't cut a terminal-coloured hole either. */
        const Cell *c = &grid[(size_t)py * gw + px];
        if (c->glyph && (c->kind == K_WOOD || c->kind == K_CANOPY)
                && c->glyph != g_lite() && c->glyph != g_med())
            continue;
        int bg = c->glyph ? c->bg : B_DEF;
        attr_t a = COLOR_PAIR(pair_of(p->fg, bg));
        attron(a);
        mvaddstr(py, px, p->glyph);
        attroff(a);
    }

    refresh();
}

static void resize_grid(void)
{
    gw = COLS;
    gh = LINES;
    pw = gw;
    ph = gh * 2;
    free(grid);
    free(pix);
    free(pkind);
    free(frame);
    grid  = calloc((size_t)gw * gh, sizeof(Cell));
    pix   = calloc((size_t)pw * ph, 1);
    pkind = calloc((size_t)pw * ph, 1);
    frame = calloc((size_t)pw * ph, 1);
    if (!grid || !pix || !pkind || !frame) {
        endwin();
        fprintf(stderr, "csakura: out of memory\n");
        exit(1);
    }
}

static void regrow(bool scatter)
{
    if (use_hd())
        gen_tree_hd();
    else
        gen_tree();
    reset_petals(scatter);
}

static void usage(FILE *out)
{
    fprintf(out,
        "usage: csakura [options]\n"
        "\n"
        "a sakura tree with falling petals for your terminal\n"
        "\n"
        "options:\n"
        "  -f FPS    frames per second, 5-60 (default: 20)\n"
        "  -p NUM    petal density, 1-10 (default: 5)\n"
        "  -w NUM    wind strength, 0-10 (default: 1)\n"
        "  -c NAME   blossom palette (default: sakura)\n"
        "  -s STYLE  tree form: yoshino, bush, shidare (weeping), or\n"
        "            random for a new one each regrow (default: yoshino)\n"
        "  -d        detail mode: a finer, fully branched tree drawn\n"
        "            in half-block pixels (needs 256 colours)\n"
        "  -a        ASCII glyphs only (no unicode blossoms)\n"
        "  -t        flat mode: never paint cell backgrounds, so a\n"
        "            transparent terminal shows through the canopy\n"
        "  -k        any key quits (not just q/Esc); for use as an\n"
        "            idle screensaver that dismisses on any keypress\n"
        "  -C N      every N seconds, grow a fresh tree in the next\n"
        "            form and the next palette (0 = off)\n"
        "  -H COLOR  canopy shadow colour, 0-255, or none to leave the\n"
        "            shadow unpainted (default: the palette's own shade)\n"
        "  -h        show this help\n"
        "  -v        show version\n"
        "\n"
        "palettes:\n"
        "  ");
    for (int i = 0; i < NPALETTES; i++) {
        fprintf(out, "%s%s", PALETTES[i].name, i + 1 < NPALETTES ? ", " : "\n");
        if ((i + 1) % 5 == 0 && i + 1 < NPALETTES)
            fprintf(out, "\n  ");
    }
    fprintf(out,
        "\n"
        "keys:\n"
        "  q / Esc   quit\n"
        "  r         regrow the tree\n"
        "  c / C     next / previous color palette\n"
        "  s         next tree form (yoshino / bush / shidare / random)\n"
        "  d         toggle detail mode\n"
        "  a         toggle ASCII glyphs\n"
        "  t         toggle flat (transparent) mode\n"
        "  p / P     more / fewer petals\n"
        "  w / W     more / less wind\n"
        "  + / -     faster / slower\n");
}

int main(int argc, char **argv)
{
    int opt;
    while ((opt = getopt(argc, argv, "f:p:w:c:s:adH:kC:thv")) != -1) {
        switch (opt) {
        case 'f':
            opt_fps = atoi(optarg);
            if (opt_fps < 5)  opt_fps = 5;
            if (opt_fps > 60) opt_fps = 60;
            break;
        case 'p':
            opt_density = atoi(optarg);
            if (opt_density < 1)  opt_density = 1;
            if (opt_density > 10) opt_density = 10;
            break;
        case 'w':
            opt_wind = atof(optarg);
            if (opt_wind < 0.0)  opt_wind = 0.0;
            if (opt_wind > 10.0) opt_wind = 10.0;
            break;
        case 'c': {
            int idx = find_palette(optarg);
            if (idx < 0) {
                fprintf(stderr, "csakura: unknown palette '%s'\n", optarg);
                fprintf(stderr, "try: ");
                for (int i = 0; i < NPALETTES; i++)
                    fprintf(stderr, "%s%s", PALETTES[i].name,
                            i + 1 < NPALETTES ? ", " : "\n");
                return 1;
            }
            opt_palette = idx;
            break;
        }
        case 's': {
            int idx = -1;
            for (int i = 0; i < NSTYLES; i++)
                if (strcmp(optarg, STYLE_NAMES[i]) == 0)
                    idx = i;
            if (idx < 0) {
                fprintf(stderr, "csakura: unknown style '%s', want yoshino, "
                        "bush, shidare or random\n", optarg);
                return 1;
            }
            opt_style = idx;
            break;
        }
        case 'a':
            opt_ascii = true;
            break;
        case 'd':
            opt_detail = true;
            break;
        case 'H':
            if (!parse_haze(optarg, &opt_haze)) {
                fprintf(stderr,
                        "csakura: bad shadow colour '%s', want 0-255 or none\n",
                        optarg);
                return 1;
            }
            break;
        case 't':
            opt_flat = true;
            break;
        case 'k':
            opt_anykey = true;
            break;
        case 'C':
            opt_cycle = atoi(optarg);
            if (opt_cycle < 0) opt_cycle = 0;
            break;
        case 'v':
            printf("csakura %s\n", VERSION);
            return 0;
        case 'h':
            usage(stdout);
            return 0;
        default:
            usage(stderr);
            return 1;
        }
    }

    setlocale(LC_ALL, "");
    srand((unsigned)(time(NULL) ^ getpid()));

    signal(SIGINT, on_signal);
    signal(SIGTERM, on_signal);

    initscr();
    noecho();
    cbreak();
    curs_set(0);
    keypad(stdscr, TRUE);
    nodelay(stdscr, TRUE);

    if (has_colors())
        init_colors();

    resize_grid();
    regrow(true);

    time_t last_cycle = time(NULL);

    while (running) {
        int ch = getch();
        if (ch == 'q' || ch == 'Q' || ch == 27)
            break;
        /* -k: dismiss on any real keypress (ERR = no key this poll; a window
         * resize is not a keypress, so keep blooming and just re-layout). */
        if (opt_anykey && ch != ERR && ch != KEY_RESIZE)
            break;
        switch (ch) {
        case 'r': case 'R':
            regrow(false);
            break;
        case 'c':
            opt_palette = (opt_palette + 1) % NPALETTES;
            apply_palette();
            regrow(false);
            break;
        case 'C':
            opt_palette = (opt_palette + NPALETTES - 1) % NPALETTES;
            apply_palette();
            regrow(false);
            break;
        case 's': case 'S':
            opt_style = (opt_style + 1) % NSTYLES;
            regrow(false);
            break;
        case 'a': case 'A':
            opt_ascii = !opt_ascii;
            regrow(false);
            break;
        case 'd': case 'D':
            opt_detail = !opt_detail;
            regrow(false);
            break;
        case 't': case 'T':
            opt_flat = !opt_flat;
            update_shaded();
            apply_palette();
            regrow(false);
            break;
        case 'p':
            if (opt_density < 10) { opt_density++; reset_petals(false); }
            break;
        case 'P':
            if (opt_density > 1)  { opt_density--; reset_petals(false); }
            break;
        case 'w':
            if (opt_wind < 10.0) opt_wind = fmin(10.0, opt_wind + 1.0);
            break;
        case 'W':
            if (opt_wind > 0.0)  opt_wind = fmax(0.0, opt_wind - 1.0);
            break;
        case '+': case '=':
            if (opt_fps < 60) opt_fps += 5;
            break;
        case '-': case '_':
            if (opt_fps > 5)  opt_fps -= 5;
            break;
        case KEY_RESIZE:
            resize_grid();
            regrow(true);
            break;
        }

        /* -C N: every N seconds, advance to the next palette AND the next
         * tree form (yoshino -> bush -> shidare -> ...), then regrow so both
         * the colours and the silhouette cycle. */
        if (opt_cycle > 0 && difftime(time(NULL), last_cycle) >= opt_cycle) {
            opt_palette = (opt_palette + 1) % NPALETTES;
            opt_style   = (opt_style + 1) % NFORMS;
            apply_palette();
            regrow(false);
            last_cycle = time(NULL);
        }

        update_petals(1.0 / opt_fps);
        draw();
        napms(1000 / opt_fps);
    }

    endwin();
    free(grid);
    free(pix);
    free(pkind);
    free(frame);
    return 0;
}
