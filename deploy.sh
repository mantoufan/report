#!/bin/bash
# Deploy to GitHub Pages (main branch)
set -e

echo "🚀 Deploying to GitHub Pages..."

COMMIT_MSG="deploy: update SEO keyword report $(date '+%Y-%m-%d %H:%M')"

git add -A
git diff --cached --quiet || git commit -m "$COMMIT_MSG"
git push origin main

echo ""
echo "✅ Deployed!"
echo "🌐 URL: https://$(git remote get-url origin | sed 's/.*github.com[:/]//' | sed 's/\.git$//' | sed 's|/|.github.io/|')"
