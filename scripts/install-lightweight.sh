#!/bin/bash
# Lightweight installation script for BookPH
# Optimized for systems with limited resources

set -e

echo "🚀 BookPH Lightweight Installation"
echo "===================================="
echo ""

# Check available memory
AVAILABLE_MEM=$(free -m | awk 'NR==2{print $7}')
echo "Available memory: ${AVAILABLE_MEM}MB"

if [ "$AVAILABLE_MEM" -lt 2000 ]; then
    echo "⚠️  Low memory detected. Using optimized settings..."
    export NODE_OPTIONS="--max-old-space-size=1536"
else
    echo "✅ Sufficient memory available"
    export NODE_OPTIONS="--max-old-space-size=4096"
fi

echo ""
echo "Step 1: Cleaning old artifacts..."
find . -name "node_modules" -type d -prune -exec rm -rf {} + 2>/dev/null || true
find . -name ".next" -type d -prune -exec rm -rf {} + 2>/dev/null || true
find . -name ".turbo" -type d -prune -exec rm -rf {} + 2>/dev/null || true
find . -name "dist" -type d -prune -exec rm -rf {} + 2>/dev/null || true
rm -f yarn.lock 2>/dev/null || true

echo "✅ Cleaned"
echo ""

echo "Step 2: Installing dependencies (this may take 5-10 minutes)..."
echo "Note: Using Yarn v3 with optimized settings"
echo ""

# Install with Yarn v3 optimizations
# Yarn v3 manages concurrency automatically based on available resources
yarn install --mode skip-build

echo ""
echo "Step 3: Generating Prisma client..."
yarn prisma generate

echo ""
echo "✅ Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Copy .env.example to .env and configure"
echo "  2. Run: yarn dev"
echo "  3. Visit: http://localhost:3000"
echo ""
