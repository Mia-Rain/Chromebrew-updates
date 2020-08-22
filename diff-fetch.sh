#!/bin/bash
# spinners are cools
spinner(){
for s in / - \\ \|; do printf "\r$s";sleep .1;done && printf '\n'
}
# `fetch` diff's within sub modules -
void(){
branch=$(git branch --show-current) # We grab the branch for each loop, use this rather than master, allows to work with custom branches
# Use to check and update void-packages
cd ./void-packages
if git remote show origin | grep "master pushes to master (local out of date)"; then
  git fetch | spinner # We `fetch` rather than `pull` so we can `diff` later
  git diff remotes/origin/master $branch --name-only
  git pull
fi
}
git submodule update --depth 1
void
