#!/bin/bash
# spinners are cools
spinner(){
while [ -d /proc/$! ]
do
for s in / - \\ \|; do printf "\rWorking: $s Process: $!";sleep .1;done
done
}
# `fetch` diff's within sub modules -
void(){
printf 'Checking log...\n'
branch=$(git branch --show-current) # We grab the branch for each loop, use this rather than master, allows to work with custom branches
# Use to check and update void-packages
cd ./void-packages && printf "cd'd..."
if git remote show origin | grep "master pushes to master (local out of date)"; then
  git fetch &> /dev/null & # We `fetch` rather than `pull` so we can `diff` later
  spinner && printf '\r\n'
  git diff remotes/origin/master $branch --name-only
  git pull & 
  spinner && printf '\r\n'
else
  printf '\n\rNo update yet- Waiting\n'
  sleep 10 & # Wait
  spinner && printf '\nChecking Again...\n'
fi
}
git clone https://github.com/void-linux/void-packages --depth 1 --progress -q &> /dev/null &
spinner && printf '\n'

git submodule add https://github.com/void-linux/void-packages void-packages &> /dev/null
void
