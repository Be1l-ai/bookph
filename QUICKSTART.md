# BookPH Quick Start Guide

Get BookPH up and running in minutes.

## Prerequisites

- Node.js 18+ 
- PostgreSQL 13+
- Yarn 3.4.1 (included in repository)

## Local Development Setup

### 1. Clone the Repository

```bash
git clone https://github.com/Be1l-ai/bookph.git
cd bookph
```

### 2. Install Dependencies

```bash
yarn install
```

### 3. Set Up Environment Variables

```bash
cp .env.example .env
```

Edit `.env` and set:

```bash
# Generate these with: openssl rand -base64 32
NEXTAUTH_SECRET="your-generated-secret"
CALENDSO_ENCRYPTION_KEY="your-generated-secret"

# Database URL (use Docker or local PostgreSQL)
DATABASE_URL="postgresql://postgres:password@localhost:5432/bookph"

# App URL (for local development)
NEXT_PUBLIC_WEBAPP_URL="http://localhost:3000"
NEXT_PUBLIC_WEBSITE_URL="http://localhost:3000"
```

### 4. Set Up Database

**Option A: Using Docker (Recommended)**

```bash
yarn dx
```

This will:
- Start a PostgreSQL database
- Run migrations
- Seed test data
- Start the development server

**Option B: Using Existing PostgreSQL**

```bash
# Run migrations
yarn workspace @calcom/prisma db-migrate

# Seed database (optional)
cd packages/prisma
yarn db-seed
cd ../..
```

### 5. Start Development Server

If you didn't use `yarn dx`:

```bash
yarn dev
```

### 6. Access BookPH

Open http://localhost:3000 in your browser.

**First User Setup:**
- Option 1: Use seeded test data (if you ran db-seed)
- Option 2: Visit the setup wizard at http://localhost:3000/auth/setup

## Production Deployment

### Environment Setup

Required environment variables for production:

```bash
# === Core Configuration ===
NODE_ENV="production"
NEXT_PUBLIC_WEBAPP_URL="https://bookph.com"
NEXT_PUBLIC_WEBSITE_URL="https://bookph.com"

# === Security (Generate New!) ===
NEXTAUTH_SECRET="<new-secret-here>"
CALENDSO_ENCRYPTION_KEY="<new-secret-here>"
NEXTAUTH_URL="https://bookph.com/api/auth"

# === Database ===
DATABASE_URL="postgresql://user:pass@host:5432/bookph"
DATABASE_DIRECT_URL="postgresql://user:pass@host:5432/bookph"

# === Email (Configure your SMTP or SendGrid) ===
EMAIL_FROM="notifications@bookph.com"
EMAIL_FROM_NAME="BookPH"
EMAIL_SERVER_HOST="smtp.sendgrid.net"
EMAIL_SERVER_PORT="587"
EMAIL_SERVER_USER="apikey"
EMAIL_SERVER_PASSWORD="your-sendgrid-api-key"

# === Branding ===
NEXT_PUBLIC_APP_NAME="BookPH"
NEXT_PUBLIC_COMPANY_NAME="BookPH"
NEXT_PUBLIC_SUPPORT_MAIL_ADDRESS="help@bookph.com"
```

### Deployment Platforms

#### Vercel (Recommended)

1. Fork the repository
2. Import to Vercel
3. Set environment variables
4. Deploy

**Note:** Requires Vercel Pro Plan for serverless function limits.

#### Docker

```bash
# Build
docker-compose build

# Run
docker-compose up -d
```

#### Railway / Render / Northflank

Follow the platform-specific guides in the original Cal.com README.md, using BookPH environment variables.

## Email Configuration

### SendGrid Setup

1. Create a SendGrid account
2. Generate an API key
3. Verify sender email
4. Add to `.env`:

```bash
SENDGRID_API_KEY="your-api-key"
SENDGRID_EMAIL="notifications@bookph.com"
NEXT_PUBLIC_SENDGRID_SENDER_NAME="BookPH"
```

## Common Issues

### Issue: Database Connection Failed

**Solution:**
```bash
# Check DATABASE_URL format
# postgresql://username:password@host:port/database

# For local: postgresql://postgres:postgres@localhost:5432/bookph
# For cloud: Use connection string from provider
```

### Issue: Module not found errors

**Solution:**
```bash
# Clear cache and reinstall
rm -rf node_modules .next
yarn install
```

### Issue: Port 3000 already in use

**Solution:**
```bash
# Change port in package.json or:
PORT=3001 yarn dev
```

### Issue: Prisma Client errors

**Solution:**
```bash
# Regenerate Prisma Client
yarn prisma generate
```

## Philippine-Specific Setup

### Time Zone

Set default time zone to Philippine Time:

```bash
NEXT_PUBLIC_DEFAULT_TIMEZONE="Asia/Manila"
```

### Currency

BookPH displays ₱ (Philippine Peso) by default. To configure payment integrations:

1. Set up Stripe with PHP currency support
2. Or integrate with local payment providers (future feature)

### Language

English is default. Tagalog translations coming soon!

## Testing

```bash
# Run unit tests
yarn test

# Run e2e tests (requires running dev server)
yarn test-e2e

# Type checking
yarn type-check
```

## Building for Production

```bash
# Build all packages
yarn build

# Start production server
yarn start
```

## Helpful Commands

```bash
# Database studio (GUI for database)
yarn db-studio

# Run migrations
yarn workspace @calcom/prisma db-migrate

# Format code
yarn format

# Lint code
yarn lint:fix

# Update dependencies (be careful!)
yarn upgrade-interactive
```

## Getting Help

- **Documentation**: See REBRANDING.md for detailed changes
- **Original Cal.com Docs**: https://cal.com/docs
- **Issues**: https://github.com/Be1l-ai/bookph/issues
- **Discussions**: https://github.com/Be1l-ai/bookph/discussions

## Security Notes

⚠️ **Important:**
1. Always generate new secrets for production
2. Never commit `.env` files
3. Use strong passwords for database
4. Enable 2FA for admin accounts
5. Keep dependencies updated

## What's Next?

After setup:
1. ✅ Configure your booking page
2. ✅ Set up team members (if needed)
3. ✅ Connect calendar integrations
4. ✅ Configure video conferencing
5. ✅ Customize email templates
6. ✅ Set up payment processing
7. ✅ Add your branding/colors

## Support BookPH

BookPH is open source (AGPLv3). If you find it useful:
- ⭐ Star the repository
- 🐛 Report bugs
- 💡 Suggest features
- 🤝 Contribute improvements

---

**Happy Scheduling!** 🇵🇭
