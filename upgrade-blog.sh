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

  # build
  mkdocs build --clean
  echo "***Build success***"

  # clean & delete
  origin=./site   #文件夹a
  target=./
  for i in `ls $origin`
  do
  echo $i
  rm -rf $target/$i 
  done
  echo "***Delete success***"

  mv ./site/*  ./
  echo "***Remove success***"
  rm -rf ./site

  # auto push to github
  git add .
  git commit -m $1
  git push origin master
  echo "***Upgrade success***"
fi

# rm -rf $(ls ./ | grep -v .docs | grep -v material | \
#         grep -v  .github | grep -v site | grep -v .gitignore | \
#         grep -v gitpod.yml | grep -v mkdocs.yml | grep -v README.md | \
#         grep -v upgrade-blog.sh | grep -v .repo-mirror | \
#         grep -v Dockerfile | grep -v action.yml)