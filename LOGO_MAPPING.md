# Logo Asset Mapping - BookPH Rebrand

## Executive Summary

This document maps Cal.com logo files to their BookPH equivalents and identifies where they are used in the codebase.

**Status**: ✅ Main logos already exist as `bookph-*.svg` files. Only OAuth buttons and email templates need new design assets.

## Logo Files Inventory

### ✅ Available BookPH Logos (Ready to Use)

BookPH already has the following logo assets in `apps/web/public/`:

| File | Purpose | Status |
|------|---------|--------|
| `bookph-icon.svg` | Square icon (light) | ✅ Ready |
| `bookph-icon-white.svg` | Square icon (white) | ✅ Ready |
| `bookph-logo-word.svg` | Logo with text (default) | ✅ Ready |
| `bookph-logo-word-dark.svg` | Logo with text (dark mode) | ✅ Ready |
| `bookph-logo-word-black.svg` | Logo with text (black) | ✅ Ready |
| `bookph-logo-white-word.svg` | Logo with text (white) | ✅ Ready |

### ⚠️ Cal.com Logo Files (Can be removed after verification)

These Cal.com logo files exist but are **not used** in components:

| File | BookPH Equivalent | Notes |
|------|-------------------|-------|
| `cal-com-icon.svg` | `bookph-icon.svg` | Replace |
| `cal-com-icon-white.svg` | `bookph-icon-white.svg` | Replace |
| `cal-logo-word.svg` | `bookph-logo-word.svg` | Replace |
| `cal-logo-word-dark.svg` | `bookph-logo-word-dark.svg` | Replace |
| `cal-logo-word-black.svg` | `bookph-logo-word-black.svg` | Replace |
| `calcom-logo-white-word.svg` | `bookph-logo-white-word.svg` | Replace |
| `calcom-white.svg` | `bookph-logo-white-word.svg` | Replace (duplicate) |

### ❌ Missing Assets (Need Design)

These files need to be created for BookPH:

#### OAuth Buttons (8 files needed)
| Cal.com File | BookPH File Needed | Purpose |
|--------------|-------------------|---------|
| `continue-with-calcom-light-squared.svg` | `continue-with-bookph-light-squared.svg` | OAuth button (light, squared corners) |
| `continue-with-calcom-light-rounded.svg` | `continue-with-bookph-light-rounded.svg` | OAuth button (light, rounded corners) |
| `continue-with-calcom-dark-squared.svg` | `continue-with-bookph-dark-squared.svg` | OAuth button (dark, squared corners) |
| `continue-with-calcom-dark-rounded.svg` | `continue-with-bookph-dark-rounded.svg` | OAuth button (dark, rounded corners) |
| `continue-with-calcom-neutral-squared.svg` | `continue-with-bookph-neutral-squared.svg` | OAuth button (neutral, squared) |
| `continue-with-calcom-neutral-rounded.svg` | `continue-with-bookph-neutral-rounded.svg` | OAuth button (neutral, rounded) |
| `continue-with-calcom-coss-ui.svg` | `continue-with-bookph-coss-ui.svg` | OAuth button (COSS UI style) |
| `continue-with-calcom-coss-ui-light.svg` | `continue-with-bookph-coss-ui-light.svg` | OAuth button (COSS UI light) |

#### Email Templates (1 file needed)
| Cal.com File | BookPH File Needed | Purpose |
|--------------|-------------------|---------|
| `emails/CalLogo@2x.png` | `emails/BookPHLogo@2x.png` | Email template logo (high-res PNG) |

## Component Usage Analysis

### Logo Component (Dynamic Loading)

**Location**: `packages/ui/components/logo/Logo.tsx`

```tsx
export function Logo({
  small,
  icon,
  inline = true,
  className,
  src = "/api/logo",  // ✅ Dynamic logo loading
}: { ... }) {
  return (
    <h3 className={classNames("logo", inline && "inline", className)}>
      <strong>
        {icon ? (
          <img className="mx-auto w-9 dark:invert" alt="Cal" title="Cal" src={`${src}?type=icon`} />
        ) : (
          <img
            className={classNames(small ? "h-4 w-auto" : "h-5 w-auto", "dark:invert")}
            alt="Cal"
            title="Cal"
            src={src}
          />
        )}
      </strong>
    </h3>
  );
}
```

