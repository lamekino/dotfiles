#!/usr/bin/env python3

import sys
import subprocess as sp


def ydotool(keycode: int) -> None:
    sp.call(["ydotool", "key", f"{keycode}:1", f"{keycode}:0"])


# sends the function key (F1-F24) given from argv[1] using ydotool
if __name__ == "__main__":
    keycodes = [59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 87, 88, 183, 184, 185,
                186, 187, 188, 189, 190, 191, 192, 193, 194]

    keymap = {f"F{n}": code for n, code in enumerate(keycodes)}

    match sys.argv:
        case [_, arg] if arg in keymap.keys():
            ydotool(keymap[arg])
            sys.exit(0)
        case _:
            print("Invalid arguments.", file=sys.stderr)
            sys.exit(1)
