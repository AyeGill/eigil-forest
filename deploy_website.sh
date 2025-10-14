#!/usr/bin/env bash

TARGET=root@172.105.82.133:/var/www/erischel.com/html

git diff --quiet || { echo 'Unstaged changes detected, are you sure you want to proceed' >&2; exit 1; } 

echo "Now doing automated commit"

git commit -m "automated commit - deploying website"
git pull --rebase
git push

echo "Now building forest"

./build-public.sh

echo "Now publishing website"

rsync -r output/ root@172.105.82.133:/var/www/erischel.com/html
