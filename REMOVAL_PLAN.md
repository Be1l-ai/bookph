# BookPH Production Cleanup Plan

**Goal**: Flatten the monorepo from enterprise-scale to medium production-ready size

**Date**: December 17, 2025
**Status**: Ready for execution

---

## Overview

Cal.com is built for massive scale with external APIs, SDKs, 100+ integrations, mobile apps, and full documentation sites. BookPH is a focused booking platform for the Philippine market and doesn't need this complexity.

### Size Reduction
- **Before**: ~20 packages, 5 apps, 100+ integrations, full docs site
- **After**: ~12 core packages, 1 main app, 5 essential integrations, minimal docs
- **Estimated removal**: ~60-70% of codebase weight

---

## Phase 1: Remove Non-Essential Apps ✅

### Directories to DELETE
```bash
# Mobile/Browser companion app (React Native + Extension)
rm -rf companion/

# Example applications for developers
rm -rf example-apps/

# External monitoring checks (Checkly)
rm -rf __checks__/

# Cal.com-specific deployment scripts
rm -rf deploy/

# API proxy (not needed without external API)
rm -rf apps/api/
```

**Impact**: 
- Removes mobile app (~75 files)
- Removes API proxy (simple, but unused)
- Removes deployment automation specific to Cal.com infrastructure
- Removes external monitoring

**Rationale**: BookPH doesn't need mobile companion app or exposed external API proxy in initial launch.

---

## Phase 2: Keep Platform & Embeds (Core Dependencies) ⚠️

### ❌ CANNOT REMOVE - ACTIVELY USED

**Critical Finding**: After code analysis, these packages are integrated into core functionality:

#### `packages/embeds/` - MUST KEEP
**Used by core booking flows**:
- `apps/web/components/PageWrapper.tsx` - Imports embed-iframe for all pages
- `apps/web/modules/bookings/views/bookings-single-view.tsx` - Uses `useIsEmbed()`
- `apps/web/modules/users/views/users-public-view.tsx` - Embed detection
- `apps/web/modules/team/team-view.tsx` - SDK action manager
- `apps/web/app/(use-page-wrapper)/payment/[uid]/PaymentPage.tsx` - Payment embed support
- Routing forms, cancellation flows, error pages

**Why it's needed**: The booking system uses embed infrastructure internally even if not exposing external embeds. It's part of the core architecture, not just for third-party embedding.

#### `packages/platform/` - MUST KEEP
**Used by OAuth and billing features**:
- `/settings/platform/*` - Entire settings section for OAuth clients
- OAuth client management (create, edit, delete)
- Platform billing and subscription management
- Managed users functionality
- Uses `@calcom/platform-types` and `@calcom/platform-constants` extensively

**Why it's needed**: If you use OAuth authentication or any platform API features, this is required. Even if not exposing external API, internal OAuth flows depend on it.

### Decision: KEEP BOTH
- ✅ Keep `packages/embeds/` - Core dependency
- ✅ Keep `packages/platform/` - OAuth/billing dependency

### Alternative: Remove Platform Features
If you want to remove platform entirely, you must also:
1. Delete `/apps/web/app/(use-page-wrapper)/settings/platform/` directory
2. Remove all OAuth client management features
3. Remove platform billing integration
4. Remove 20+ hooks in `apps/web/lib/hooks/settings/platform/`
5. Test thoroughly - may break authentication flows

---

## Phase 3: Trim App Store (90% removal) 🎯

### Keep These Integrations (5 total)
```
packages/app-store/
├── googlecalendar/        # Essential - Calendar sync
├── googlevideo/           # Essential - Google Meet
├── stripepayment/         # Essential - Payments (if needed)
├── _utils/                # Keep - Shared utilities
├── _components/           # Keep - Shared components
├── _pages/                # Keep - App pages
└── [keep base files]      # AppDependencyComponent, etc.
```

### DELETE All Other Integrations (~95 directories)

**Video conferencing** (keep only Google Meet):
```bash
rm -rf packages/app-store/{dailyvideo,demodesk,huddle01video,jitsivideo,office365video,riverside,salesroom,shimmervideo,sirius_video,sylapsvideo,tandemvideo,webex,whereby,zoomvideo}
```

**Calendar integrations** (keep only Google):
```bash
rm -rf packages/app-store/{applecalendar,caldavcalendar,exchange*calendar,feishucalendar,ics-feedcalendar,larkcalendar,nextcloudtalk,office365calendar,zohocalendar}
```

**CRM/Sales tools**:
```bash
rm -rf packages/app-store/{attio,closecom,hubspot,linear,pipedrive-crm,salesforce,zoho-bigin,zohocrm}
```

**Analytics/Tracking** (all removed per REBRANDING.md):
```bash
rm -rf packages/app-store/{fathom,ga4,gtm,matomo,metapixel,plausible,posthog,twipla,umami}
```

