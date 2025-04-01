#!/bin/bash

# === CONFIG ===
BROKEN_REPO_PATH="$(pwd)"  # assumes you're running this inside the broken repo
FRESH_REPO_DIR="../datahub_fresh"
REPO_URL="git@github.com:shcsd-jacja13/DatahubUIMac.git"
NEW_BRANCH="datahub_v1"

echo "🚀 Starting clean rebuild and push to '$NEW_BRANCH'..."

# === STEP 1: Clone the repo cleanly ===
echo "🔄 Cloning fresh repo..."
git clone "$REPO_URL" "$FRESH_REPO_DIR" || { echo "❌ Clone failed"; exit 1; }

# === STEP 2: Copy files over (skip .git) ===
echo "📦 Copying project files (excluding .git)..."
rsync -av --progress "$BROKEN_REPO_PATH"/ "$FRESH_REPO_DIR"/ --exclude .git

# === STEP 3: Commit and push ===
cd "$FRESH_REPO_DIR" || { echo "❌ Failed to enter fresh repo directory"; exit 1; }

git checkout -b "$NEW_BRANCH"

git add .
git commit -m "Clean commit of current project to branch '$NEW_BRANCH'" || echo "⚠️ Nothing to commit"

echo "☁️ Pushing to GitHub..."
git push --set-upstream origin "$NEW_BRANCH" || { echo "❌ Push failed"; exit 1; }

echo "✅ Success! '$NEW_BRANCH' is now live on GitHub!"

