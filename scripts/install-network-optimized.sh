#!/bin/bash
# Network-optimized installation for BookPH
# Handles network timeouts and connection issues

set -e

echo "🌐 BookPH Network-Optimized Install"
echo "===================================="
echo ""

export NODE_OPTIONS="--max-old-space-size=1536"

echo "Step 1: Cleaning..."
rm -rf node_modules 2>/dev/null || true
find . -maxdepth 3 -name ".next" -o -name ".turbo" -type d -exec rm -rf {} + 2>/dev/null || true
echo "✅ Cleaned"
echo ""

echo "Step 2: Configuring Yarn for better network handling..."

# Create/update .yarnrc.yml with network-friendly settings
cat > .yarnrc.yml << 'EOF'
nodeLinker: node-modules

enableGlobalCache: true

enableTelemetry: false

httpTimeout: 300000

networkConcurrency: 8

httpRetry: 5

networkSettings:
  httpTimeout: 300000
  maxRetries: 5
EOF

echo "✅ Yarn configured with:"
echo "   - 5 minute timeout"
echo "   - 5 retries on failure"
echo "   - Global cache enabled"
echo ""

echo "Step 3: Testing connectivity to npm registry..."
if curl -s --connect-timeout 10 https://registry.yarnpkg.com > /dev/null; then
    echo "✅ npm registry accessible"
else
    echo "⚠️  Warning: npm registry may be slow or unreachable"
    echo "   Consider:"
    echo "   - Checking your internet connection"
    echo "   - Using a VPN if npm is blocked"
    echo "   - Trying again later"
    echo ""
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi
echo ""

echo "Step 4: Installing dependencies (may take 10-20 minutes)..."
echo "Note: If you see ETIMEDOUT errors, the script will retry automatically"
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
            echo ""
            echo "⚠️  Installation failed, retrying in 10 seconds..."
            echo "   (This is normal with slow/unstable connections)"
            sleep 10
        else
            echo ""
            echo "❌ Installation failed after $MAX_RETRIES attempts"
            echo ""
            echo "Troubleshooting:"
            echo "  1. Check internet connection"
            echo "  2. Try using a VPN or different network"
            echo "  3. Run: yarn install --network-timeout 600000"
            echo "  4. Or try offline mode: yarn install --offline (if you have cache)"
            exit 1
        fi
    fi
done

echo ""
echo "Step 5: Generating Prisma client..."
yarn workspace @calcom/prisma prisma generate

echo ""
echo "✅ Installation complete!"
echo ""
echo "Next: yarn dev"