**AI/Automation tools**:
```bash
rm -rf packages/app-store/{bolna,chatbase,databuddy,elevenlabs,fonio-ai,granola,greetmate-ai,lindy,millis-ai,retell-ai,synthflow}
```

**Payment alternatives** (keep only Stripe):
```bash
rm -rf packages/app-store/{btcpayserver,hitpay,paypal}
```

**Messaging/Communication**:
```bash
rm -rf packages/app-store/{campfire,discord,signal,skype,telegram,whatsapp}
```

**Other integrations**:
```bash
rm -rf packages/app-store/{alby,amie,basecamp3,clic,cron,dub,eightxeight,element-call,facetime,framer,giphy,horizon-workrooms,insihts,intercom,jelly,make,monobot,n8n,ping,pipedream,qr_code,raycast,roam,routing-forms,sendgrid,vimcal,vital,weather_in_your_calendar,wipemycalother,wordpress,zapier}
```

**Rationale**: Most integrations are unused for Philippine market or require enterprise licenses. Keep only essentials: calendar sync, video calls, payments.

---

## Phase 4: Minimize Documentation 📚

### Strategy: Keep Core Setup, Remove Marketing/API Docs

**KEEP** (essential for self-hosting):
```
docs/
├── README.md (update for BookPH)
├── self-hosting/
│   ├── installation.mdx
│   ├── docker.mdx
│   └── database-migrations.mdx
└── developing/
    ├── local-development.mdx
    └── introduction.mdx
```

**DELETE** (not needed):
```bash
# Full API reference (no external API)
rm -rf docs/api-reference/

# Platform SDK docs (no SDK)
rm -rf docs/platform/

# Marketing content
rm -rf docs/introduction.mdx
rm -rf docs/mint.json
rm -rf docs/snippets/
rm -rf docs/images/
rm -rf docs/logo/
rm -rf docs/favicon.*

# Advanced self-hosting not needed initially
rm -rf docs/self-hosting/apps/
rm -rf docs/self-hosting/deployments/
rm -rf docs/self-hosting/sso-setup.mdx
rm -rf docs/self-hosting/license-key.mdx
```

**Alternative**: Keep root-level docs and delete entire `docs/` directory, using:
- `QUICKSTART.md`
- `QUICKSTART-SELFHOST.md`
- `DEPLOYMENT.md` (your custom one)
- `SUPABASE_SETUP.md`

---

## Phase 5: Clean Configuration Files 🔧

### Update `package.json`

**Remove scripts**:
```json
// DELETE these - no longer needed
"dev:all"           // references website
"dev:api"           // references api proxy
"dev:api:console"   // references console
"dev:console"       // references console  
"dev:website"       // references website
"dev:swagger"       // references swagger
"publish-embed"     // no embeds
"embed-tests"       // no embeds
"embed-tests-quick" // no embeds
"e2e:embed"         // no embeds
"e2e:embed-react"   // no embeds
"test-e2e:embed"    // no embeds
"test-e2e:embed-react" // no embeds
"build:ai"          // if removing AI features
"dev:ai"            // if removing AI features
```

**Update workspaces**:
```json
"workspaces": [
  "apps/web",                    // KEEP - main app
  "packages/*",                  // KEEP - all packages
  "packages/features/*"          // KEEP - features
  // REMOVE: apps/api/*, packages/embeds/*, packages/platform/*, example-apps/*
]
```

### Update `turbo.json`

Remove build pipelines for deleted apps:
- `@calcom/website#build`
- `@calcom/api#build`
- `@calcom/console#build`
- `@calcom/embed-*` tasks
- `@calcom/platform/*` tasks

### Update `.gitignore`

Remove references to deleted directories:
```
# Not needed anymore
companion/dist
example-apps/*/node_modules
```

---

## Phase 6: Optional Package Cleanup 🧹

### Evaluate These Packages (Check Usage First)

**Likely safe to remove**:
- `packages/coss-ui/` - If not used in your theme
- `packages/debugging/` - If not actively debugging
- `packages/kysely/` - If you only use Prisma

**Check before removing**:
```bash
# Search for imports
rg "from ['\"]@calcom/coss-ui" --type ts
rg "from ['\"]@calcom/debugging" --type ts
rg "from ['\"]@calcom/kysely" --type ts
```

**Keep these** (core functionality):
- `packages/app-store-cli/` - Needed if keeping any app-store
- `packages/sms/` - Keep if you need SMS reminders

---

## Phase 7: Enterprise Features Review 🏢

### Review `packages/features/ee/` subdirectories

Based on REBRANDING.md, you've already disabled:
- Teams/Organizations navigation
- SSO/SAML
- PostHog/Intercom/HelpScout

