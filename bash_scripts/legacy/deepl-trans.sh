#!/bin/bash

test="$(xclip -o -sel prim)"

$BROWSER "https://www.deepl.com/translator#ja/en/$test"
