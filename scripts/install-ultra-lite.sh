#!/bin/bash
# Ultra-lightweight installation for systems with <2GB RAM
# Uses minimal memory settings

set -e

echo "🔧 BookPH Ultra-Lightweight Install (for <2GB RAM)"
echo "=================================================="
echo ""

# Very aggressive memory limit for low-spec machines
export NODE_OPTIONS="--max-old-space-size=768"

echo "Memory settings: 768MB max for Node.js"
echo ""

echo "Step 1: Cleaning..."
rm -rf node_modules 2>/dev/null || true
rm -f yarn.lock 2>/dev/null || true

# Clean only .next and .turbo to avoid long find operations
find . -maxdepth 3 -name ".next" -type d -exec rm -rf {} + 2>/dev/null || true
find . -maxdepth 3 -name ".turbo" -type d -exec rm -rf {} + 2>/dev/null || true

echo "✅ Cleaned"
echo ""

echo "Step 2: Installing dependencies (5-15 minutes)..."
echo "⚠️  If this crashes with 'heap out of memory':"
echo "   1. Close all other programs"
echo "   2. Create swap: sudo fallocate -l 2G /swapfile && sudo chmod 600 /swapfile && sudo mkswap /swapfile && sudo swapon /swapfile"
echo ""

# Yarn v3 - skip build scripts initially to save memory
yarn install --mode skip-build

echo ""
echo "Step 3: Building internal packages..."
# Build in sequence to avoid memory spikes
yarn workspace @calcom/prisma prisma generate

echo ""
echo "✅ Installation complete!"
echo ""
echo "To start development:"
echo "  yarn dev"
echo ""
