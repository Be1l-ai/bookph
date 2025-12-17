# BookPH Cleanup - Quick Reference

## TL;DR

Run this to clean up the monorepo for production:

```bash
# 1. Backup
git checkout -b production-cleanup
git commit -am "checkpoint: before cleanup"

# 2. Run automated cleanup
bash scripts/cleanup-for-production.sh

# 3. Rebuild
yarn clean
rm -rf node_modules yarn.lock
yarn install
yarn prisma generate
yarn type-check:ci --force
yarn build

# 4. Test
yarn dev
# Test login, booking, calendar, payments

# 5. Commit
git add -A
git commit -m "refactor: flatten monorepo for production"
```

---

## What Gets Removed

### Directories (automatic)
- `companion/` - Mobile app + extension
- `example-apps/` - Example code
- `__checks__/` - Monitoring
- `deploy/` - Cal.com deployment scripts
- `apps/api/` - API proxy
- 90+ app-store integrations (keeps Google Cal/Meet, Stripe)
- Most docs/ (keeps self-hosting basics)

### Config Updates (manual)
Edit `package.json`:
- Remove scripts: `dev:api`, `dev:website`, `embed-tests`, etc.
- Update workspaces to remove deleted apps

Edit `turbo.json`:
- Remove pipelines for deleted apps

---

## What We Keep

✅ `apps/web/` - Main app  
✅ `packages/embeds/` - Core dependency (booking UI)  
✅ `packages/platform/` - OAuth features  
✅ `packages/prisma/` - Database  
✅ `packages/trpc/` - API  
✅ `packages/ui/` - UI components  
✅ `packages/features/` - Core features  
✅ `packages/lib/` - Utilities  
✅ All essential packages

---

## Size Reduction

- **Before**: ~20 packages, 100+ integrations, 5 apps
- **After**: ~15 packages, 3-5 integrations, 1 app
- **Savings**: ~50-60% codebase weight

---

## Critical Finding

⚠️ **Cannot remove embeds/platform** - They're used internally:
- `packages/embeds/` → Used by booking flows, payment pages
- `packages/platform/` → Used by OAuth client management

Removing them would break core functionality.

---

## Testing Checklist

After cleanup, verify:
- [ ] Login/signup works
- [ ] Create event type
- [ ] Book a meeting  
- [ ] Google Calendar connection (if keeping)
- [ ] Video conferencing (Google Meet if keeping)
- [ ] Payment flow (if using Stripe)
- [ ] Email notifications

---

## Questions?

See detailed docs:
- `PRODUCTION_SUMMARY.md` - Executive summary
- `REMOVAL_PLAN.md` - Detailed plan with rationale
- `scripts/cleanup-for-production.sh` - Automation script

---

## Rollback

If something breaks:
```bash
git checkout main
git branch -D production-cleanup
```

Or restore specific directory:
```bash
git checkout HEAD~1 -- packages/embeds/
yarn install
```

---

**Ready to execute?** Just run: `bash scripts/cleanup-for-production.sh` 🚀
