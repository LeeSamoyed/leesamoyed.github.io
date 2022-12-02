#!/bin/bash
mkdocs build --clean
cp -r site/assets/javascripts ./assets
cp -r site/assets/stylesheets ./assets
rm -rf site/assets/
rm -rf site/index.html
rm -rf site/404.html
cp -r site/* ./
rm -rf site