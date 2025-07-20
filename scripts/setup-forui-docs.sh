#!/bin/bash

# Script to sparse-checkout forui docs to local docs/forui directory
# This script downloads only the docs/app/docs folder from the forui repository

set -e  # Exit on any error

REPO_URL="https://github.com/forus-labs/forui.git"
TEMP_DIR="temp_forui_clone"
TARGET_DIR="docs/forui"
SOURCE_PATH="docs/app/docs"

echo "🚀 Starting sparse checkout of forui documentation..."

# Clean up any existing temp directory
if [ -d "$TEMP_DIR" ]; then
    echo "🧹 Cleaning up existing temp directory..."
    rm -rf "$TEMP_DIR"
fi

# Clean up any existing target directory
if [ -d "$TARGET_DIR" ]; then
    echo "🧹 Cleaning up existing target directory..."
    rm -rf "$TARGET_DIR"
fi

# Create target directory if it doesn't exist
mkdir -p "$(dirname "$TARGET_DIR")"

# Clone repository with no checkout and blob filtering for efficiency
echo "📥 Cloning repository (sparse)..."
git clone --filter=blob:none --no-checkout "$REPO_URL" "$TEMP_DIR"

# Enter the temporary clone directory
cd "$TEMP_DIR"

# Initialize sparse-checkout in cone mode (more efficient)
echo "⚙️  Setting up sparse checkout..."
git sparse-checkout init --cone

# Set the specific path we want to checkout
echo "📂 Configuring sparse checkout for $SOURCE_PATH..."
git sparse-checkout set "$SOURCE_PATH"

# Checkout the files
echo "✅ Checking out files..."
git checkout

# Go back to original directory
cd ..

# Copy the docs to our target location
if [ -d "$TEMP_DIR/$SOURCE_PATH" ]; then
    echo "📋 Copying docs to $TARGET_DIR..."
    
    # Remove target directory if it exists
    if [ -d "$TARGET_DIR" ]; then
        rm -rf "$TARGET_DIR"
    fi
    
    # Copy the docs
    cp -r "$TEMP_DIR/$SOURCE_PATH" "$TARGET_DIR"
    echo "✨ Successfully copied forui docs to $TARGET_DIR"
else
    echo "❌ Error: Source path $SOURCE_PATH not found in repository"
    exit 1
fi

# Clean up temporary directory
echo "🧹 Cleaning up..."
rm -rf "$TEMP_DIR"

echo "🎉 Done! Forui documentation is now available in $TARGET_DIR"
echo "📁 You can find the docs at: $(pwd)/$TARGET_DIR" 