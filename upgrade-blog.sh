#!/bin/bash
mkdocs build --clean
cp -r material/assets/javascripts ./assets/javascripts
cp -r material/assets/stylesheets ./assets/stylesheets
rm -rf site/assets/
rm -rf site/index.html
rm -rf site/404.html
cp -r site/* ./
rm -rf site