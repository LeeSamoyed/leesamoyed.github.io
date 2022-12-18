#!/bin/bash

# check args
if [ $# -le 0 ]
  then
  echo what is your commmit notes?
  exit
fi

# update wiki 
if [ $# -gt 0 ]
  then
  mkdocs build --clean
  rm -rf $(ls | grep -v .docs | grep -v material | \
          grep -v  .github | grep -v site | grep -v .gitignore | \
          grep -v gitpod.yml | grep -v mkdocs.yml | grep -v README.md | \
          grep -v upgrade-blog.sh | grep -v .repo-mirror | \
          grep -v Dockerfile | grep -v action.yml)
  mv site/* ./

  # auto push to github
  git add .
  git commit -m $1
  git push origin master

  # auto push to gitee (github action workflow)
fi


  