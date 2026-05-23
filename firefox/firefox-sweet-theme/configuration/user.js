/* user.js
 * https://github.com/rafaelmardojai/firefox-gnome-theme/
 * dotfiles_v2: force 100% zoom (niri 1.25x scale was reading as >100%)
 */

// Enable customChrome.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Enable CSD
user_pref("browser.tabs.drawInTitlebar", true);

// 100% UI + page density (default -1 follows system/Wayland scale → looked zoomed in)
user_pref("layout.css.devPixelsPerPx", "1.0");

// One global page zoom at 100% for all sites
user_pref("browser.zoom.siteSpecific", false);

// DevTools toolbox zoom (was 110% in prefs.js)
user_pref("devtools.toolbox.zoomValue", "1");
