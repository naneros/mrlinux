#!/bin/bash

sudo rsync -aAXv --delete / --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/home"} ~/copia

