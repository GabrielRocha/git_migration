#!/bin/bash
#. ./git_migration.sh
read -p "Insert the project name: " project_name
read -p "Insert the SSH/HTTP address of git origin repository: " origin_repository
read -p "Insert the SSH/HTTP address of git destination repository: " destination_repository
git clone $origin_repository
cd $project_name
for remote in `git branch -r | sed '1 d'`; do git checkout `echo $remote | sed -e "s/origin\\///g"`;done
git remote set-url origin $destination_repository
git config --add remote.origin.push '+refs/heads/*:refs/heads/*'
git config --add remote.origin.push '+refs/tags/*:refs/tags/*'
git push