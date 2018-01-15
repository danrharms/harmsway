@echo off
rem -*- Mode: bat -*-
rem emacs.bat --- batch file for emacs on dos
rem Copyright (C) 2018  Dan Harms (dan.harms)
rem Author: Dan Harms <dan.harms@xrtrading.com>
rem Created: Friday, January 12, 2018
rem Version: 1.0
rem Modified Time-stamp: <2018-01-15 10:20:07 dan.harms>
rem Modified by: Dan Harms
rem Keywords: tools win32

setlocal
setlocal enabledelayedexpansion

%EMACS%\bin\emacs.exe -nw %*

endlocal

rem code ends here
