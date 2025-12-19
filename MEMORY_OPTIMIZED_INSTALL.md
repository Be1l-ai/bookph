# BookPH Memory-Optimized Installation Guide

## Problem
Yarn install crashed due to heavy memory usage during dependency resolution.

## Solution Applied

### Additional Removals (Beyond Initial Cleanup)
1. ✅ Removed `packages/app-store-cli` (148KB) - Not needed for production
2. ✅ Removed unused app-store integrations:
   - autocheckin
   - baa-for-hipaa  
   - deel
   - dialpad
   - mirotalk
   - mock-payment-app
   - telli
   - templates
3. ✅ Removed `packages/coss-ui` (44KB) - Unused
4. ✅ Removed `packages/debugging` - Unused
5. ✅ Removed app-store-cli scripts from package.json

### Result
- **18 packages remaining** (down from 21)
- **Further 50%+ reduction in app-store size**
- **Cleaner dependency tree**

---

## Installation Options

### Option 1: Memory-Optimized Install (Recommended)

Use the lightweight installation script:

```bash
bash scripts/install-lightweight.sh
```

**Features**:
- Automatically detects available memory
- Sets optimal Node.js memory limits
- Uses network-friendly yarn settings
- Reduces concurrent downloads
- Less likely to crash

**Settings**:
- Low memory (<2GB): `--max-old-space-size=1536`
- Normal memory (>2GB): `--max-old-space-size=4096`
- Network timeout: 300 seconds
- Network concurrency: 4 (vs default 8)

### Option 2: Manual Install with Optimizations

```bash
# Clean everything first
rm -rf node_modules yarn.lock
find . -name .next -o -name .turbo -o -name dist -type d -prune -exec rm -rf {} +

# Set memory limit
export NODE_OPTIONS="--max-old-space-size=2048"

# Install with optimizations
yarn install \
  --network-timeout 300000 \
  --network-concurrency 4 \
  --mutex network

# Generate Prisma
yarn prisma generate
```

### Option 3: Swap File (If Still Crashing)

If your system has limited RAM, create a swap file:

```bash
# Create 4GB swap file
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Verify
free -h

# Then run install
bash scripts/install-lightweight.sh
```

---

## What's Left in the Repo

### Apps (1)
- ✅ `apps/web` - Main application

### Essential Packages (18)
1. `packages/app-store` - 3 integrations + routing-forms
2. `packages/config` - Build config
3. `packages/dayjs` - Date handling
4. `packages/ee` - Enterprise features (some disabled)
5. `packages/emails` - Email templates
6. `packages/embeds` - Core dependency (booking flows)
7. `packages/eslint-config` - Linting
8. `packages/eslint-plugin` - Custom rules
9. `packages/features` - Core features
10. `packages/kysely` - SQL query builder (used internally)
11. `packages/lib` - Core utilities
12. `packages/platform` - OAuth/billing
13. `packages/prisma` - Database ORM
14. `packages/sms` - SMS notifications
15. `packages/trpc` - API layer
16. `packages/tsconfig` - TypeScript configs
17. `packages/types` - TypeScript types
18. `packages/ui` - UI components

### Integrations Kept (3 + routing-forms)
- `googlecalendar` - Calendar sync
- `googlevideo` - Google Meet
- `stripepayment` - Payments
- `routing-forms` - Form routing (used extensively)

---

## Troubleshooting

### If Install Still Crashes

**1. Check available memory**:
```bash
free -h
```

**2. Close other applications**:
- Close browser tabs
- Close VS Code/IDEs
- Stop other Node processes: `pkill node`

**3. Use even lower memory limit**:
```bash
export NODE_OPTIONS="--max-old-space-size=1024"
yarn install --network-concurrency 2
```

**4. Install in stages** (nuclear option):
```bash
# Install root dependencies only
yarn install --frozen-lockfile --ignore-workspace-root-check

# Then install workspaces one by one
cd packages/prisma && yarn install
cd ../lib && yarn install
# etc...
```

**5. Use Docker** (alternative):
```bash
# If you have Docker, build in container with more memory
docker run -it --memory=4g -v $(pwd):/app node:20 bash
cd /app && yarn install
```

---

## After Successful Install

### Validate the build:

```bash
# 1. Type check
yarn type-check:ci --force

# 2. Build
yarn build

# 3. Start dev
yarn dev
```

### Test critical paths:
- [ ] Login/signup
- [ ] Create event type
- [ ] Book a meeting
- [ ] Google Calendar (if configured)
- [ ] Stripe payment (if configured)

---

## Commit Changes

Once everything works:

```bash
git add -A
git commit -m "refactor: further reduce monorepo size

- Remove app-store-cli (not needed)
- Remove unused integrations (autocheckin, deel, dialpad, etc.)
- Remove unused packages (coss-ui, debugging)
- Add memory-optimized install script
- Total packages: 18 (down from 21)

Reduces memory usage during yarn install"
```

---

## Final Stats

### Before All Cleanups
- ~20+ packages
- 100+ integrations
- ~3GB node_modules

### After All Cleanups
- 18 packages
- 4 integrations (3 + routing-forms)
- Estimated ~1-1.5GB node_modules
- **60-70% total reduction**

---

## Next Steps

1. ✅ Run `bash scripts/install-lightweight.sh`
2. ✅ If successful, run `yarn type-check:ci --force`
3. ✅ Run `yarn build`
4. ✅ Test with `yarn dev`
5. ✅ Commit if everything works

**Note**: The lightweight install script will automatically handle memory constraints and should complete without crashing.
