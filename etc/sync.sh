#!/bin/sh
# synchronisiert website mit FH-Server

# synchronisieren mit fhzh (Technische Fakultät)
rsync -clrvz --delete -e ssh --rsync-path=/opt/sfw/bin/rsync \
/Users/gloor/data/www/website/ \
mgloor@gatekeeper.hsz-t.ch:/afs/hsz-t.ch/usr/mgloor/www/ --exclude=.svn
