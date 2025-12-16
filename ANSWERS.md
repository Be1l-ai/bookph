# Quick Answers to Your Questions

This document provides direct answers to your three questions with links to detailed guides.

---

## ❓ Question 1: Supabase Extensions

### Q: Are there any specific extensions I need to enable in Supabase (like uuid-ossp) to make Cal.com work?

### ✅ Answer: NO - No extensions needed!

**Explanation:**
- BookPH uses UUID fields extensively in the database schema
- PostgreSQL 13+ has **built-in UUID support** without any extensions
- Supabase provides PostgreSQL 15+ by default
- The `uuid-ossp` extension is **not required**

**What you need instead:**
Just the connection strings:

```bash
# For migrations (direct connection, port 5432)
DATABASE_DIRECT_URL="postgresql://postgres:[PASSWORD]@[PROJECT-REF].supabase.co:5432/postgres"

# For application (pooled, port 6543)
DATABASE_URL="postgresql://postgres:[PASSWORD]@[PROJECT-REF].supabase.co:6543/postgres?pgbouncer=true"
```

📖 **Full guide**: [SUPABASE_SETUP.md](./SUPABASE_SETUP.md)

---

## ❓ Question 2: Email Configuration for Brevo

### Q: What .env variables do I need to fill out to connect an external SMTP provider like Brevo?

### ✅ Answer: Six variables

Add these to your `.env` file:

```bash
# Sender information
EMAIL_FROM='notifications@yourdomain.com'      # Your verified sender email
EMAIL_FROM_NAME='BookPH'                       # Display name in emails

# Brevo SMTP settings
EMAIL_SERVER_HOST='smtp-relay.brevo.com'       # Brevo SMTP host
EMAIL_SERVER_PORT=587                          # Port (587 for TLS, 465 for SSL)
EMAIL_SERVER_USER='your-brevo-login@example.com'  # Your Brevo account email
EMAIL_SERVER_PASSWORD='xkeysib-xxxxx...'       # SMTP key (NOT account password!)
```

**How to get these values:**

