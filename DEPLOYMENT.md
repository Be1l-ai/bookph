# BookPH Deployment Guide

Portions Copyright (c) 2025 BookPH

This guide will help you deploy BookPH (AGPLv3 self-hosted version) to production using Vercel and Supabase.

## What's Included

This self-hosted version of BookPH includes:

✅ **Core Scheduling Features**
- Event type creation and management
- Booking management and calendar sync
- Availability scheduling
- Email notifications
- Calendar integrations (Google Calendar, etc.)
- Payment integrations
- Workflows and automations
- Routing forms
- Video conferencing integrations

❌ **Enterprise Features (Disabled)**
- Teams and Organizations
- SSO/SAML authentication
- Enterprise billing
- Premium support integrations

If you need enterprise features, please contact [Cal.com](https://cal.com/sales) for commercial licensing.

## Prerequisites

Before you begin, you'll need:

1. **GitHub Account** - To fork/clone the repository
2. **Vercel Account** - For hosting the application (free tier available)
3. **Supabase Account** - For PostgreSQL database (free tier available)
4. **Email Service** - Gmail, Outlook, or Resend for sending emails

## Step 1: Set Up Database (Supabase)

1. Go to [Supabase](https://supabase.com) and create a new account
2. Create a new project:
   - Choose a project name (e.g., "bookph-prod")
   - Set a strong database password
   - Select a region close to your users
3. Wait for the database to be provisioned (~2 minutes)
4. Go to **Settings > Database**
5. Copy these connection strings:
   - **Connection Pooling** string → This will be your `DATABASE_URL`
   - **Direct Connection** string → This will be your `DATABASE_DIRECT_URL`

## Step 2: Deploy to Vercel

### Option A: Deploy with Vercel Button (Easiest)

1. Click the "Deploy to Vercel" button in the README (if available)
2. Connect your GitHub account
3. Fork/clone the repository when prompted
4. Configure environment variables (see Step 3)

### Option B: Manual Deployment

1. Go to [Vercel](https://vercel.com) and sign in
2. Click "Add New..." → "Project"
3. Import your BookPH repository from GitHub
4. Configure the project:
   - **Framework Preset**: Next.js
   - **Root Directory**: `./` (keep as is)
   - **Build Command**: `yarn build` (default)
   - **Output Directory**: `.next` (default)

## Step 3: Configure Environment Variables

In your Vercel project, go to **Settings > Environment Variables** and add the following:

### Required Variables

```bash
# Database
DATABASE_URL=                      # From Supabase (Connection Pooling)
DATABASE_DIRECT_URL=              # From Supabase (Direct Connection)

# App URLs (replace with your Vercel URL)
NEXT_PUBLIC_WEBAPP_URL=https://your-app.vercel.app
NEXT_PUBLIC_WEBSITE_URL=https://your-app.vercel.app
NEXTAUTH_URL=https://your-app.vercel.app
NEXT_PUBLIC_EMBED_LIB_URL=https://your-app.vercel.app/embed/embed.js

# NextAuth Secret (generate with: openssl rand -base64 32)
NEXTAUTH_SECRET=your-random-secret-here

# Encryption Key (generate with: openssl rand -base64 32)
CALENDSO_ENCRYPTION_KEY=your-encryption-key-here

# Email Configuration
EMAIL_FROM=notifications@yourdomain.com
EMAIL_FROM_NAME=BookPH
EMAIL_SERVER_HOST=smtp.gmail.com
EMAIL_SERVER_PORT=465
EMAIL_SERVER_USER=your-email@gmail.com
EMAIL_SERVER_PASSWORD=your-app-password

# Branding
NEXT_PUBLIC_APP_NAME=BookPH
NEXT_PUBLIC_SUPPORT_MAIL_ADDRESS=help@yourdomain.com
NEXT_PUBLIC_COMPANY_NAME=BookPH

# Telemetry (already disabled)
CALCOM_TELEMETRY_DISABLED=1
```

### Optional Variables

```bash
# Google Calendar Integration
GOOGLE_API_CREDENTIALS={"web":{"client_id":"...","client_secret":"..."}}
GOOGLE_LOGIN_ENABLED=false

# Cloudflare Turnstile (Bot Protection)
NEXT_PUBLIC_CLOUDFLARE_SITEKEY=
CLOUDFLARE_TURNSTILE_SECRET=

# SMS Notifications (Twilio)
TWILIO_SID=
TWILIO_TOKEN=
TWILIO_MESSAGING_SID=
TWILIO_PHONE_NUMBER=
```

💡 **Tip**: See `.env.bookph.example` for a complete template with instructions.

## Step 4: Deploy and Run Migrations

1. Click "Deploy" in Vercel
2. Wait for the deployment to complete (~5-10 minutes)
3. Once deployed, go to your Vercel project dashboard
4. Navigate to **Settings > Functions**
5. Find the "Run Command" section
6. Run the following command to set up the database:

```bash
yarn workspace @calcom/prisma db-migrate
```

Alternatively, you can run migrations locally:

```bash
# Clone the repo locally
git clone https://github.com/Be1l-ai/bookph.git
cd bookph

# Install dependencies
yarn install

# Set your DATABASE_DIRECT_URL
export DATABASE_DIRECT_URL="your-direct-connection-string"

# Run migrations
yarn workspace @calcom/prisma db-migrate
```

## Step 5: Set Up Email Service

### Option A: Gmail (Development/Small Scale)

1. Enable 2-Factor Authentication on your Google Account
2. Generate an App Password:
   - Go to https://myaccount.google.com/apppasswords
   - Select "Mail" and your device
   - Copy the generated password
3. Use these settings:
   ```
   EMAIL_SERVER_HOST=smtp.gmail.com
   EMAIL_SERVER_PORT=465
   EMAIL_SERVER_USER=your-email@gmail.com
   EMAIL_SERVER_PASSWORD=your-16-char-app-password
   ```

### Option B: Resend (Recommended for Production)

1. Sign up at [Resend](https://resend.com)
2. Verify your domain
3. Generate an API key
4. Add to Vercel environment variables:
   ```
   RESEND_API_KEY=re_your_api_key_here
   ```

## Step 6: Configure Custom Domain (Optional)

1. Go to your Vercel project
2. Navigate to **Settings > Domains**
3. Add your custom domain (e.g., bookph.com)
4. Follow Vercel's instructions to configure DNS
5. Update environment variables:
   ```
   NEXT_PUBLIC_WEBAPP_URL=https://bookph.com
   NEXT_PUBLIC_WEBSITE_URL=https://bookph.com
   NEXTAUTH_URL=https://bookph.com
   ```

## Step 7: Create Your First User

1. Visit your deployed site: `https://your-app.vercel.app`
2. Click "Sign up"
3. Enter your email and password
4. Check your email for verification
5. Complete the onboarding process

## Maintenance

### Updating BookPH

To update to the latest version:

```bash
# Pull latest changes
git pull origin main

# Push to trigger Vercel deployment
git push
```

### Backup Your Database

Supabase automatically backs up your database. You can also:

1. Go to Supabase dashboard
2. Navigate to **Database > Backups**
3. Download a backup or set up automatic backups

### Monitoring

- **Vercel Analytics**: Built-in performance monitoring
- **Supabase Logs**: Database query performance
- **Application Logs**: Check Vercel function logs for errors

## Troubleshooting

### Database Connection Issues

- Verify your connection strings are correct
- Check that Vercel can reach Supabase (should work by default)
- Ensure you're using the pooling connection for `DATABASE_URL`

### Email Not Sending

- Verify SMTP credentials
- Check spam folder
- Test with a simple SMTP testing tool
- Consider using Resend for better deliverability

### Build Failures

- Check Vercel build logs
- Ensure all environment variables are set
- Try rebuilding with "Clear Cache and Redeploy"

## Support

For issues and questions:

- **GitHub Issues**: https://github.com/Be1l-ai/bookph/issues
- **Discussions**: https://github.com/Be1l-ai/bookph/discussions
- **Original Cal.com Docs**: https://cal.com/docs (for general features)

## License

This deployment guide is part of BookPH, licensed under AGPLv3.

Copyright (c) 2020-present Cal.com, Inc.
Portions Copyright (c) 2025 BookPH

Remember: As required by AGPLv3, you must provide your users with access to the source code. This is automatically done through the "Source Code" links we've added to the application.
