#!/bin/bash
script -c 'mkdocs build --clean >> upgrade-blog.txt' upgrade-blog.txt
cp -r site/index.html index-.html
cp -r material/.overrides/index.html site/
cp -r site/* ./
rm -rf site
echo '-----------------------------------------------------'
echo '*****************************************************'
echo '-----------------------------------------------------'
cat upgrade-blog.txt | grep -v 'png' | grep -v 'jpg'