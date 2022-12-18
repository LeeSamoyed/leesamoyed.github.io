#!/bin/bash
mkdocs build --clean
rm -rf $(ls | grep -v docs | grep -v material | \
        grep -v  .github | grep -v site | grep -v .gitignore | \
        grep -v gitpod.yml | grep -v mkdocs.yml | grep -v README.md | \
        grep -v upgrade-blog.sh | grep -v git-mirror.sh | grep -v entrypoint.sh | \
        grep -v Dockerfile | grep -v action.yml)
mv site/* ./

git add .
git commit -m $1
git config user.name "LeeSamoyed"
sudo git push origin master