**Consider removing entire directories** (if not needed):
```bash
# Check what's in ee/
ls -la packages/features/ee/

# Potentially remove:
rm -rf packages/features/ee/organizations/  # If fully disabled
rm -rf packages/features/ee/sso/            # If SSO not needed
rm -rf packages/features/ee/dsync/          # Directory sync
```

**⚠️ Warning**: Review carefully - some EE features might be used in core flows.

---

## Execution Plan 🚀

### Step 1: Backup
```bash
git checkout -b production-cleanup
git add -A
git commit -m "checkpoint: before production cleanup"
```

### Step 2: Execute Removals (in order)
```bash
# Phase 1: Apps
rm -rf companion/ example-apps/ __checks__/ deploy/ apps/api/

# Phase 2: Platform & Embeds  
rm -rf packages/platform/ packages/embeds/

# Phase 3: App Store (see detailed list above)
# Run the rm -rf commands for each category

# Phase 4: Documentation
rm -rf docs/api-reference/ docs/platform/ docs/introduction.mdx docs/mint.json docs/snippets/ docs/images/ docs/logo/

# Or delete entire docs if using root-level docs only:
# rm -rf docs/
```

### Step 3: Update Configs
1. Edit `package.json` - remove scripts and update workspaces
2. Edit `turbo.json` - remove deleted app pipelines
3. Edit `.gitignore` - remove deleted directory references

### Step 4: Reinstall & Build
```bash
# Clean everything
yarn clean

# Reinstall dependencies (this will remove unused deps)
rm -rf node_modules
rm yarn.lock
yarn install

# Generate Prisma client
yarn prisma generate

# Type check
yarn type-check:ci --force

# Build
yarn build

# Run dev to verify
yarn dev
```

### Step 5: Test Critical Paths
- [ ] Login/Signup works
- [ ] Create event type
- [ ] Book a meeting
- [ ] Google Calendar connection (if keeping)
- [ ] Email notifications send
- [ ] Video conferencing works (Google Meet)
- [ ] Payment flow (if using Stripe)

### Step 6: Commit
```bash
git add -A
git commit -m "refactor: flatten monorepo for production

- Remove companion app, example-apps, api proxy
- Remove platform SDK and embeds packages  
- Trim app-store to essentials (Google Cal/Meet, Stripe)
- Minimize documentation to core setup guides
- Clean up configs and unused scripts

BREAKING CHANGE: Removed 90+ app integrations and external API"
```

---

## Risk Assessment ⚠️

### Low Risk (Safe to remove)
- ✅ `companion/` - Separate mobile/extension app
- ✅ `example-apps/` - Developer examples
- ✅ `__checks__/` - External monitoring
- ✅ `deploy/` - Cal.com infrastructure scripts
- ✅ Most app-store integrations (90+)

### Medium Risk (Review usage)
- ⚠️ `apps/api/` - Check if anything depends on it
- ⚠️ `packages/platform/` - Check for internal usage
- ⚠️ `packages/embeds/` - Check if booking flow uses embed components
- ⚠️ `packages/kysely/` - Check if used internally

### Higher Risk (Review carefully)
- 🔴 `packages/features/ee/` subdirectories - May have dependencies in core
- 🔴 `docs/` entire directory - Make sure root docs are sufficient

---

## Rollback Plan 🔄

If build fails after cleanup:

```bash
# Restore from backup branch
git checkout main
git branch -D production-cleanup

# Or revert specific removal
git checkout HEAD~1 -- packages/embeds/
yarn install
```

---

## Post-Cleanup Validation ✅

**Checklist**:
- [ ] `yarn install` completes without errors
- [ ] `yarn type-check:ci --force` passes
- [ ] `yarn build` succeeds
- [ ] `yarn dev` starts successfully
- [ ] No broken imports in browser console
- [ ] Database migrations work
- [ ] Core user flows functional
- [ ] Logos display correctly
- [ ] Emails send with correct branding

**Final size check**:
```bash
# Before
du -sh node_modules/
du -sh .

# After  
du -sh node_modules/
du -sh .

# Should see significant reduction
```

---

## Benefits After Cleanup 🎯

1. **Faster builds**: Fewer packages to compile
2. **Simpler deployment**: Less configuration needed
3. **Easier maintenance**: Less code to understand
4. **Cleaner dependencies**: No unused packages
5. **Lower hosting costs**: Smaller bundle sizes
6. **Better performance**: Less code to load
7. **Focused development**: Work on what matters

---

## Notes

- All removals maintain AGPLv3 compliance
- Cal.com attribution preserved in LICENSE and README
- Can always re-add features from original repo if needed
- Keep this file for documentation of what was removed and why

**Next**: After successful cleanup, update REBRANDING.md with Phase 3 completion notes.
