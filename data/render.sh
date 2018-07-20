#!/bin/sh

# render.sh - a Mosix/Blender load balancing workload manager
# written 2000 by Marc O. Gloor <mgloor@fhzh.ch>
#
# $Id: render.sh,v 1.1 2005/08/05 21:27:11 gloor Exp $
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

# example below will render 550 images from test.blend on 10 nodes: 
# "./render.sh test.blend 50 600 10"

if [ $# -lt 1 ]; then
  echo "syntax: render.sh blenderscene startimage endimage nodes"
  exit 1
fi

BIN=/usr/bin/blender              # blender path
SCN=$1                            # name of blender scene 
DIF=`expr \( $3 - $2 \)`          # no. of images to render 
RPN=`expr \( $DIF / $4 \)`        # no. of images per node
LOP=`expr \( $4 - 1 \)`           # loop counter 

for i in `seq 0 $LOP` ; do
  BEG=`expr \( $i \* $RPN \) \+ \( $2 + 1 \)`
  END=`expr \( $i \+ 1 \) \* $RPN \+ $2`
  $BIN -b $SCN -s $BEG -e $END -a > /dev/null 2> /dev/null &
done

echo " "
echo "Rendering" $DIF "images from" $1 "on" $4 "nodes."
echo "Tasks forked, network rendering in progress."
echo -n "Job started at: " ; date '+%d-%m-%y %H:%M:%S'
echo "Please wait while rendering..."
wait
echo "Rendering successfully finished."
echo -n "Job ended at: " ; date '+%d-%m-%y %H:%M:%S'
echo " "

#EOF
