# -*- Mode: gdb-script -*-
# .gdbinit --- gdb configuration file
# Copyright (C) 2015, 2017  Dan Harms (dan.harms)
# Author: Dan Harms <dan.harms@xrtrading.com>
# Created: Thursday, June 11, 2015
# Version: 1.0
# Modified Time-stamp: <2017-08-14 11:36:27 dan.harms>
# Modified by: Dan Harms
# Keywords: configuration

# C++ pretty-printing
source ~/config/stl-views.gdb
set print frame-arguments all

# save history
set history save
set history filename ~/.gdb_history
set history size 10000
set history expansion on

# disable auto-loading checks
set auto-load safe-path /

# quit immediately
define qquit
  set confirm off
  quit
end
document qquit
  Quit without asking for confirmation.
end

# skip stepping into a function
define skipfin
  dont-repeat
  skip
  finish
end
document skipfin
  Return from the current function and skip over all future calls to it.
end

# .gdbinit ends here
