#!/usr/bin/env bash

TARGET=root@172.105.82.133:/var/www/erischel.com/html

git diff --quiet || { echo 'Unstaged changes detected, are you sure you want to proceed' >&2; exit 1; } 

echo "Now doing automated commit"

git commit -m "automated commit - deploying website"
git pull --rebase
git push

echo "Now building forest"

./forester build public-forest.toml

echo "Replacing theme with public theme"

mv -f public-theme/* output/

echo "Now publishing website"

rsync -r public/ root@172.105.82.133:/var/www/erischel.com/html
