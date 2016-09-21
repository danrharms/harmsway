#!/usr/bin/env sh
# -*- Mode: sh -*-
# repo-init.sh --- select a repo to initialize
# Copyright (C) 2016  Dan Harms (dharms)
# Author: Dan Harms <danielrharms@gmail.com>
# Created: Thursday, September 15, 2016
# Version: 1.0
# Modified Time-stamp: <2016-09-15 08:27:37 dharms>
# Modified by: Dan Harms
# Keywords: repo src

echo "Install which project?"
proj=$(_dirselect.sh ~/config/repos "Select a project: ")
if [ -z "$proj" ]; then
    echo "!!! No project selected; exiting..."
    exit 1
fi

echo "Which version of $proj should be installed?"
ver=$(_dirselect.sh ~/config/repos/$proj "Select a version: ")
if [ -z "$ver" ]; then
    echo "!!! No version of $proj selected; exiting..."
    exit 1
fi

target=~/config/repos/$proj/$ver/repo-init.sh
if [ ! -f "$target" ]; then
    echo "!!! $target not present; exiting..."
    exit 1
fi

$target $proj $ver $1

# code ends here