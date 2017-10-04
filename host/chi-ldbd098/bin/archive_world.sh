#!/usr/bin/env sh
# -*- Mode: sh -*-
# archive_world.sh --- archive a host's vital files
# Copyright (C) 2016-2017  Dan Harms (dharms)
# Author: Dan Harms <danielrharms@gmail.com>
# Created: Tuesday, August  9, 2016
# Version: 1.0
# Modified Time-stamp: <2017-10-04 09:43:23 dan.harms>
# Modified by: Dan Harms
# Keywords: archive backup

target=${1:-~/backups}
date=$( date '+%Y%m' )

_backup.sh ~/src/harmsway/site/xr "$target-$date"
_backup.sh ~/src/harmsway/host/chi-ldbd098 "$target-$date"
_backup.sh ~/src/harmsway/host/CHIHQ-DEV84 "$target-$date"
_backup.sh ~/src/harmsway/host/CHIHQ-IPC201 "$target-$date"

# code ends here
