# BookPH Installation - Quick Guide

## Your System
- **Available RAM**: ~1GB
- **Yarn Version**: 3.4.1
- **Status**: Low memory system

## Recommended Installation

Use the **ultra-lite** script (designed for <2GB RAM):

```bash
bash scripts/install-ultra-lite.sh
```

**Features**:
- Uses only 768MB max Node memory
- Skips build scripts initially
- Sequential builds to avoid memory spikes
- Faster cleanup

## Currently Running

The lightweight script is installing now. It may take 10-15 minutes.

## If It Crashes Again

### Option 1: Create Swap File (Recommended)

```bash
# Create 2GB swap
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Verify it's active
free -h

# Then retry
bash scripts/install-ultra-lite.sh
```

### Option 2: Ultra Minimal Install

```bash
# Set very low memory
export NODE_OPTIONS="--max-old-space-size=512"

# Install without any extras
yarn install --mode skip-build

# Generate Prisma only
yarn workspace @calcom/prisma prisma generate
```

### Option 3: Install on Another Machine

If you have access to a machine with more RAM:
1. Clone repo there
2. Run `yarn install`
3. Commit `node_modules` and `.yarn/cache`
4. Pull on this machine
5. Run `yarn install --immutable --check-cache`

## After Install Succeeds

```bash
# Generate Prisma (if not done)
yarn prisma generate

# Start dev server
yarn dev
```

## Monitoring Install Progress

In another terminal:
```bash
# Watch memory usage
watch -n 2 free -h

# If Node process appears, watch it
ps aux | grep node
```

## Success Indicators

✅ No "heap out of memory" errors  
✅ All packages resolve  
✅ Can run `yarn prisma generate`  
✅ Can run `yarn dev`

## Current Install Status

Running: `bash scripts/install-lightweight.sh`
- Using 1536MB max memory
- Yarn v3 mode
- Should complete in 10-15 minutes

**Wait for it to complete...**
