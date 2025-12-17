# BookPH Self-Hosting Quick Start

Portions Copyright (c) 2025 BookPH

Get BookPH running on Vercel + Supabase in under 30 minutes.

## What You'll Deploy

**BookPH Core Features** (AGPLv3):
- ✅ Event types & booking management
- ✅ Calendar integrations (Google, Outlook, etc.)
- ✅ Email notifications & reminders
- ✅ Payment processing (Stripe)
- ✅ Video conferencing integrations
- ✅ Workflows & automation
- ✅ Custom availability rules
- ✅ Routing forms

**Not Included** (Requires Cal.com Commercial License):
- ❌ Teams & Organizations
- ❌ SSO/SAML authentication
- ❌ Enterprise billing features

## Prerequisites (5 minutes)

1. **GitHub Account** - [Sign up](https://github.com/signup)
2. **Vercel Account** - [Sign up](https://vercel.com/signup) (free tier)
3. **Supabase Account** - [Sign up](https://supabase.com) (free tier)
4. **Email for SMTP** - Gmail, Outlook, or Resend

## Step 1: Database Setup (5 minutes)

### Create Supabase Database

1. Go to [supabase.com](https://supabase.com) → "New Project"
2. Fill in:
   - **Name**: bookph-prod
   - **Database Password**: (generate a strong password)
   - **Region**: Choose closest to your users
3. Click "Create new project" (takes ~2 minutes)

### Get Connection Strings

1. Go to **Settings** → **Database**
2. Copy **two** connection strings:

   **For DATABASE_URL** - Use "Connection Pooling":
   ```
   postgresql://postgres.[ID]:[PASSWORD]@aws-0-us-east-1.pooler.supabase.com:6543/postgres
   ```

   **For DATABASE_DIRECT_URL** - Use "Direct Connection":
   ```
   postgresql://postgres.[ID]:[PASSWORD]@db.[ID].supabase.co:5432/postgres
   ```

💡 **Tip**: Save these in a text file - you'll need them in Step 2.

## Step 2: Deploy to Vercel (10 minutes)

### Fork Repository

1. Go to [github.com/Be1l-ai/bookph](https://github.com/Be1l-ai/bookph)
2. Click "Fork" (top right)
3. Create fork in your account

### Deploy to Vercel

1. Go to [vercel.com](https://vercel.com) → "Add New..." → "Project"
2. Import your forked bookph repository
3. Configure:
   - **Framework**: Next.js (auto-detected)
   - **Root Directory**: ./
   - **Build Command**: yarn build
   - **Output Directory**: .next

4. **Don't deploy yet!** Click "Environment Variables" first.

### Add Environment Variables

Copy and paste this template, replacing the values:

```bash
# Database (from Supabase - Step 1)
DATABASE_URL=postgresql://postgres.[ID]:[PASSWORD]@aws-0-us-east-1.pooler.supabase.com:6543/postgres
DATABASE_DIRECT_URL=postgresql://postgres.[ID]:[PASSWORD]@db.[ID].supabase.co:5432/postgres

# App URLs (Vercel will give you this URL - use it here)
# First deployment: use https://your-project-name.vercel.app
# After custom domain: use your domain
NEXT_PUBLIC_WEBAPP_URL=https://bookph.vercel.app
NEXT_PUBLIC_WEBSITE_URL=https://bookph.vercel.app
NEXTAUTH_URL=https://bookph.vercel.app
NEXT_PUBLIC_EMBED_LIB_URL=https://bookph.vercel.app/embed/embed.js

# Security Keys (generate these with commands below)
NEXTAUTH_SECRET=paste-your-32-char-secret-here
CALENDSO_ENCRYPTION_KEY=paste-your-32-char-key-here

# Email (Gmail example - see options below)
EMAIL_FROM=notifications@yourdomain.com
EMAIL_FROM_NAME=BookPH
EMAIL_SERVER_HOST=smtp.gmail.com
EMAIL_SERVER_PORT=465
EMAIL_SERVER_USER=your-email@gmail.com
EMAIL_SERVER_PASSWORD=your-16-char-app-password

# Branding
NEXT_PUBLIC_APP_NAME=BookPH
NEXT_PUBLIC_SUPPORT_MAIL_ADDRESS=help@yourdomain.com
NEXT_PUBLIC_COMPANY_NAME=BookPH

# Telemetry (already disabled)
CALCOM_TELEMETRY_DISABLED=1
```

### Generate Security Keys

Run these commands in your terminal:

```bash
# For NEXTAUTH_SECRET
openssl rand -base64 32

# For CALENDSO_ENCRYPTION_KEY
openssl rand -base64 32
```

Copy the output and paste into Vercel environment variables.

### Email Options

**Option A: Gmail** (easiest for testing)
1. Enable 2FA on Google Account
2. Go to https://myaccount.google.com/apppasswords
3. Generate App Password
4. Use these settings:
   ```
   EMAIL_SERVER_HOST=smtp.gmail.com
   EMAIL_SERVER_PORT=465
   EMAIL_SERVER_USER=your-email@gmail.com
   EMAIL_SERVER_PASSWORD=your-16-char-app-password
   ```

**Option B: Resend** (recommended for production)
1. Sign up at [resend.com](https://resend.com)
2. Verify your domain
3. Get API key
4. Add: `RESEND_API_KEY=re_your_key_here`

**Option C: Office 365**
```
EMAIL_SERVER_HOST=smtp.office365.com
EMAIL_SERVER_PORT=587
EMAIL_SERVER_USER=your-email@outlook.com
EMAIL_SERVER_PASSWORD=your-password
```

### Deploy!

1. Click "Deploy"
2. Wait 5-10 minutes for first deployment
3. Note your Vercel URL (e.g., bookph.vercel.app)

## Step 3: Run Database Migrations (5 minutes)

### Option A: Using Vercel CLI (Recommended)

1. Install Vercel CLI:
   ```bash
   npm i -g vercel
   ```

2. Link to your project:
   ```bash
   vercel link
   ```

3. Pull environment variables:
   ```bash
   vercel env pull .env
   ```

4. Run migrations:
   ```bash
   yarn install
   yarn workspace @calcom/prisma db-migrate
   ```

### Option B: Using Local Terminal

1. Clone your fork:
   ```bash
   git clone https://github.com/YOUR-USERNAME/bookph.git
   cd bookph
   ```

2. Install dependencies:
   ```bash
   yarn install
   ```

3. Set environment variable:
   ```bash
   export DATABASE_DIRECT_URL="your-direct-connection-string-here"
   ```

4. Run migrations:
   ```bash
   yarn workspace @calcom/prisma db-migrate
   ```

## Step 4: Test Your Deployment (5 minutes)

### Create First User

1. Visit your Vercel URL: `https://your-app.vercel.app`
2. Click "Sign up"
3. Enter email and password
4. Check email for verification link
5. Click verification link
6. Complete onboarding

### Verify Features

- [ ] Can create an event type
- [ ] Can set availability
- [ ] Booking page loads (your-app.vercel.app/yourusername)
- [ ] Email notifications work
- [ ] Source code link visible (login page + sidebar)

### Common Issues

**Database Connection Error:**
- Double-check connection strings in Vercel
- Ensure you used pooling URL for DATABASE_URL
- Ensure you used direct URL for DATABASE_DIRECT_URL

**Email Not Sending:**
- Check spam folder
- Verify SMTP credentials
- Try sending a test email from your SMTP provider

**Build Failed:**
- Check Vercel build logs
- Ensure all environment variables are set
- Try "Redeploy" with "Clear Cache"

## Step 5: Optional Enhancements

### Add Custom Domain

1. Vercel → Settings → Domains
2. Add your domain (e.g., bookph.com)
3. Follow DNS configuration instructions
4. Update environment variables with new domain

### Google Calendar Integration

1. Follow [Google Calendar Setup Guide](https://github.com/calcom/cal.com#obtaining-the-google-api-credentials)
2. Add `GOOGLE_API_CREDENTIALS` to Vercel
3. Set `GOOGLE_LOGIN_ENABLED=false` (keep it as identity provider only)

### Payment Integration

1. Sign up for [Stripe](https://stripe.com)
2. Add Stripe credentials to Vercel:
   ```
   STRIPE_PRIVATE_KEY=sk_test_...
   STRIPE_CLIENT_ID=ca_...
   STRIPE_WEBHOOK_SECRET=whsec_...
   ```

### SMS Notifications

1. Sign up for [Twilio](https://twilio.com)
2. Add Twilio credentials:
   ```
   TWILIO_SID=AC...
   TWILIO_TOKEN=...
   TWILIO_MESSAGING_SID=MG...
   TWILIO_PHONE_NUMBER=+1234567890
   ```

## Maintenance

### Update BookPH

To get latest updates:

```bash
cd bookph
git pull origin main
git push
```

Vercel will automatically redeploy.

### Backup Database

Supabase automatically backs up your database. Manual backup:

1. Supabase → Database → Backups
2. Download backup file

### Monitor Performance

- **Vercel Analytics**: Vercel dashboard
- **Database Usage**: Supabase dashboard
- **Logs**: Vercel → Functions → Logs

## Costs

### Free Tier Limits

**Vercel** (Free):
- 100 GB bandwidth/month
- Unlimited projects
- Automatic SSL
- ~3 million function invocations/month

**Supabase** (Free):
- 500 MB database
- 1 GB file storage
- 2 GB bandwidth/month
- 50,000 monthly active users

**Typical Costs** (100 active users):
- Vercel: $0/month (within free tier)
- Supabase: $0/month (within free tier)
- **Total: FREE** 🎉

### Paid Upgrades (When Needed)

**Supabase Pro** ($25/month):
- 8 GB database
- 100 GB file storage
- 50 GB bandwidth
- Daily backups

**Vercel Pro** ($20/month):
- 1 TB bandwidth
- Unlimited domains
- Advanced analytics

## Next Steps

### Learn More
- **Full Deployment Guide**: [DEPLOYMENT.md](./DEPLOYMENT.md)
- **AGPLv3 Compliance**: [AGPLV3-COMPLIANCE.md](./AGPLV3-COMPLIANCE.md)
- **Environment Variables**: [.env.bookph.example](./.env.bookph.example)

### Get Help
- **GitHub Issues**: [github.com/Be1l-ai/bookph/issues](https://github.com/Be1l-ai/bookph/issues)
- **Discussions**: [github.com/Be1l-ai/bookph/discussions](https://github.com/Be1l-ai/bookph/discussions)
- **Cal.com Docs**: [cal.com/docs](https://cal.com/docs) (for general features)

### Contribute
- Star the repo ⭐
- Report bugs 🐛
- Submit pull requests 🔧
- Share with others 📢

---

**Congratulations!** 🎉 You now have a self-hosted BookPH instance running!

Remember: As an AGPLv3 project, you must provide users with access to the source code. The "Source Code" links we've added handle this automatically.

**License**: AGPLv3  
**Copyright**: Cal.com, Inc. + BookPH  
**Time to Deploy**: ~30 minutes  
**Cost**: FREE (with free tiers)
