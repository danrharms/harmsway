;;; early-init.el --- Early initialization options for Emacs
;; Copyright (C) 2020  Dan.Harms (Dan.Harms)
;; Author: Dan.Harms <dan.harms@xrtrading.com>
;; Created: Tuesday, January 14, 2020
;; Modified Time-stamp: <2020-01-14 08:47:21 Dan.Harms>
;; Modified by: Dan.Harms
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;; Early init options.
;;

;;; Code:

(setq package-enable-at-startup nil)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;;; early-init.el ends here
