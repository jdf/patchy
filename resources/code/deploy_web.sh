#!/bin/sh
cd /c/europa-winter07/workspace/Patchy/distribution/web
chmod -R a+rwX *
rsync -azv --exclude '.svn/' --delete -e ssh * mrfeinberg.com:/var/www/html/mrfeinberg.com/patchy
