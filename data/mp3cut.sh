#!/bin/sh
# $Id: mp3cut.sh,v 1.8 2005/11/12 11:31:54 gloor Exp $
# @(#) wrapper for cutmp3 av. from http://www.puchalla-online.de/cutmp3.html
# 05/11/2005 - written by Marc O. Gloor <mgloor@fhzh.ch>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA

#
# $Log: mp3cut.sh,v $
# Revision 1.8  2005/11/12 11:31:54  gloor
# website of cutmp3 added (to make script complete...)
#
# Revision 1.7  2005/11/12 10:37:54  gloor
# arg fix
#
# Revision 1.6  2005/11/12 10:34:57  gloor
# argument parser added
#
# Revision 1.5  2005/11/09 22:36:02  gloor
# gpl added
#
# Revision 1.4  2005/11/07 16:48:20  gloor
# minor changes (order)
#
# Revision 1.3  2005/11/05 14:20:18  gloor
# version for productional use...
#
# Revision 1.2  2005/11/05 13:22:07  gloor
# initial checkin for testing core functionality
#
# Revision 1.1  2005/11/05 13:09:55  gloor
# Initial revision
#
#

# global definitions
EXIT=0 ; CMD=$0 ; PID=$$ ; HOST=`hostname` ; TMP=/tmp/
LOGTIME () { TIME="`date '+%d-%m-%Y %H:%M:%S'`" ; }
#LOG=mp3cut.log ; exec 2>>$LOG
ACTION1="start"
ACTION2="end"

# begin script
# start logging
#LOGTIME; echo "$TIME $HOST $CMD $ACTION1" >> $LOG

header() {
echo "\$Id: mp3cut.sh,v 1.8 2005/11/12 11:31:54 gloor Exp $"
echo "written by Marc O. Gloor <mgloor@fhzh.ch>"
echo ""
}

usage() {
  header
  echo "  syntax: $0 [<file>]"
  echo "  syntax: $0 (interactive without args)"
  echo
  exit 1
}

case $1 in
        -h|--h|-help|--help)   usage ; exit 0 ;;
esac

header

if [ $# -gt 0 ]; then
  file=$1
  echo -n "mp3 file to cut from : " && echo $file
    else
  echo -n "mp3 file to cut from : " && read file
fi

echo -n "extract to mp3 file  : " && read outfile
echo -n "cut from (e.g. 00:10): " && read from
echo -n "cut to (e.g. 01:50)  : " && read to
echo "cutting, please wait..."
cutmp3 -i $file -a $from -b $to -O $outfile
echo "finished, resulting file successfully written."

# stop logging
#LOGTIME; echo "$TIME $HOST $CMD $ACTION2 (exit=$EXIT)" >> $LOG
exit $EXIT
