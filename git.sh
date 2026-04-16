#!/bin/bash

if ! git rev-parse --is-inside-work-tree &>/dev/null; then
	echo "❌ Tu n'es pas dans un repo git."
	exit 1
fi

repo_name=$(basename "$(pwd)")
gh_user=$(gh api user --jq '.login' 2>/dev/null)

if [ -z "$gh_user" ]; then
	echo "❌ Lance 'gh auth login' d'abord."
	exit 1
fi

if ! gh repo create "$gh_user/$repo_name" --private --confirm; then
	echo "❌ Échec de la création du repo."
	exit 1
fi

git remote add github "git@github.com:$gh_user/$repo_name.git"

branch=$(git branch --show-current)
git push -u github "$branch"

echo "✅ Repo '$repo_name' créé et pushé sur GitHub."
