#!/bin/bash
mkdocs build --clean
cp -r site/index.html index-.html
cp -r material/.overrides/index.html site/
cp -r site/* ./
rm -rf site