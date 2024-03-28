# !/bin/bash

# Fetch the branches and their respective commits from the upstream repository
git fetch upstream

# Check out your fork's local default branch (usually 'main' or 'master')
git checkout main

# Merge the changes from upstream/main into your local main branch
git merge upstream/main