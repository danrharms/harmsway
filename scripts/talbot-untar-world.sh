#!/usr/bin/env sh
# -*- Mode: sh -*-
# talbot-untar-world.sh --- untar important files
# Copyright (C) 2015  Dan Harms (dan.harms)
# Author: Dan Harms <dan.harms@xrtrading.com>
# Created: Monday, May 18, 2015
# Version: 1.0
# Modified Time-stamp: <2015-07-25 12:54:50 dharms>
# Keywords: configuration

tar=/usr/bin/gnutar
input=

if [ $# -gt 0 ] ; then
   input=$1
   shift
fi

if [ "x$input" = "x" ] ; then
   echo "Error: need an input file."
   exit
fi

date=$(date '+%F_%T' | tr ':' '-')

# remove and backup .emacs.d
if [ -d ~/.emacs.d ] ; then
   $tar czf ~/.emacs.d.bk_$date.tgz --force-local ~/.emacs.d
   rm -rf ~/.emacs.d
fi
# # remove and backup .ssh
# if [ -d ~/.ssh ] ; then
#    $tar czf ~/.ssh.bk_$date.tgz --force-local .ssh
#    rm -rf ~/.ssh
# fi

echo About to unpack $input...
$tar -C ~ --overwrite -xpvf $input

# # adjust .ssh
# pushd ~/.ssh
# ln -sf id_rsa_drh_npp id_rsa
# ln -sf Dan.Harms.pub id_rsa.pub
# chmod 600 ~/.ssh/id_rsa
# popd

# remove intermediate directories, if empty
pushd ~
rmdir -p bash tcsh talbot
# and byte-compile emacs
emacscomp.sh .emacs.d
popd

# talbot-untar-world.sh ends here
