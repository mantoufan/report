#!/bin/bash
# Deploy to GitHub Pages (gh-pages branch)
set -e

echo "🚀 Deploying to GitHub Pages..."

# Build from current branch
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
COMMIT_MSG="deploy: update SEO keyword report $(date '+%Y-%m-%d %H:%M')"

# Stage and commit changes on main first
git add -A
git diff --cached --quiet || git commit -m "$COMMIT_MSG"

# Push main
git push origin main

# Deploy to gh-pages using subtree or orphan branch
if git show-ref --verify --quiet refs/heads/gh-pages; then
  git branch -D gh-pages
fi

git checkout --orphan gh-pages
git add -A
git commit -m "$COMMIT_MSG"
git push origin gh-pages --force
git checkout "$CURRENT_BRANCH"

echo ""
echo "✅ Deployed!"
echo "🌐 URL: https://$(git remote get-url origin | sed 's/.*github.com[:/]//' | sed 's/\.git$//' | sed 's|/|.github.io/|')"
