# Redshift

A night-time colour-temperature adjuster, and the one that matters most here — it runs in the primary X11 (BSPWM) session, warming the screen as the evening wears on.

Location is set manually, defaulting to Islamabad (lat/lon `33.6844` / `73.0479`). The day temperature sits at 6500K and eases down to 5000K at night, with gamma `0.8:0.7:0.8`, `adjust-method=clip`, and a smooth transition between the two. There's no keybind — start it from your X autostart (`redshift &` in `bspwm/bspwmrc`, say) or just run `redshift`. It reads `~/.config/redshift/redshift.conf`, which `setup.sh` symlinks from here.

### Setup

Install `redshift` (it's in `packages/minimal.txt`). Everything lives in [`redshift.conf`](redshift.conf) — location, day/night temps, gamma, and adjust method. Edit `lat`/`lon` for your own city. The Wayland/niri equivalent is [`gammastep/`](../gammastep); if you change coordinates, update both so they stay in step.
