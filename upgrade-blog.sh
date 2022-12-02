#!/bin/bash
mkdocs build --clean
rm -rf site/assets/
rm -rf site/index.html
rm -rf site/404.html
cp -r site/* ./
rm -rf site