# AGPLv3 Compliance Summary for BookPH

Portions Copyright (c) 2025 BookPH

This document certifies that BookPH maintains full compliance with the GNU Affero General Public License v3.0 (AGPLv3).

## License Information

**Primary License**: AGPLv3  
**Copyright**: 
- Copyright (c) 2020-present Cal.com, Inc.
- Portions Copyright (c) 2025 BookPH

**License Files**:
- [LICENSE](./LICENSE) - Full AGPLv3 license text with copyright notices
- [NOTICE](./NOTICE) - Detailed attribution and disclaimers

## AGPLv3 Section 13 Compliance

### Requirement
Section 13 of AGPLv3 requires that users who interact with the software over a network be offered access to the Corresponding Source code.

### Implementation ✅

We have implemented source code access in TWO locations to ensure compliance:

#### 1. Login/Signup Pages
- **Location**: `apps/web/components/ui/AuthContainer.tsx`
- **Visible on**: Login page, Signup page, Password reset, etc.
- **Implementation**: "Source Code" link in the footer
- **URL**: https://github.com/Be1l-ai/bookph
- **Code**:
```tsx
<div className="text-subtle mt-4 text-center text-xs">
  <a
    href="https://github.com/Be1l-ai/bookph"
    target="_blank"
    rel="noopener noreferrer"
    className="hover:text-emphasis underline">
    Source Code
  </a>
</div>
```

#### 2. Main Application Sidebar
- **Location**: `packages/features/shell/SideBar.tsx`
- **Visible on**: All authenticated pages (event types, bookings, availability, etc.)
- **Implementation**: "Source Code" link at bottom of sidebar
- **Desktop**: Full text link
- **Mobile**: Icon with aria-label
- **URL**: https://github.com/Be1l-ai/bookph
- **Code**:
```tsx
<div className="text-subtle mb-2 mt-2 px-3 text-center text-xs">
  <a
    href="https://github.com/Be1l-ai/bookph"
    target="_blank"
    rel="noopener noreferrer"
    className="hover:text-emphasis hover:underline">
    <span className="hidden lg:inline">Source Code</span>
    <span className="lg:hidden">
      <Icon name="code" className="mx-auto h-4 w-4" aria-label="Source Code" />
    </span>
  </a>
</div>
```

### User Experience

**Unauthenticated Users** (Login/Signup):
- See "Source Code" link below the login/signup form
- Can access complete source before creating an account

**Authenticated Users** (Main App):
- See "Source Code" link in sidebar on every page
- Desktop: Text link "Source Code"
- Mobile: Code icon (</>) in bottom navigation

## Copyright Attribution

### Files Updated

1. **LICENSE** - Root license file
   - Added: "Portions Copyright (c) 2025 BookPH"
   - Preserved: Original Cal.com copyright

2. **README.md** - Main documentation
   - Added comprehensive "Attribution & License" section
   - Clear disclaimer about enterprise features
   - Link to source code repository

3. **NOTICE** - Detailed attribution file (new)
   - Full copyright notices
   - Third-party software credits
   - Enterprise features disclaimer
   - AGPLv3 network use requirement explanation

## Enterprise Features Disclosure

### What's Disabled

The following enterprise features from the `/ee` directory are NOT included in this self-hosted version:

❌ **Teams Functionality**
- Removed from navigation menu
- Team creation/management unavailable
- Code: `packages/features/shell/navigation/Navigation.tsx`

❌ **Organizations**
- Organization members link hidden
- Organization features disabled
- Code: `packages/features/shell/navigation/Navigation.tsx`

❌ **SSO/SAML Authentication**
- SSO login button not displayed
- SAML configuration disabled
- Code: `apps/web/modules/auth/login-view.tsx`

### Why Disabled?

These features are in the `/ee` (Enterprise Edition) directory and require a commercial license from Cal.com. Per the original Cal.com license structure:

> "All content that resides under the packages/features/ee and apps/api/v2/src/ee directory is licensed under a separate commercial license."

By disabling these features, BookPH complies with the AGPLv3 license for the core scheduling functionality while respecting Cal.com's commercial licensing for enterprise features.

### Documentation

Users are informed about disabled features in:
- README.md - Prominent note in "Attribution & License" section
- NOTICE - Detailed "ENTERPRISE FEATURES NOTICE" section
- DEPLOYMENT.md - Clear list of included vs. excluded features
- .env.bookph.example - Comments explaining missing variables

## Privacy & Telemetry

### What's Disabled

All third-party telemetry and tracking has been completely disabled:

❌ **PostHog Analytics**
- Provider initialization disabled
- Pageview tracking disabled
- Event capture calls commented out
- Files: 3 provider files + 7 component files

