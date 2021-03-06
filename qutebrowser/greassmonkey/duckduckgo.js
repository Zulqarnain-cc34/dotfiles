// ==UserScript==
// @name        Duckduckgo custom CSS
// @namespace   https://github.com/olmokramer
// @description Custom CSS for *.duckduckgo.com
// @include     *.duckduckgo.com
// @include     *duckduckgo.com
// @run-at      document-start
// @version     2
// @author      Olmo Kramer
// ==/UserScript==

(function IIFE() {
	'use strict';

	document.addEventListener('readystatechange', function onReadyStateChange() {
		if (document.readyState == 'interactive') {
			const style = document.createElement('style');
			document.head.appendChild(style);
			style.innerHTML = `
* {
  border-color: #fabd2f !important;
}
a {
  color: #458588 !important;
}
a:visited {
  color: #d3869b !important;
}
body {
  background-color: #282828 !important;
  color: #83a598 !important;
}
html {
  background-color: #282828 !important;
}
input,
textarea {
  background-color: #3c3836 !important;
  color: #83a598 !important;
}
blockquote,
pre {
  background-color: #3c3836 !important;
  color: #83a598 !important;
}
.search--adv {
  background-color: #3c3836 !important;
}
.search__autocomplete > .acp-wrap {
  background-color: #282828 !important;
}
.search__autocomplete > .acp-wrap > .acp--highlight {
  background-color: #3c3836 !important;
  color: #a89984 !important;
}
.search__autocomplete > .acp-wrap strong {
  color: #a89984 !important;
}
.site-wrapper > #header_wrapper {
  background-color: #282828 !important;
}
.site-wrapper > #header_wrapper > #header {
  background-color: #282828 !important;
}
.search--header {
  background-color: #3c3836 !important;
}
.zci {
  background-color: #3c3836 !important;
  color: #83a598 !important;
}
.tile--info {
  background-color: #282828 !important;
}
.tile--info__expand {
  background-color: #b8bb26 !important;
}
.tile--c {
  background-color: #b8bb26 !important;
  color: #a89984 !important;
}
.module__text {
  color: #83a598 !important;
}
.about-info-box__heading {
  color: #8ec07c !important;
}
.result.highlight {
  background-color: #3c3836 !important;
}
.result__snippet {
  color: #83a598 !important;
}
.result__snippet b {
  color: #8ec07c !important;
}
.btn--top {
  background-color: #3c3836 !important;
  color: #83a598 !important;
}
.btn--top:hover {
  background-color: #b8bb26 !important;
}
.result--sep--hr:before {
  background-color: #b8bb26 !important;
}

			`;
		}
	});
})();
