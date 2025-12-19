#!/bin/bash
# Network-resilient install for BookPH
# Retries on network failures

set -e

echo "🌐 BookPH Network-Resilient Install"
echo "===================================="
echo ""

export NODE_OPTIONS="--max-old-space-size=1024"

echo "Step 1: Cleaning..."
rm -rf node_modules 2>/dev/null || true
find . -maxdepth 3 -name ".next" -o -name ".turbo" -type d -prune -exec rm -rf {} + 2>/dev/null || true
echo "✅ Cleaned"
echo ""

echo "Step 2: Installing with network retry..."
echo "This will retry up to 3 times on network failures"
echo ""

# Try install with retries
MAX_RETRIES=3
RETRY_COUNT=0

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    echo "Attempt $((RETRY_COUNT + 1)) of $MAX_RETRIES..."
    
    if yarn install --mode skip-build; then
        echo ""
        echo "✅ Installation successful!"
        break
    else
        RETRY_COUNT=$((RETRY_COUNT + 1))
        if [ $RETRY_COUNT -lt $MAX_RETRIES ]; then
            echo "⚠️  Install failed, retrying in 5 seconds..."
            sleep 5
        else
            echo "❌ Installation failed after $MAX_RETRIES attempts"
            echo ""
            echo "Possible solutions:"
            echo "1. Check your internet connection"
            echo "2. Try again later (registry might be down)"
            echo "3. Use a different network"
            echo "4. Try: yarn config set networkTimeout 300000"
            exit 1
        fi
    fi
done

echo ""
echo "Step 3: Generating Prisma client..."
yarn workspace @calcom/prisma prisma generate

echo ""
echo "✅ Complete! Run 'yarn dev' to start"
