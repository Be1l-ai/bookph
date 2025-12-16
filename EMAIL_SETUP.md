# Email Configuration Guide for BookPH

## Setting Up External SMTP Provider (Brevo)

BookPH uses email for various notifications including booking confirmations, reminders, and password resets. This guide shows you how to configure Brevo (formerly Sendinblue) or any other SMTP provider.

## Required Environment Variables

Add these to your `.env` file:

```bash
# ============================================
# EMAIL CONFIGURATION
# ============================================

# Sender Information
EMAIL_FROM='notifications@yourdomain.com'
EMAIL_FROM_NAME='BookPH'

# SMTP Server Settings
EMAIL_SERVER_HOST='smtp-relay.brevo.com'
EMAIL_SERVER_PORT=587
EMAIL_SERVER_USER='your-brevo-login-email@example.com'
EMAIL_SERVER_PASSWORD='your-brevo-smtp-key'
```

## Option 1: Brevo (Recommended for Getting Started)

### Why Brevo?
- **Free tier**: 300 emails/day
- **Reliable**: High deliverability rates
- **Easy setup**: Simple SMTP configuration
- **Transactional focus**: Built for app notifications

### Step-by-Step Setup

#### 1. Create a Brevo Account
1. Go to [https://www.brevo.com](https://www.brevo.com)
2. Sign up for a free account
3. Verify your email address

#### 2. Get SMTP Credentials
1. Log into Brevo dashboard
2. Navigate to: **Settings** → **SMTP & API**
3. Click on **SMTP** tab
4. You'll see your SMTP credentials:
   ```
   SMTP server: smtp-relay.brevo.com
   Port: 587 (recommended) or 465
   Login: your-email@example.com
   SMTP Key: [Generate a new key]
   ```

#### 3. Generate SMTP Key
1. Click "Generate a new SMTP key" or "Create a new SMTP key"
2. Give it a name (e.g., "BookPH Production")
3. **Copy the key immediately** - you won't be able to see it again
4. This is your `EMAIL_SERVER_PASSWORD`

#### 4. Verify Sender Domain (Important!)
1. Go to **Senders & IP** → **Domains**
2. Click "Add a Domain"
3. Enter your domain (e.g., `yourdomain.com`)
4. Add the required DNS records (SPF, DKIM, DMARC)
5. Wait for verification (usually takes a few minutes to hours)

#### 5. Update Your .env File
```bash
EMAIL_FROM='notifications@yourdomain.com'
EMAIL_FROM_NAME='BookPH'
EMAIL_SERVER_HOST='smtp-relay.brevo.com'
EMAIL_SERVER_PORT=587
EMAIL_SERVER_USER='your-login-email@example.com'
EMAIL_SERVER_PASSWORD='xkeysib-abc123...'  # Your SMTP key from step 3
```

## Option 2: Other SMTP Providers

### Gmail (For Development Only)

⚠️ **Not recommended for production** - Gmail has strict sending limits (100-500 emails/day).

```bash
EMAIL_FROM='your-gmail@gmail.com'
EMAIL_FROM_NAME='BookPH'
EMAIL_SERVER_HOST='smtp.gmail.com'
EMAIL_SERVER_PORT=465
EMAIL_SERVER_USER='your-gmail@gmail.com'
EMAIL_SERVER_PASSWORD='your-app-password'  # Not your regular password!
```

**Steps for Gmail:**
1. Enable 2-Factor Authentication on your Google account
2. Generate an App Password: https://support.google.com/accounts/answer/185833
3. Use the 16-character app password as `EMAIL_SERVER_PASSWORD`

### SendGrid (Alternative)

SendGrid is another popular option with a free tier (100 emails/day).

```bash
# Option A: Using SendGrid API (Recommended)
SENDGRID_API_KEY='SG.xxx...'
SENDGRID_EMAIL='notifications@yourdomain.com'
NEXT_PUBLIC_SENDGRID_SENDER_NAME='BookPH'

# Option B: Using SendGrid SMTP
EMAIL_FROM='notifications@yourdomain.com'
EMAIL_FROM_NAME='BookPH'
EMAIL_SERVER_HOST='smtp.sendgrid.net'
EMAIL_SERVER_PORT=587
EMAIL_SERVER_USER='apikey'  # Literally the word "apikey"
EMAIL_SERVER_PASSWORD='SG.xxx...'  # Your SendGrid API key
```

### Microsoft 365 / Outlook

```bash
EMAIL_FROM='your-email@outlook.com'
EMAIL_FROM_NAME='BookPH'
EMAIL_SERVER_HOST='smtp.office365.com'
EMAIL_SERVER_PORT=587
EMAIL_SERVER_USER='your-email@outlook.com'
EMAIL_SERVER_PASSWORD='your-password'
```

### AWS SES (For High Volume)

```bash
EMAIL_FROM='notifications@yourdomain.com'
EMAIL_FROM_NAME='BookPH'
EMAIL_SERVER_HOST='email-smtp.us-east-1.amazonaws.com'  # Your region
EMAIL_SERVER_PORT=587
EMAIL_SERVER_USER='your-aws-smtp-username'
EMAIL_SERVER_PASSWORD='your-aws-smtp-password'
```

## Testing Your Email Configuration

### Method 1: Using MailHog (Local Development)

For local testing without sending real emails:

```bash
# Start MailHog
docker run -d -p 8025:8025 -p 1025:1025 mailhog/mailhog

# Update .env for local testing
EMAIL_SERVER_HOST='localhost'
EMAIL_SERVER_PORT=1025

# View emails at http://localhost:8025
```

### Method 2: Test Email Sending

After configuring your SMTP settings:

1. Start your BookPH application
2. Try to reset your password or create a test booking
3. Check if you receive the email
4. Check spam folder if email doesn't arrive
5. Review application logs for SMTP errors

### Common Testing Issues

**Emails go to spam:**
- Solution: Verify your sender domain with SPF/DKIM records
- Make sure `EMAIL_FROM` uses your verified domain

**SMTP authentication failed:**
- Double-check username and password
- For Gmail: Use App Password, not regular password
- For Brevo: Use SMTP key, not account password

**Connection timeout:**
- Check firewall settings
- Try alternative port (587 vs 465)
- Verify SMTP hostname is correct

## Email Workflows (Optional)

BookPH supports automated email workflows for reminders. To enable this feature, configure SendGrid:

```bash
# For automated workflow reminders
SENDGRID_API_KEY='SG.xxx...'
SENDGRID_EMAIL='notifications@yourdomain.com'
NEXT_PUBLIC_SENDGRID_SENDER_NAME='BookPH'
```

## Important Notes

### Sender Domain Verification

⚠️ **Critical for production**: Always verify your sender domain to improve deliverability:

1. **SPF Record**: Authorizes email servers to send on your behalf
2. **DKIM**: Cryptographic signature proving email authenticity
3. **DMARC**: Policy for handling failed authentication

Most SMTP providers will give you these DNS records to add to your domain.

### Free Tier Limits

| Provider | Free Tier Limit | Notes |
|----------|----------------|-------|
| Brevo | 300 emails/day | Best for getting started |
| SendGrid | 100 emails/day | Requires sender verification |
| Gmail | ~100-500/day | Not recommended for production |
| AWS SES | 62,000/month* | *When sending from EC2 |

### Sending Limits

To avoid hitting limits:
- Use a dedicated transactional email service (Brevo, SendGrid, AWS SES)
- Monitor your email volume
- Implement email queuing for high-volume scenarios
- Consider upgrading to paid tier as you scale

## Environment Variables Reference

Complete list of email-related environment variables:

```bash
# Primary Email Configuration (Required)
EMAIL_FROM=''                       # Sender email address
EMAIL_FROM_NAME=''                  # Sender display name
EMAIL_SERVER_HOST=''                # SMTP server hostname
EMAIL_SERVER_PORT=                  # SMTP port (587 or 465)
EMAIL_SERVER_USER=''                # SMTP username
EMAIL_SERVER_PASSWORD=''            # SMTP password/key

# SendGrid API (Alternative to SMTP)
SENDGRID_API_KEY=''                 # SendGrid API key
SENDGRID_EMAIL=''                   # Verified sender email
NEXT_PUBLIC_SENDGRID_SENDER_NAME='' # Display name for SendGrid

# Resend (Alternative Provider)
RESEND_API_KEY=''                   # Resend API key

# Email Testing (Development Only)
E2E_TEST_MAILHOG_ENABLED=''         # Set to '1' for local testing
SEND_FEEDBACK_EMAIL=''              # Where to send user feedback
```

## Troubleshooting

### Error: "Invalid login credentials"
- Verify `EMAIL_SERVER_USER` and `EMAIL_SERVER_PASSWORD`
- For API-based auth (SendGrid), use "apikey" as username

### Error: "Connection refused"
- Check if the port is correct (587 vs 465)
- Verify firewall isn't blocking SMTP traffic
- Try alternative SMTP port

### Error: "550 Sender verify failed"
- Your sender domain needs to be verified
- Add SPF/DKIM records to your DNS

### Emails not received (no errors)
- Check spam folder
- Verify sender domain authentication
- Check provider's delivery logs
- Test with a different email address

## Production Checklist

Before going live:

- [ ] Sender domain is verified with SPF/DKIM/DMARC
- [ ] `EMAIL_FROM` uses your verified domain
- [ ] SMTP credentials are secured (not in version control)
- [ ] Tested email sending to multiple providers (Gmail, Outlook, etc.)
- [ ] Monitoring is set up for failed emails
- [ ] Sending limits are appropriate for your volume
- [ ] Backup SMTP provider configured (optional but recommended)

## Need Help?

- **Brevo Support**: https://help.brevo.com
- **SendGrid Docs**: https://docs.sendgrid.com
- **BookPH Issues**: https://github.com/Be1l-ai/bookph/issues
