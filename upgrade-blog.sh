#!/bin/bash
mkdocs build --clean
cp site/assets/javascripts ./assets/javascripts
cp site/assets/stylesheets ./assets/stylesheets
rm -rf site/assets/
rm -rf site/index.html
rm -rf site/404.html
cp -r site/* ./
rm -rf site