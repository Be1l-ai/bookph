# BookPH Branding Audit - Cal.com References

This document lists all Cal.com branding and references found in the public folder and README.md that need to be reviewed and potentially updated for BookPH.

## Summary

- **README.md**: 121 Cal.com references found
- **Public folder**: 25+ logo files with Cal.com branding
- **Translation files**: 42 language files contain Cal.com references
- **Site manifest**: Updated ✅

## 1. Public Folder - Logo and Image Files

### Priority: HIGH - Visual Branding (Should be replaced/removed)

These files contain Cal.com visual branding:

```
apps/web/public/
├── cal-logo-word.svg ⚠️ Cal.com logo with text
├── cal-logo-word-dark.svg ⚠️ Cal.com logo (dark variant)
├── cal-logo-word-black.svg ⚠️ Cal.com logo (black variant)
├── cal-com-icon.svg ⚠️ Cal.com icon
├── cal-com-icon-white.svg ⚠️ Cal.com icon (white variant)
├── calcom-logo-white-word.svg ⚠️ Cal.com logo (white with text)
├── calcom-white.svg ⚠️ Cal.com white logo
├── continue-with-calcom-light-squared.svg ⚠️ OAuth button
├── continue-with-calcom-light-rounded.svg ⚠️ OAuth button
├── continue-with-calcom-dark-squared.svg ⚠️ OAuth button
├── continue-with-calcom-dark-rounded.svg ⚠️ OAuth button
├── continue-with-calcom-neutral-squared.svg ⚠️ OAuth button
├── continue-with-calcom-neutral-rounded.svg ⚠️ OAuth button
├── continue-with-calcom-coss-ui.svg ⚠️ OAuth button
└── continue-with-calcom-coss-ui-light.svg ⚠️ OAuth button
```

**Email Template Images:**
```
apps/web/public/emails/
├── CalLogo@2x.png ⚠️ Cal.com logo used in emails
├── calendar-email-hero.png (check content)
├── calendarCircle@2x.png (generic, probably OK)
└── calendar@2x.png (generic, probably OK)
```

**Recommendation:**
- Replace Cal.com logos with BookPH equivalents
- Update "continue-with-calcom" buttons to "continue-with-bookph"
- Check email template images for Cal.com branding

### Priority: MEDIUM - App-Related Images

These might reference Cal.com internally but aren't directly visible:

```
apps/web/public/
├── cal-ai-workflow-sidebar.jpg (check content)
└── site.webmanifest ✅ UPDATED
```

**Note**: There's already a `bookph-logo-white-word.svg` file which is good!

## 2. README.md - Documentation References

### Priority: MEDIUM - Attribution (Should Keep But Update Context)

The README contains proper attribution to Cal.com as the upstream project. This is required by the AGPLv3 license. However, some references can be updated for clarity.

#### Lines 12, 27-42: Badges and Metrics
```markdown
Forked from Cal.com and customized for Philippine market
```

**Current badges reference:**
- Cal.com GitHub repo stats
- Cal.com Product Hunt badges
- Cal.com Hacker News threads
- Links to status.cal.com, hub.docker.com/r/calcom/cal.com

**Recommendation**: Consider these approaches:
1. **Keep as-is**: Attribution to upstream (required by license)
2. **Add context**: Add note like "These metrics are for the upstream Cal.com project"
3. **Replace selectively**: Keep attribution links, update badges to BookPH where applicable

#### Lines 49-89: Marketing Content
- References to Cal.com features and pricing
- Product Hunt embedding of Cal.com
- Hacker News badges for Cal.com discussions

**Recommendation**: Update to reflect BookPH's Philippine market focus while maintaining attribution.

#### Lines 95-103: Built With & Attribution Sections
```markdown
BookPH is built on top of Cal.com's proven technology stack:
```

**Recommendation**: Keep this - it's proper attribution.

#### Line 141: Windows Installation Note
```markdown
See [docs](https://cal.com/docs/how-to-troubleshoot-symbolic-link-issues-on-windows#enable-symbolic-links)
```

**Recommendation**: These documentation links can be kept as they're technical references.

#### Lines 219: Gitpod Button
```markdown
[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/calcom/cal.com)
```

**Recommendation**: Update to BookPH repo URL if you want Gitpod support, or remove.

#### Lines 392-680: Deployment & Docker Instructions
Multiple references to:
- Docker images: `calcom/cal.com`
- Documentation links: `github.com/calcom/cal.com`
- Terms/Privacy URLs: `https://cal.com/terms`, `https://cal.com/privacy`

