#!/usr/bin/env python3
# Render the live fastfetch output to a PNG demo image (assets/fastfetch_demo.png
# and fastfetch/preview.png). This renders the real ANSI output with the kitty
# tokyonight palette and the SauceCodePro Nerd Font -- it does NOT screenshot any
# window. Dev tool; needs Pillow. Run it from the repo root after config changes:
#   python3 fastfetch/scripts/render-demo.py
import re, os, subprocess
from PIL import Image, ImageDraw, ImageFont

REPO = os.path.realpath(os.path.join(os.path.dirname(__file__), "..", ".."))
FONTDIR = os.path.expanduser("~/.local/share/fonts/SauceCodePro")
MONO_REG = f"{FONTDIR}/SauceCodeProNerdFontMono-Regular.ttf"
MONO_BLD = f"{FONTDIR}/SauceCodeProNerdFontMono-Bold.ttf"
SIZE = 34

# tokyonight, from kitty/kitty.conf
PAL = {'30':'#414868','90':'#414868','31':'#f7768e','91':'#f7768e',
       '32':'#73daca','92':'#73daca','33':'#e0af68','93':'#e0af68',
       '34':'#7aa2f7','94':'#7aa2f7','35':'#bb9af7','95':'#bb9af7',
       '36':'#7dcfff','96':'#7dcfff','37':'#c0caf5','97':'#c0caf5'}
FG = '#a9b1d6'; BG = (0x24,0x28,0x3b)

cfg = f"{REPO}/fastfetch/config.jsonc"
# Run fastfetch under the login shell (zsh), not directly: fastfetch reads the
# Shell field from its PARENT process, so a direct subprocess call would report
# "python". The trailing "; true" matters -- without a following command zsh
# exec-replaces itself with fastfetch, making python the parent again.
raw = subprocess.run(["zsh","-c", f"fastfetch -c '{cfg}' --logo none --pipe false; true"],
                     capture_output=True, text=True).stdout
# fastfetch reports the terminal it runs under; outside a real kitty (e.g. in CI
# or an agent pty) that is wrong, so normalise it to the real terminal, kitty.
try:
    kver = subprocess.run(["kitty","--version"], capture_output=True, text=True).stdout.split()[1]
    raw = re.sub(r"(Terminal\S*\s*\x1b\[\d+G\x1b\[m)[^\n]*", rf"\g<1>kitty {kver}", raw, count=1)
except Exception:
    pass

lines = raw.split("\n")
while lines and lines[-1].strip() == "":
    lines.pop()

grid = []; maxcol = 0
for line in lines:
    cells = {}; col = 0; color = FG; bold = False; i = 0
    while i < len(line):
        if line[i] == "\x1b":
            m = re.match(r"\x1b\[([0-9;]*)([A-Za-z])", line[i:])
            if not m:
                i += 1; continue
            params, fin = m.group(1), m.group(2)
            if fin == "m":
                for code in (params.split(";") if params else ["0"]):
                    if code in ("","0"): color=FG; bold=False
                    elif code=="1": bold=True
                    elif code=="22": bold=False
                    elif code=="39": color=FG
                    elif code in PAL: color=PAL[code]
            elif fin == "G":
                col = (int(params)-1) if params else 0
            i += m.end(); continue
        cells[col] = (line[i], color, bold); maxcol = max(maxcol, col); col += 1; i += 1
    grid.append(cells)

fR = ImageFont.truetype(MONO_REG, SIZE); fB = ImageFont.truetype(MONO_BLD, SIZE)
cw = fR.getlength("M"); asc, desc = fR.getmetrics(); lh = int((asc+desc)*1.05)
pad = int(cw*2); panel_w = int((maxcol+2)*cw); panel_h = int(len(grid)*lh)

logo = Image.open(f"{REPO}/fastfetch/images/arch.png").convert("RGBA")
scale = int(panel_h*0.74) / logo.height
logo = logo.resize((int(logo.width*scale), int(panel_h*0.74)), Image.LANCZOS)

gap = int(cw*3)
W = pad + logo.width + gap + panel_w + pad; H = pad + panel_h + pad
img = Image.new("RGB", (W, H), BG)
img.paste(logo, (pad, (H-logo.height)//2), logo)
draw = ImageDraw.Draw(img)
x0 = pad + logo.width + gap
for r, cells in enumerate(grid):
    for col,(chx,color,bold) in cells.items():
        if chx != " ":
            draw.text((x0+col*cw, pad+r*lh), chx, font=(fB if bold else fR), fill=color)

for out in (f"{REPO}/assets/fastfetch_demo.png", f"{REPO}/fastfetch/preview.png"):
    img.save(out); print(f"wrote {out}  {img.size}")
