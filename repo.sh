#!/bin/bash

value=`cat $HOME/.config/gh-repocreate.token`  

echo "Reading token..."

if [ -z "${value}" ]; then 
  echo "Please supply Github token. Token should be a file at $HOME/.config/gh-repocreate.token"
  exit 1
fi

read -p "Enter repo name: " reponame
read -p "Enter repo desc: " repodesc

body=`echo '{"name":"'"${reponame}"'","description":"'"${repodesc}"'","homepage":"https://github.com","private":false,"is_template":false}'`

echo "Creating repo..."
curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $value" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/user/repos \
  -d ${body}

if [ $? -ne 0 ]; then 
  echo "Could not create the repo."
  exit 1
fi

echo "Created repo with name: $reponame !"
