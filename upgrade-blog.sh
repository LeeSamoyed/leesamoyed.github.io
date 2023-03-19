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
  # rmfile=`ls ./ | grep -v .docs | grep -v material | \
  #         grep -v  .github | grep -v site | grep -v .gitignore | \
  #         grep -v gitpod.yml | grep -v mkdocs.yml | grep -v README.md | \
  #         grep -v upgrade-blog.sh | grep -v .repo-mirror | \
  #         grep -v Dockerfile | grep -v action.yml`
  # echo "***These files will be delelte:***\n"${rmfile}"\n***Input 'y' to continue upgrade and others to stop***"
  echo "***Are U sure to upgrade***\n"${rmfile}"***Input 'y' to continue upgrade and others to stop***"
  
  read makesure
  if [ $makesure == "y" ]
  then
  # clean & delete
  mkdocs build --clean
  echo "***Build success***"
  # rm -rf $(ls ./ | grep -v .docs | grep -v material | \
  #         grep -v  .github | grep -v site | grep -v .gitignore | \
  #         grep -v gitpod.yml | grep -v mkdocs.yml | grep -v README.md | \
  #         grep -v upgrade-blog.sh | grep -v .repo-mirror | \
  #         grep -v Dockerfile | grep -v action.yml)
  # echo "***Delete success***"
  cp -r ./site/*  ./
  echo "***Copy success***"

  # auto push to github
  git add .
  git commit -m $1
  git push origin master
  echo "***Upgrade success***"
  else
    echo "***Exit***"
  fi
fi