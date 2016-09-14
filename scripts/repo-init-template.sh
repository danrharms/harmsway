#!/usr/bin/env sh
# -*- Mode: sh -*-
# repo-init-template.sh --- init a src repo
# Copyright (C) 2016  Dan Harms (dan.harms)
# Author: Dan Harms <dan.harms@xrtrading.com>
# Created: Tuesday, May  3, 2016
# Version: 1.0
# Modified Time-stamp: <2016-09-14 08:59:22 dan.harms>
# Modified by: Dan Harms
# Keywords: src repo

proj=proj
echo "Which version of $proj should be installed?"
ver=$(_dirselect.sh ~/config/repos/$proj)

if [ -z "$ver" ]; then
   echo "No version selected; exiting..."
   exit 1
fi
echo "Using $proj version $ver"

subdir=${1:-$proj-$ver}

_yesorno.sh "Clone $proj into $(pwd)/$subdir/proj?"
[ $? == 1 ] && exit

if [ ! -d $subdir/$proj/.git ]; then
    mkdir -p $subdir
    # git clone ssh://git@addr:7999/proj/proj.git $subdir/proj
fi

cd $subdir

setupf=$proj-setup.sh
prof=$proj-$ver.eprof
envf=$proj.env

cp -f ~/config/repos/$proj/$ver/$setupf repo-setup.sh
cp -f ~/config/repos/$proj/$ver/$prof .
cp -f ~/config/repos/$proj/$ver/$envf .repo-env

if [ ! -d $proj/.git/hooks ]; then
   echo "! $proj repo missing; install first."
   exit 1
fi

# code ends here