**Status**: ✅ No changes needed. Uses dynamic `/api/logo` API route which serves logos based on organization/team settings.

### Logo API Route

**Location**: `apps/web/app/api/logo/route.ts`

The API route dynamically serves logos based on:
- Organization settings
- Team settings
- Deployment settings
- Default fallback to BookPH logos

**Status**: ✅ No changes needed. Already configured through environment variables.

### Static Logo References

**Search Results**: ❌ No hardcoded logo file imports found in:
- `apps/web/components/**/*.{tsx,ts,jsx,js}`
- `apps/web/app/**/*.{tsx,ts,jsx,js}`
- `apps/web/pages/**/*.{tsx,ts,jsx,js}`
- `packages/ui/**/*.{tsx,ts,jsx,js}`

**Conclusion**: All logos are loaded dynamically through the `/api/logo` route. No component code changes needed.

## Where Logos Are Used

### 1. Favicons and App Icons
**Locations**:
- `apps/web/app/layout.tsx`
- `apps/web/pages/_document.tsx`
- `apps/web/public/site.webmanifest`

**URLs**:
```tsx
apple: "/api/logo?type=apple-touch-icon"
url: "/api/logo?type=favicon-16"
url: "/api/logo?type=favicon-32"
```

**Status**: ✅ Dynamic loading via API route

### 2. Main Application Logo
**Usage**: Throughout the app via `<Logo />` component

**Status**: ✅ Dynamic loading via API route

### 3. OAuth Buttons
**Expected Location**: OAuth/authentication flows

**Status**: ⚠️ Not currently used (files exist but no imports found). May be for future OAuth integration or can be removed.

### 4. Email Templates
**Location**: Email template rendering

**Status**: ⚠️ Needs `emails/BookPHLogo@2x.png` created

## App Store Icons (Unaffected)

These are app-specific icons, not BookPH branding:
- `/api/app-store/*/icon.svg`
- `/app-store/*/logo.svg`

**Status**: ✅ No changes needed - these are third-party app icons

## Action Items

### Immediate (No Action Required)
- [x] Main logos already exist as `bookph-*.svg`
- [x] Logo system uses dynamic `/api/logo` route
- [x] No hardcoded logo imports in components

### Future (When Needed)
- [ ] Create 8 OAuth button variants with "Continue with BookPH" text
- [ ] Create `emails/BookPHLogo@2x.png` for email templates
- [ ] Consider removing old Cal.com logo files after verification

### Optional Cleanup
- [ ] Remove unused Cal.com logo files:
  - `cal-com-icon.svg`
  - `cal-com-icon-white.svg`
  - `cal-logo-word.svg`
  - `cal-logo-word-dark.svg`
  - `cal-logo-word-black.svg`
  - `calcom-logo-white-word.svg`
  - `calcom-white.svg`
- [ ] Remove unused OAuth button files (if OAuth feature not used):
  - `continue-with-calcom-*.svg` (8 files)

## Environment Configuration

Logos are controlled by these environment variables:

```bash
# Already configured in .env.example
NEXT_PUBLIC_APP_NAME="BookPH"
NEXT_PUBLIC_COMPANY_NAME="BookPH"
NEXT_PUBLIC_SUPPORT_MAIL_ADDRESS="help@bookph.com"
```

## Summary

**Good News**:
1. ✅ BookPH logos already exist (6 variants)
2. ✅ Logo system is fully dynamic (no hardcoded paths)
3. ✅ No component code changes needed
4. ✅ Environment variables already configured

**To Do** (only if features are used):
1. ⚠️ Create OAuth buttons (8 files) - if OAuth feature is implemented
2. ⚠️ Create email logo PNG - for email templates

**Recommendation**: Keep current BookPH logo files, optionally remove old Cal.com files after testing, and create OAuth/email assets only if those features are actively used.
