############################################################################
##
## Copyright (C) 2017 The Qt Company Ltd.
## Contact: https://www.qt.io/licensing/
##
## This file is part of the provisioning scripts of the Qt Toolkit.
##
## $QT_BEGIN_LICENSE:LGPL$
## Commercial License Usage
## Licensees holding valid commercial Qt licenses may use this file in
## accordance with the commercial license agreement provided with the
## Software or, alternatively, in accordance with the terms contained in
## a written agreement between you and The Qt Company. For licensing terms
## and conditions see https://www.qt.io/terms-conditions. For further
## information use the contact form at https://www.qt.io/contact-us.
##
## GNU Lesser General Public License Usage
## Alternatively, this file may be used under the terms of the GNU Lesser
## General Public License version 3 as published by the Free Software
## Foundation and appearing in the file LICENSE.LGPL3 included in the
## packaging of this file. Please review the following information to
## ensure the GNU Lesser General Public License version 3 requirements
## will be met: https://www.gnu.org/licenses/lgpl-3.0.html.
##
## GNU General Public License Usage
## Alternatively, this file may be used under the terms of the GNU
## General Public License version 2.0 or (at your option) the GNU General
## Public license version 3 or any later version approved by the KDE Free
## Qt Foundation. The licenses are as published by the Free Software
## Foundation and appearing in the file LICENSE.GPL2 and LICENSE.GPL3
## included in the packaging of this file. Please review the following
## information to ensure the GNU General Public License requirements will
## be met: https://www.gnu.org/licenses/gpl-2.0.html and
## https://www.gnu.org/licenses/gpl-3.0.html.
##
## $QT_END_LICENSE$
##
#############################################################################

. "$PSScriptRoot\helpers.ps1"

# This script installs 7-Zip

$version = "16.04"
$nonDottedVersion = "1604"

if (Is64BitWinHost) {
    $arch = "-x64"
    $sha1 = "338A5CC5200E98EDD644FC21807FDBE59910C4D0"
} else {
    $arch = ""
    $sha1 = "dd1cb1163c5572951c9cd27f5a8dd550b33c58a4"
}

$url_cache = "\\ci-files01-hki.ci.qt.io\provisioning\windows\7z" + $nonDottedVersion + $arch + ".exe"
$url_official = "http://www.7-zip.org/a/7z" + $nonDottedVersion + $arch + ".exe"
$7zPackage = "C:\Windows\Temp\7zip-$nonDottedVersion.exe"
$7zTargetLocation = "C:\Utils\sevenzip\"

Download $url_official $url_cache $7zPackage
Verify-Checksum $7zPackage $sha1
Run-Executable $7zPackage "/S","/D=$7zTargetLocation"

Write-Host "Cleaning $7zPackage.."
Remove "$7zPackage"

Add-Path $7zTargetLocation

Write-Output "7-Zip = $version" >> ~\versions.txt