1. **Sign up at [brevo.com](https://www.brevo.com)** (free: 300 emails/day)

2. **Get SMTP credentials:**
   - Go to: Settings → SMTP & API → SMTP tab
   - Click "Generate a new SMTP key"
   - **Copy the key immediately** (can't view later!)
   - This key is your `EMAIL_SERVER_PASSWORD`

3. **Verify your domain** (required for delivery):
   - Go to: Senders & IP → Domains
   - Add your domain and configure DNS records (SPF, DKIM, DMARC)

4. **Test:**
   - Start BookPH
   - Try password reset
   - Check if email arrives

📖 **Full guide with alternatives**: [EMAIL_SETUP.md](./EMAIL_SETUP.md)

---

## ❓ Question 3: Cal.com Branding

### Q: Are there any 'Cal.com' trademarks, logos, or brand mentions that we missed in our rebranding pass?

### ✅ Answer: Yes - Comprehensive audit completed

**Summary of findings:**

| Location | References Found | Priority | Status |
|----------|-----------------|----------|---------|
| `site.webmanifest` | 2 (name, description) | 🔴 Critical | ✅ Fixed |
| Logo files | 7 SVG files | 🔴 Critical | ⏳ Needs design |
| OAuth buttons | 8 SVG files | 🔴 Critical | ⏳ Needs design |
| Email images | 1 PNG file | 🔴 Critical | ⏳ Needs review |
| README.md | 121 references | 🟡 Medium | 📋 Documented |
| Translation files | 42 files | 🟢 Low | ✅ Handled by .env |

### 🔴 Critical Items (End User Visible)

**Logo files to replace** (7 files):
```
apps/web/public/
├── cal-logo-word.svg
├── cal-logo-word-dark.svg
├── cal-logo-word-black.svg
├── cal-com-icon.svg
├── cal-com-icon-white.svg
├── calcom-logo-white-word.svg
└── calcom-white.svg
```

**OAuth buttons to update** (8 files):
```
apps/web/public/
├── continue-with-calcom-light-squared.svg
├── continue-with-calcom-light-rounded.svg
├── continue-with-calcom-dark-squared.svg
├── continue-with-calcom-dark-rounded.svg
├── continue-with-calcom-neutral-squared.svg
├── continue-with-calcom-neutral-rounded.svg
├── continue-with-calcom-coss-ui.svg
└── continue-with-calcom-coss-ui-light.svg
```

**Email template image:**
```
apps/web/public/emails/CalLogo@2x.png
```

### ✅ Good News

**Already branded correctly via .env:**
```bash
NEXT_PUBLIC_APP_NAME="BookPH"
NEXT_PUBLIC_COMPANY_NAME="BookPH"  
NEXT_PUBLIC_SUPPORT_MAIL_ADDRESS="help@bookph.com"
EMAIL_FROM_NAME='BookPH'
```

These environment variables override most user-facing strings, so end users already see "BookPH" in the application!

### 📝 What About README.md?

**121 Cal.com references found**, categorized as:

1. **Attribution** (required by AGPLv3 license) - ✅ Keep
2. **Technical documentation links** - ✅ Keep as reference
3. **Marketing/badges** - 🟡 Consider adding context
4. **Integration examples** - 🟡 Can update to bookph.com

**Note**: You **must** keep Cal.com attribution per AGPLv3 license. The README already has proper attribution in lines 63-65.

📖 **Complete audit with priorities**: [BRANDING_AUDIT.md](./BRANDING_AUDIT.md)

---

## 🎯 Action Items

### Done ✅
- [x] Audited all Cal.com references
- [x] Updated `site.webmanifest`
- [x] Documented Supabase setup (no extensions needed)
- [x] Documented email configuration (Brevo guide)
- [x] Created comprehensive guides

### To Do ⏳
1. **Create BookPH logo files** (7 SVG files needed)
2. **Design OAuth buttons** (8 SVG files needed)
3. **Update email logo** (1 PNG file)
4. **Optional**: Update README marketing copy

### Resources 📚
- [SETUP_CHECKLIST.md](./SETUP_CHECKLIST.md) - Quick start guide
- [SUPABASE_SETUP.md](./SUPABASE_SETUP.md) - Database setup
- [EMAIL_SETUP.md](./EMAIL_SETUP.md) - Email configuration
- [BRANDING_AUDIT.md](./BRANDING_AUDIT.md) - Complete audit

---

## 🚀 Quick Start

If you want to get BookPH running **right now**:

1. **Follow the checklist**: [SETUP_CHECKLIST.md](./SETUP_CHECKLIST.md)

2. **Three main steps**:
   ```bash
   # 1. Database
   DATABASE_URL="your-supabase-pooled-connection"
   DATABASE_DIRECT_URL="your-supabase-direct-connection"
   
   # 2. Email  
   EMAIL_SERVER_HOST='smtp-relay.brevo.com'
   EMAIL_SERVER_PORT=587
   EMAIL_SERVER_USER='your-brevo-email'
   EMAIL_SERVER_PASSWORD='your-brevo-smtp-key'
   
   # 3. Secrets
   NEXTAUTH_SECRET="$(openssl rand -base64 32)"
   CALENDSO_ENCRYPTION_KEY="$(openssl rand -base64 32)"
   ```

3. **Run migrations**:
   ```bash
   yarn workspace @calcom/prisma db-migrate
   ```

4. **Start development**:
   ```bash
   yarn dev
   ```

Visit `http://localhost:3000` and complete the setup wizard!

---

## 📞 Need Help?

- **Supabase issues**: See [SUPABASE_SETUP.md](./SUPABASE_SETUP.md) troubleshooting section
- **Email not working**: See [EMAIL_SETUP.md](./EMAIL_SETUP.md) troubleshooting section  
- **Branding questions**: See [BRANDING_AUDIT.md](./BRANDING_AUDIT.md) priority guide
- **General setup**: See [SETUP_CHECKLIST.md](./SETUP_CHECKLIST.md) common issues

**GitHub Issues**: [github.com/Be1l-ai/bookph/issues](https://github.com/Be1l-ai/bookph/issues)

---

## ✨ Summary

| Question | Short Answer | Details |
|----------|-------------|---------|
| Supabase extensions? | ❌ None needed | [SUPABASE_SETUP.md](./SUPABASE_SETUP.md) |
| Email variables? | ✅ 6 variables | [EMAIL_SETUP.md](./EMAIL_SETUP.md) |
| Cal.com branding? | ⚠️ 15+ files need design | [BRANDING_AUDIT.md](./BRANDING_AUDIT.md) |

**Status**: All questions answered with comprehensive documentation. Setup ready to proceed! 🎉
