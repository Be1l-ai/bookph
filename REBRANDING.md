# BookPH Rebranding Documentation

This document summarizes the rebranding of Cal.com to BookPH for the Filipino market.

## Overview

**BookPH** is a booking and scheduling platform specifically designed for Filipino freelancers, VAs, and service providers. It is built on the open-source Cal.com foundation and maintains AGPLv3 license compliance.

### Target Market
- Filipino freelancers
- Virtual Assistants (VAs)
- Consultants and coaches
- Service providers

### Pricing
- **₱249/month** (80% cheaper than Calendly's ₱1,140/month)

## Rebranding Changes Completed

### Phase 2.1: Brand Name Changes ✅

#### Core Configuration Files
- **package.json**: Updated name to "bookph-monorepo" and added description
- **README.md**: Comprehensive update with BookPH branding, pricing, and proper Cal.com attribution
- **packages/lib/constants.ts**: Updated all default constants:
  - `APP_NAME`: "BookPH"
  - `WEBSITE_URL`: "https://bookph.com"
  - `SUPPORT_MAIL_ADDRESS`: "help@bookph.com"
  - `COMPANY_NAME`: "BookPH"
  - `SENDER_ID`: "BookPH"
  - `SENDER_NAME`: "BookPH"
  - All documentation URLs (ROADMAP, DOCS_URL, DEVELOPER_DOCS, etc.)

#### Translation Files
- **apps/web/public/static/locales/en/common.json**: 115+ string replacements
  - "Cal.com" → "BookPH"
  - "Cal Video" → "Book Video"
  - "Cal AI" → "Book AI"

#### Environment Configuration
- **.env.example**: Updated default values
  - Email addresses (notifications@bookph.com, help@bookph.com)
  - App name and company name
  - Support mail address

### Phase 2.2: Logo & Visual Branding ✅

#### Logo Files Created
Six new SVG logo files with Philippine flag colors:
1. **bookph-icon.svg** - Main icon with blue background and "PH" text
2. **bookph-icon-white.svg** - White background variant
3. **bookph-logo-word.svg** - WordLogo variant
4. **bookph-logo-word-dark.svg** - Dark variant
5. **bookph-logo-word-black.svg** - Black text variant
6. **bookph-logo-white-word.svg** - White text variant

#### Brand Colors (Philippine Flag Theme)
- **Primary (Light)**: `#0038A8` - Philippine Blue
- **Accent (Dark)**: `#FCD116` - Philippine Yellow
- **Secondary**: `#CE1126` - Philippine Red (available for future use)

#### Logo References Updated
- packages/lib/constants.ts (LOGO, LOGO_ICON)
- packages/lib/OgImages.tsx (generic OG image logo)
- apps/web/modules/auth/oauth2/authorize-view.tsx
- apps/web/modules/auth/platform/authorize-view.tsx
- apps/web/modules/videos/views/videos-single-view.tsx

### Phase 2.3: Domain & URL Updates ✅

All default URLs updated to use bookph.com:
- Website URL: https://bookph.com
- Developer docs: https://developer.bookph.com
- Roadmap: https://bookph.com/roadmap
- Privacy policy: https://bookph.com/privacy
- Terms: https://bookph.com/terms
- Community: https://github.com/Be1l-ai/bookph/discussions

### Page Metadata Updates
- Referral program page
- Routing forms pages
- All user-facing metadata titles and descriptions

## Files Modified

### Core Configuration (5 files)
1. package.json
2. README.md
3. .env.example
4. packages/lib/constants.ts
5. packages/lib/OgImages.tsx

### UI Components (6 files)
6. apps/web/modules/auth/oauth2/authorize-view.tsx
7. apps/web/modules/auth/platform/authorize-view.tsx
8. apps/web/modules/videos/views/videos-single-view.tsx
9. apps/web/app/(use-page-wrapper)/refer/page.tsx
10. apps/web/app/(use-page-wrapper)/apps/routing-forms/forms/[[...pages]]/page.tsx
11. apps/web/app/(use-page-wrapper)/apps/routing-forms/[...pages]/page.tsx

### Translation Files (1 file)
12. apps/web/public/static/locales/en/common.json

### Logo Assets (6 files)
13-18. apps/web/public/bookph-*.svg (6 logo files)

**Total: 18 files modified/created**

## What Was NOT Changed

Following the principle of minimal changes and maintaining compatibility:

### Technical References Preserved
- Internal workspace names (@calcom/*)
- Package scopes in dependencies
- Cal.com references in technical comments
- Cal.com references in backend configuration comments
- License information and links to Cal.com repository

### Infrastructure
- Build configuration
- Test setup
- Development tooling
- CI/CD workflows (to be configured separately)

## Philippine-Specific Features (Future)

While the current rebranding focuses on visual and textual changes, the following Philippine-specific features are planned:

1. **Currency Support**: Philippine Peso (₱) as default
2. **Time Zone**: Philippine Time (PHT/PST) as default
3. **Local Payment Integration**: GCash, PayMaya support
4. **Language Support**: Tagalog translations (in addition to English)
5. **Local Business Hours**: Default to Philippine business hours

## AGPLv3 License Compliance

✅ **Full compliance maintained:**
- Source code remains open source
- Proper attribution to Cal.com in README.md
- AGPLv3 license file preserved
- Commercial use allowed under AGPLv3 terms
- Fork clearly identified as based on Cal.com

## Deployment Notes

### Environment Variables to Set

When deploying BookPH, ensure these environment variables are configured:

```bash
# Core URLs
NEXT_PUBLIC_WEBAPP_URL="https://bookph.com"
NEXT_PUBLIC_WEBSITE_URL="https://bookph.com"

# Branding
NEXT_PUBLIC_APP_NAME="BookPH"
NEXT_PUBLIC_COMPANY_NAME="BookPH"
NEXT_PUBLIC_SUPPORT_MAIL_ADDRESS="help@bookph.com"

# Email
EMAIL_FROM="notifications@bookph.com"
EMAIL_FROM_NAME="BookPH"

# Database (configure as needed)
DATABASE_URL="postgresql://..."

# Authentication (generate new secrets)
NEXTAUTH_SECRET="<generate-with-openssl>"
CALENDSO_ENCRYPTION_KEY="<generate-with-openssl>"
```

### Generate Secrets
```bash
openssl rand -base64 32  # For NEXTAUTH_SECRET
openssl rand -base64 32  # For CALENDSO_ENCRYPTION_KEY
```

### Logo Assets
All logo assets are included in `apps/web/public/` and will be served automatically. No additional CDN configuration needed for logos.

## Testing Checklist

Before going live, verify:

- [ ] All pages display "BookPH" instead of "Cal.com"
- [ ] Logo appears correctly on all pages
- [ ] Email notifications use bookph.com addresses
- [ ] Brand colors (Philippine blue/yellow) are visible
- [ ] No broken logo links (check browser console)
- [ ] Page titles and metadata show "BookPH"
- [ ] Authentication flows work correctly
- [ ] Video conferencing displays correct logo
- [ ] Social sharing cards (OG images) show BookPH

## Next Steps

### Immediate (Phase 3)
1. Set up production environment
2. Configure DNS for bookph.com
3. Set up email service (SendGrid/similar)
4. Deploy to production hosting
5. SSL certificate configuration

### Short-term
1. Create custom OG image for social sharing
2. Add Philippine-specific payment integrations
3. Implement Tagalog translations
4. Configure SMS provider for Philippine numbers
5. Set up customer support system

### Long-term
1. Add Philippine-specific features
2. Integrate with local tools/services
3. Build Philippine freelancer community
4. Create Filipino-focused marketing materials
5. Partner with Philippine VA/freelancer platforms

## Support and Maintenance

### Version Tracking
- Base fork: Cal.com v3.x (check actual version)
- BookPH customizations tracked in this repository
- Follow Cal.com upstream for security updates

### Update Strategy
1. Monitor Cal.com releases
2. Cherry-pick security fixes
3. Test updates in staging environment
4. Maintain BookPH customizations during updates

## Attribution

BookPH is built on [Cal.com](https://github.com/calcom/cal.com), the open-source scheduling infrastructure. We maintain full compliance with the AGPLv3 license and contribute improvements back to the community where possible.

---

**Repository**: https://github.com/Be1l-ai/bookph
**Based on**: https://github.com/calcom/cal.com
**License**: AGPLv3
**Target Market**: Philippines
