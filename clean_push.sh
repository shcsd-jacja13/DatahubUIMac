#!/bin/bash

# === CONFIG ===
BROKEN_REPO_PATH="$(pwd)"  # assumes you're running this inside the broken repo
FRESH_REPO_DIR="../datahub-fresh"
REPO_URL="git@github.com:shcsd-jacja13/DatahubUIMac.git"
NEW_BRANCH="Release1-clean"

echo "🚀 Starting clean rebuild and push of branch $NEW_BRANCH"

# === STEP 1: Clone a fresh copy ===
echo "🔄 Cloning fresh repo..."
git clone "$REPO_URL" "$FRESH_REPO_DIR" || { echo "❌ Clone failed"; exit 1; }

# === STEP 2: Copy files (skip .git) ===
echo "📦 Copying project files..."
rsync -av --progress "$BROKEN_REPO_PATH"/ "$FRESH_REPO_DIR"/ --exclude .git

# === STEP 3: Create and checkout new branch ===
cd "$FRESH_REPO_DIR" || { echo "❌ Failed to enter fresh repo"; exit 1; }
git checkout -b "$NEW_BRANCH"

# === STEP 4: Commit changes ===
echo "✅ Staging and committing files..."
git add .
git commit -m "Clean re-add of Release1 from broken repo" || echo "⚠️ Nothing to commit"

# === STEP 5: Push to GitHub ===
echo "☁️ Pushing to origin..."
git push --set-upstream origin "$NEW_BRANCH" || { echo "❌ Push failed"; exit 1; }

echo "🎉 Done! Branch '$NEW_BRANCH' is live on GitHub."

