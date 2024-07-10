#!/usr/bin/env python3
import os
import sys

blacklist = [
    "_",
    "OLDPWD",
    "PWD",
    "SHLVL",
    "TERM",
]

envdir = sys.argv[1]

for name, val in filter(lambda var: var[0] not in blacklist,
                        os.environ.items()):
    with open(os.path.join(envdir, name), "w") as file:
        file.write(val)
