#!/bin/bash

sudo rsync -aAXv --delete ~/copia/ --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/home"} /
