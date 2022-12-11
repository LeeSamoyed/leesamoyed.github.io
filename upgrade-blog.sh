#!/bin/bash
mkdocs build --clean
rm -rf $(ls | grep -v docs | grep -v material | grep -v site | grep -v .gitignore | grep -v gitpod.yml | grep -v mkdocs.yml | grep -v README.md | grep -v upgrade-blog.sh)
mv site/* ./