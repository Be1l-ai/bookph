#!/bin/bash
# Further reduction script for BookPH - removes optional dev tools

set -e

echo "🔧 BookPH Further Reduction"
echo "============================"
echo ""

cd "$(dirname "$0")/.."

echo "Removing optional packages and files..."

# Remove test/example files from packages
find packages -name "*.test.ts" -o -name "*.test.tsx" -o -name "__tests__" -type d | wc -l
echo "Test files to remove (keeping for now, can manually remove if needed)"

# Remove storybook if not needed
if [ -d "packages/storybook" ]; then
    echo "Removing Storybook..."
    rm -rf packages/storybook
fi

# Remove coss-ui if not used
if [ -d "packages/coss-ui" ]; then
    echo "Checking if coss-ui is used..."
    if ! grep -r "@calcom/coss-ui" apps/web --include="*.ts" --include="*.tsx" >/dev/null 2>&1; then
        echo "Removing unused coss-ui package..."
        rm -rf packages/coss-ui
    else
        echo "coss-ui is in use, keeping it"
    fi
fi

# Remove debugging package if not used
if [ -d "packages/debugging" ]; then
    echo "Checking if debugging is used..."
    if ! grep -r "@calcom/debugging" apps/web --include="*.ts" --include="*.tsx" >/dev/null 2>&1; then
        echo "Removing unused debugging package..."
        rm -rf packages/debugging
    else
        echo "debugging is in use, keeping it"
    fi
fi

# Remove kysely if only using Prisma
if [ -d "packages/kysely" ]; then
    echo "Checking if kysely is used..."
    if ! grep -r "@calcom/kysely" apps/web packages/features --include="*.ts" --include="*.tsx" >/dev/null 2>&1; then
        echo "Removing unused kysely package..."
        rm -rf packages/kysely
    else
        echo "kysely is in use, keeping it"
    fi
fi

echo ""
echo "✅ Cleanup complete!"
echo ""
echo "Remaining packages:"
ls -d packages/*/ | wc -l
echo ""
echo "Run scripts/install-lightweight.sh to reinstall with optimizations"