**Recommendation**:
- Docker: Keep references to official images (you're using them)
- Docs: Keep technical documentation links
- Terms/Privacy: Update to BookPH URLs in `.env` configuration examples

#### Lines 767-858: Integration Setup
References to Cal.com documentation for setting up integrations:
```markdown
@see https://github.com/calcom/cal.com#obtaining-the-google-api-credentials
```

**Recommendation**: Keep these - they're technical documentation references.

#### Lines 886-914: Workflows and Email Setup
References to Cal.com in comments and examples.

**Recommendation**: Update examples to use bookph.com instead of cal.com where appropriate.

## 3. Translation Files

### Priority: LOW - Internal Strings

42 translation files contain Cal.com references, including:
- `common.json` in various languages
- References like "Cal.com", "cal.com", "support@cal.com"
- Technical strings for administrators

**Examples from English translation:**
```json
"create_your_calcom_account": "Create your Cal.com account"
"enterprise_license_sales": "contact support@cal.com for help"
"custom_subdomain": "Yourcompany.cal.com subdomain"
```

**Recommendation**:
- **Keep most technical references**: They're for internal/admin use
- **Update user-facing strings**: Anything end users see should be BookPH
- **Keep support email as-is**: Or update to your own support email in `.env`

**Note**: Many of these translation strings are overridden by environment variables like:
- `NEXT_PUBLIC_APP_NAME="BookPH"` (from .env.example ✅)
- `NEXT_PUBLIC_SUPPORT_MAIL_ADDRESS="help@bookph.com"` (from .env.example ✅)

## 4. Priority Ranking

### 🔴 CRITICAL (End User Visible)
1. ✅ `site.webmanifest` - COMPLETED
2. ⚠️ Cal.com logo files in `/public` - NEEDS REPLACEMENT
3. ⚠️ Email template images - REVIEW NEEDED
4. ⚠️ "Continue with Cal.com" OAuth buttons - NEEDS UPDATING

### 🟡 MEDIUM (Documentation & Attribution)
1. README.md badges (consider adding BookPH context)
2. README.md marketing copy (update to Philippine market focus)
3. Docker deployment URLs (consider creating bookph-specific instructions)

### 🟢 LOW (Internal / Already Handled by .env)
1. Translation files (mostly handled by .env config)
2. Code comments and technical docs (keep for reference)
3. Integration setup instructions (keep as technical reference)

## 5. Recommended Actions

### Immediate Actions:
1. ✅ Update `site.webmanifest` - DONE
2. Create BookPH logo files to replace Cal.com logos
3. Update OAuth button SVGs to say "Continue with BookPH"
4. Review and update email template images

### Review & Consider:
1. Keep proper AGPLv3 attribution to Cal.com in README
2. Update marketing sections to focus on Philippine market
3. Add note to README badges explaining they reference upstream
4. Replace Gitpod button URL to point to BookPH repo

### Low Priority:
1. Translation files (most are overridden by environment variables)
2. Technical documentation links (useful references)
3. Integration setup guides (keep as reference)

## 6. Already Configured Correctly

Good news! These are already set correctly in `.env.example`:

```bash
NEXT_PUBLIC_APP_NAME="BookPH" ✅
NEXT_PUBLIC_SUPPORT_MAIL_ADDRESS="help@bookph.com" ✅
NEXT_PUBLIC_COMPANY_NAME="BookPH" ✅
EMAIL_FROM='notifications@bookph.com' ✅
EMAIL_FROM_NAME='BookPH' ✅
```

These environment variables override many of the translation strings, so end users will see "BookPH" in the application.

## 7. License Compliance Note

⚠️ **Important**: Cal.com is licensed under AGPLv3, which requires:

1. **Attribution**: Must acknowledge Cal.com as the original source
2. **License preservation**: LICENSE file must remain
3. **Source code availability**: Modifications must be made available

The README.md properly includes attribution (lines 63-65):
```markdown
## Attribution
BookPH is forked from [Cal.com](https://github.com/calcom/cal.com), 
the open-source Calendly successor. We maintain compliance with the 
AGPLv3 license and contribute improvements back to the open-source community.
```

**Recommendation**: Keep this attribution and ensure LICENSE file is not modified.

## 8. Next Steps

To complete the rebranding:

1. **Design new logos**: Create BookPH equivalents for all Cal.com logo files
2. **Replace images**: Update all files in the "CRITICAL" section
3. **Update README**: Add Philippine market context while keeping attribution
4. **Test application**: Verify no Cal.com branding appears to end users
5. **Check emails**: Send test emails to verify email templates use BookPH branding

## Files to Review Manually

These files might contain embedded Cal.com references:
- [ ] `cal-ai-workflow-sidebar.jpg` - Check image content
- [ ] `calendar-email-hero.png` - Check image content  
- [ ] Any other PNG/JPG files in public folder

Would you like me to proceed with any of these changes?
