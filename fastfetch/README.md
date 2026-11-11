<div align="center">
  <img src="../assets/fastfetch.svg" width="76" alt="Fastfetch logo"><br><br>
  <h1>Fastfetch</h1>
  <p><em>A fast system-info fetch for the terminal.</em></p>
  <a href="https://github.com/fastfetch-cli/fastfetch"><img src="https://img.shields.io/badge/upstream-fastfetch--cli%2Ffastfetch-61afef?style=flat-square&logo=github&logoColor=white" alt="upstream"></a>
  <a href="https://github.com/fastfetch-cli/fastfetch/stargazers"><img src="https://img.shields.io/github/stars/fastfetch-cli/fastfetch?style=flat-square&color=ffce63&labelColor=1a1b26" alt="stars"></a>
  <img src="https://img.shields.io/badge/license-MIT-7aa2f7?style=flat-square&labelColor=1a1b26" alt="license">
</div>

> Built on **[Fastfetch](https://github.com/fastfetch-cli/fastfetch)** by Carter Li & contributors. ❤️

A fast system-info fetch for the terminal — the little logo-and-specs banner that greets you on shell start. This config is tuned for Arch with a custom module layout and a choice of ASCII or image logos.

![Preview](preview.png)

### What's here

The layout lives in [`config.jsonc`](config.jsonc) — which modules appear (OS, kernel, uptime, packages, WM, terminal, and so on), their order, and the colours. Logos come in two flavours: text art under [`ascii/`](ascii/) (`arch`, `cat`, `rose`, `triangle`) and raster images under [`images/`](images/) and [`pngs/`](pngs/). Point the `logo` block in `config.jsonc` at whichever one you're in the mood for.
