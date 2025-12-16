# BookPH Setup Checklist

Quick reference guide for setting up your BookPH instance. This checklist combines all the information from the detailed setup guides.

## 📋 Pre-Flight Checklist

Before you begin, make sure you have:

- [ ] Node.js 18+ installed
- [ ] Yarn package manager
- [ ] A Supabase account (or PostgreSQL 13+ database)
- [ ] An email service account (Brevo recommended)
- [ ] A domain name for your BookPH instance

## 🗄️ Database Setup (Supabase)

**Good news**: No PostgreSQL extensions needed!

### Steps:

1. **Create Supabase Project**
   - Go to [supabase.com](https://supabase.com)
   - Create a new project
   - Choose a region close to your users (Asia Pacific for Philippines)
   - Note your database password

2. **Get Connection Strings**
   - Go to Project Settings → Database
   - Copy both connection strings:
     - **Connection string** (port 5432) - for migrations
     - **Connection pooling string** (port 6543) - for app

3. **Update .env File**
   ```bash
   # Direct connection (for migrations)
   DATABASE_DIRECT_URL="postgresql://postgres:[PASSWORD]@[PROJECT-REF].supabase.co:5432/postgres"
   
   # Pooled connection (for application)
   DATABASE_URL="postgresql://postgres:[PASSWORD]@[PROJECT-REF].supabase.co:6543/postgres?pgbouncer=true"
   ```

4. **Run Migrations**
   ```bash
   yarn workspace @calcom/prisma db-migrate
   ```

📖 **Detailed guide**: See [SUPABASE_SETUP.md](./SUPABASE_SETUP.md)

---

## 📧 Email Configuration (Brevo)

### Quick Setup:

1. **Create Brevo Account**
   - Sign up at [brevo.com](https://www.brevo.com)
   - Verify your email
   - Free tier: 300 emails/day

2. **Get SMTP Credentials**
   - Navigate to: Settings → SMTP & API → SMTP tab
   - Click "Generate a new SMTP key"
   - Name it (e.g., "BookPH Production")
   - **Copy the key immediately** (can't view it again!)

3. **Verify Your Domain** (Important!)
   - Go to Senders & IP → Domains
   - Add your domain
   - Add DNS records: SPF, DKIM, DMARC
   - Wait for verification (few minutes to hours)

4. **Update .env File**
   ```bash
   EMAIL_FROM='notifications@yourdomain.com'
   EMAIL_FROM_NAME='BookPH'
   EMAIL_SERVER_HOST='smtp-relay.brevo.com'
   EMAIL_SERVER_PORT=587
   EMAIL_SERVER_USER='your-brevo-email@example.com'
   EMAIL_SERVER_PASSWORD='xkeysib-xxxxxxxxxxxxx'  # SMTP key from step 2
   ```

5. **Test Email Sending**
   - Start BookPH
   - Try password reset or create test booking
   - Check inbox (and spam folder!)

📖 **Detailed guide**: See [EMAIL_SETUP.md](./EMAIL_SETUP.md)

---

## 🎨 Branding Updates

### Completed ✅
- [x] `site.webmanifest` - Updated to BookPH

### To Do (Requires Design Assets):

1. **Logo Files to Replace**
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

2. **OAuth Buttons to Update**
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

3. **Email Template Images**
   ```
   apps/web/public/emails/
   └── CalLogo@2x.png
   ```

### Already Configured ✅

These .env variables ensure "BookPH" appears to end users:
```bash
NEXT_PUBLIC_APP_NAME="BookPH"
NEXT_PUBLIC_COMPANY_NAME="BookPH"
NEXT_PUBLIC_SUPPORT_MAIL_ADDRESS="help@bookph.com"
EMAIL_FROM_NAME='BookPH'
```

📖 **Detailed audit**: See [BRANDING_AUDIT.md](./BRANDING_AUDIT.md)

---

## 🚀 Complete Setup Flow

### 1. Clone & Install
```bash
git clone https://github.com/Be1l-ai/bookph.git
cd bookph
yarn install
```

### 2. Environment Setup
```bash
cp .env.example .env
```

Edit `.env` and configure:
- [ ] `DATABASE_URL` (Supabase pooled connection)
- [ ] `DATABASE_DIRECT_URL` (Supabase direct connection)
- [ ] `NEXTAUTH_SECRET` (generate with `openssl rand -base64 32`)
- [ ] `CALENDSO_ENCRYPTION_KEY` (generate with `openssl rand -base64 32`)
- [ ] `EMAIL_SERVER_*` variables (Brevo SMTP)
- [ ] `EMAIL_FROM` and `EMAIL_FROM_NAME`
- [ ] `NEXT_PUBLIC_WEBAPP_URL` (your domain)

### 3. Database Migration
```bash
yarn workspace @calcom/prisma db-migrate
```

### 4. Generate Prisma Client
```bash
yarn workspace @calcom/prisma generate
```

### 5. Start Development Server
```bash
yarn dev
```

Visit `http://localhost:3000` and complete the setup wizard!

---

## 🔍 Testing Your Setup

### Database Connection
```bash
# Open Prisma Studio to verify database connection
yarn db-studio
```
Visit `http://localhost:5555` to browse your database.

### Email Sending
1. Start BookPH
2. Go to password reset page
3. Enter your email
4. Check if email arrives
5. If not, check:
   - Spam folder
   - Brevo sending logs
   - Application logs for errors

### Application Access
1. Open `http://localhost:3000`
2. Complete onboarding wizard
3. Create your first event type
4. Book a test event
5. Verify email notifications

---

## 📝 Environment Variables Reference

### Required (Minimum Setup)
```bash
DATABASE_URL=''
DATABASE_DIRECT_URL=''
NEXTAUTH_SECRET=''
CALENDSO_ENCRYPTION_KEY=''
EMAIL_SERVER_HOST=''
EMAIL_SERVER_PORT=''
EMAIL_SERVER_USER=''
EMAIL_SERVER_PASSWORD=''
EMAIL_FROM=''
EMAIL_FROM_NAME=''
NEXT_PUBLIC_WEBAPP_URL=''
```

### Branding (Pre-configured)
```bash
NEXT_PUBLIC_APP_NAME="BookPH"
NEXT_PUBLIC_COMPANY_NAME="BookPH"
NEXT_PUBLIC_SUPPORT_MAIL_ADDRESS="help@bookph.com"
```

### Optional (Add as needed)
```bash
GOOGLE_API_CREDENTIALS=''  # For Google Calendar integration
TWILIO_SID=''              # For SMS reminders
STRIPE_PRIVATE_KEY=''      # For payments
# ... see .env.example for complete list
```

---

## ⚠️ Common Issues

### "relation does not exist" error
**Solution**: Make sure you ran migrations using `DATABASE_DIRECT_URL`:
```bash
yarn workspace @calcom/prisma db-migrate
```

### Emails not sending
**Solution**: Check these in order:
1. SMTP credentials are correct
2. Port 587 is not blocked by firewall
3. Sender domain is verified in Brevo
4. Check Brevo sending logs
5. Look for errors in BookPH logs

### "Invalid login credentials" (SMTP)
**Solution**:
- For Brevo: Use SMTP **key** (not account password)
- Username should be your Brevo login email
- Regenerate SMTP key if needed

### Connection timeout to database
**Solution**:
- Verify Supabase project is active
- Check connection string format
- Use pooled URL (port 6543) for application
- Use direct URL (port 5432) for migrations

---

## 📚 Additional Resources

- [SUPABASE_SETUP.md](./SUPABASE_SETUP.md) - Complete database setup guide
- [EMAIL_SETUP.md](./EMAIL_SETUP.md) - Comprehensive email configuration
- [BRANDING_AUDIT.md](./BRANDING_AUDIT.md) - Complete branding audit
- [README.md](./README.md) - Full documentation

### External Documentation
- [Supabase Docs](https://supabase.com/docs)
- [Brevo SMTP Guide](https://help.brevo.com/hc/en-us/articles/209462765)
- [Cal.com Docs](https://cal.com/docs) (upstream reference)

---

## 🎯 Production Deployment Checklist

Before going live:

### Security
- [ ] All secrets properly configured (no defaults)
- [ ] `NEXTAUTH_SECRET` is cryptographically random
- [ ] `CALENDSO_ENCRYPTION_KEY` is cryptographically random
- [ ] Database credentials are secure
- [ ] `.env` file is not in version control

### Email
- [ ] Sender domain verified with SPF/DKIM/DMARC
- [ ] Test emails to Gmail, Outlook, Yahoo
- [ ] Emails not going to spam
- [ ] Sending limits appropriate for volume

### Database
- [ ] Using pooled connection (port 6543) in production
- [ ] Backups configured in Supabase
- [ ] Connection limit monitoring set up

### Application
- [ ] `NEXT_PUBLIC_WEBAPP_URL` set to production domain
- [ ] SSL certificate installed
- [ ] Monitoring and logging configured
- [ ] Performance testing completed

### Branding
- [ ] All Cal.com logos replaced with BookPH
- [ ] `site.webmanifest` updated
- [ ] Email templates tested
- [ ] No Cal.com references visible to end users

---

## 🆘 Need Help?

- **BookPH Issues**: [GitHub Issues](https://github.com/Be1l-ai/bookph/issues)
- **Supabase Support**: [Supabase Support](https://supabase.com/support)
- **Brevo Support**: [Brevo Help Center](https://help.brevo.com)

---

## ✅ Setup Complete!

Once you've completed this checklist, your BookPH instance should be:
- ✅ Connected to Supabase database
- ✅ Sending emails via Brevo
- ✅ Branded as BookPH (pending logo replacements)
- ✅ Ready for user onboarding

Next steps:
1. Complete the onboarding wizard
2. Create your first event type
3. Test the booking flow
4. Share your booking link!

Happy booking! 🚀🇵🇭