❌ **Intercom Support Widget**
- Provider returns children only (no widget loaded)
- File: `packages/features/ee/support/lib/intercom/provider.tsx`

❌ **Helpscout Chat**
- Provider returns children only (no chat loaded)
- File: `packages/features/ee/support/lib/helpscout/provider.tsx`

### Environment Variables

Default settings in `.env.example`:
```bash
# Telemetry disabled by default
CALCOM_TELEMETRY_DISABLED=1

# PostHog - disabled
# NEXT_PUBLIC_POSTHOG_KEY=
# NEXT_PUBLIC_POSTHOG_HOST=

# Intercom - disabled
# NEXT_PUBLIC_INTERCOM_APP_ID=
# INTERCOM_SECRET=
# INTERCOM_API_TOKEN=
```

### Why This Matters for AGPLv3

Under AGPLv3, users have the right to:
1. **Privacy**: Know what data is collected
2. **Transparency**: See and modify tracking code
3. **Control**: Disable telemetry without breaking functionality

By completely disabling telemetry, BookPH respects user privacy and makes the codebase simpler for self-hosters.

## Source Code Modifications

### Summary

All modifications to the Cal.com codebase are documented in [REBRANDING.md](./REBRANDING.md):

- **40 files** modified/created
- **All changes** tracked in git history
- **Clear comments** explaining BookPH modifications
- **Attribution preserved** in all modified files

### Key Modification Areas

1. **Navigation** (2 files) - Teams/Orgs disabled
2. **Authentication** (2 files) - SSO disabled, source link added
3. **Telemetry** (13 files) - PostHog/Intercom/Helpscout disabled
4. **Documentation** (5 files) - LICENSE, README, NOTICE, DEPLOYMENT, REBRANDING
5. **Configuration** (4 files) - .env files, .gitignore

### Comments Standard

All modifications include comments like:
```typescript
// BookPH: [Feature] disabled for AGPLv3 self-hosted version
// Original: [original code reference]
```

This ensures:
- Future maintainers understand changes
- Original Cal.com code can be referenced
- Modifications are transparent to users

## Deployment Documentation

### Self-Hosting Guide

Complete deployment instructions provided in:
- **DEPLOYMENT.md** - Step-by-step Vercel + Supabase guide
- **.env.bookph.example** - Simplified configuration template

### What Self-Hosters Get

✅ **Core Scheduling Features**
- Event types and booking management
- Calendar integrations
- Email notifications
- Payment processing
- Workflows and automation
- Video conferencing
- Routing forms

✅ **Full Source Access**
- Complete source code on GitHub
- No proprietary code or dependencies
- All modifications documented
- Easy to customize and extend

❌ **Enterprise Features** (Require Commercial License)
- Teams and Organizations
- SSO/SAML authentication
- Enterprise billing features
- Premium support integrations

## Compliance Checklist

- [x] **License File**: AGPLv3 license with copyright notices
- [x] **Attribution**: Cal.com and BookPH copyright notices
- [x] **Source Access**: Links visible to all network users
- [x] **Transparency**: Enterprise features clearly documented as disabled
- [x] **Privacy**: All telemetry disabled by default
- [x] **Documentation**: Comprehensive deployment guide
- [x] **Modifications**: All changes tracked and documented
- [x] **User Rights**: Users can access, modify, and redistribute

## Legal Notices

### For Cal.com

BookPH acknowledges and respects:
- Cal.com's original copyright (2020-present)
- Cal.com's commercial license for /ee features
- Cal.com's trademark and branding rights
- Cal.com's open source contribution to the community

### For Users

Users of BookPH have the right to:
- **Use** the software for any purpose
- **Study** the source code and see how it works
- **Modify** the code to suit their needs
- **Distribute** copies of the original or modified versions
- **Access** the source code over the network (AGPLv3 Section 13)

### For Contributors

Contributors to BookPH agree:
- Contributions are licensed under AGPLv3
- Original Cal.com copyright is preserved
- Enterprise features remain under Cal.com commercial license
- Code modifications are clearly documented

## Contact & Questions

### AGPLv3 Compliance Questions
- **GitHub Issues**: https://github.com/Be1l-ai/bookph/issues
- **Email**: help@bookph.com (when available)

### Commercial License Questions
For enterprise features (Teams, Organizations, SSO):
- Contact Cal.com: https://cal.com/sales
- Cal.com Documentation: https://cal.com/docs

### Source Code Access
- **Repository**: https://github.com/Be1l-ai/bookph
- **License**: AGPLv3
- **Upstream**: https://github.com/calcom/cal.com

---

**Last Updated**: December 2024  
**Version**: BookPH v1.0 (Based on Cal.com)  
**Compliance Status**: ✅ Full AGPLv3 Compliance Achieved
