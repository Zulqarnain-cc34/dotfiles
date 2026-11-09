#!/bin/python3
import json
import os
import subprocess
import sys

BOOKMARKS = os.path.expanduser("~/.local/share/Bookmarks")

if len(sys.argv) == 1:
    with open(BOOKMARKS) as bookmarks:
        dict_data = json.load(bookmarks)
        for bookmark_info in dict_data["roots"]["bookmark_bar"]["children"]:
            print(bookmark_info["name"])
else:
    with open(BOOKMARKS) as bookmarks:
        dict_data = json.load(bookmarks)
        for bookmark_info in dict_data["roots"]["bookmark_bar"]["children"]:
            url = bookmark_info["url"]
            if (" ".join(sys.argv[1:]) == bookmark_info["name"]):
                subprocess.Popen(["firefox", url],
                                 text=True,
                                 stdout=subprocess.DEVNULL,
                                 stderr=subprocess.DEVNULL)
