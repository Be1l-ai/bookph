#!/bin/bash
# BookPH Production Cleanup Script
# Safe removal of non-essential components
# Run from repo root: bash scripts/cleanup-for-production.sh

set -e  # Exit on error

echo "🚀 BookPH Production Cleanup"
echo "=============================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Confirm before proceeding
echo -e "${YELLOW}⚠️  This will remove significant portions of the codebase.${NC}"
echo -e "${YELLOW}Make sure you have a backup branch!${NC}"
echo ""
read -p "Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo "📋 Phase 1: Removing non-essential apps..."
echo "-------------------------------------------"

# Remove companion app
if [ -d "companion" ]; then
    echo "  🗑️  Removing companion/ (mobile app + browser extension)"
    rm -rf companion/
    echo "  ✅ Removed companion/"
else
    echo "  ℹ️  companion/ already removed"
fi

# Remove example apps
if [ -d "example-apps" ]; then
    echo "  🗑️  Removing example-apps/"
    rm -rf example-apps/
    echo "  ✅ Removed example-apps/"
else
    echo "  ℹ️  example-apps/ already removed"
fi

# Remove checks
if [ -d "__checks__" ]; then
    echo "  🗑️  Removing __checks__/ (monitoring)"
    rm -rf __checks__/
    echo "  ✅ Removed __checks__/"
else
    echo "  ℹ️  __checks__/ already removed"
fi

# Remove deploy scripts
if [ -d "deploy" ]; then
    echo "  🗑️  Removing deploy/ (Cal.com infrastructure)"
    rm -rf deploy/
    echo "  ✅ Removed deploy/"
else
    echo "  ℹ️  deploy/ already removed"
fi

# Remove API proxy
if [ -d "apps/api" ]; then
    echo "  🗑️  Removing apps/api/ (API proxy)"
    rm -rf apps/api/
    echo "  ✅ Removed apps/api/"
else
    echo "  ℹ️  apps/api/ already removed"
fi

echo ""
echo "📋 Phase 2: Skipping embeds/platform (core dependencies)"
echo "---------------------------------------------------------"
echo "  ℹ️  Keeping packages/embeds/ (used in booking flows)"
echo "  ℹ️  Keeping packages/platform/ (used in OAuth/billing)"

echo ""
echo "📋 Phase 3: Trimming app-store integrations..."
echo "-----------------------------------------------"
echo "  ℹ️  Keeping: googlecalendar, googlevideo, stripepayment"
echo "  🗑️  Removing 90+ unused integrations..."

cd packages/app-store

# Video conferencing (keep only Google Meet)
for app in dailyvideo demodesk huddle01video jitsivideo office365video riverside salesroom shimmervideo sirius_video sylapsvideo tandemvideo webex whereby zoomvideo; do
    [ -d "$app" ] && rm -rf "$app" && echo "    ✅ Removed $app"
done

# Calendar integrations (keep only Google)
for app in applecalendar caldavcalendar exchange2013calendar exchange2016calendar exchangecalendar feishucalendar ics-feedcalendar larkcalendar nextcloudtalk office365calendar zohocalendar; do
    [ -d "$app" ] && rm -rf "$app" && echo "    ✅ Removed $app"
done

# CRM/Sales tools
for app in attio closecom hubspot linear pipedrive-crm salesforce zoho-bigin zohocrm; do
    [ -d "$app" ] && rm -rf "$app" && echo "    ✅ Removed $app"
done

# Analytics/Tracking (all removed per REBRANDING.md)
for app in fathom ga4 gtm matomo metapixel plausible posthog twipla umami; do
    [ -d "$app" ] && rm -rf "$app" && echo "    ✅ Removed $app"
done

# AI/Automation tools
for app in bolna chatbase databuddy elevenlabs fonio-ai granola greetmate-ai lindy millis-ai retell-ai synthflow; do
    [ -d "$app" ] && rm -rf "$app" && echo "    ✅ Removed $app"
done

# Payment alternatives (keep only Stripe)
for app in btcpayserver hitpay paypal; do
    [ -d "$app" ] && rm -rf "$app" && echo "    ✅ Removed $app"
done

# Messaging/Communication
for app in campfire discord signal skype telegram whatsapp; do
    [ -d "$app" ] && rm -rf "$app" && echo "    ✅ Removed $app"
done

# Other integrations
for app in alby amie basecamp3 clic cron dub eightxeight element-call facetime framer giphy horizon-workrooms insihts intercom jelly make monobot n8n ping pipedream qr_code raycast roam sendgrid vimcal vital weather_in_your_calendar wipemycalother wordpress zapier; do
    [ -d "$app" ] && rm -rf "$app" && echo "    ✅ Removed $app"
done

# Routing forms - check if used
if [ -d "routing-forms" ]; then
    echo "  ⚠️  Keeping routing-forms (may be used)"
fi

cd ../..

echo ""
echo "📋 Phase 4: Minimizing documentation..."
echo "---------------------------------------"

cd docs

# Remove API reference
if [ -d "api-reference" ]; then
    echo "  🗑️  Removing docs/api-reference/"
    rm -rf api-reference/
    echo "  ✅ Removed api-reference/"
fi

# Remove platform SDK docs
if [ -d "platform" ]; then
    echo "  🗑️  Removing docs/platform/"
    rm -rf platform/
    echo "  ✅ Removed platform/"
fi

# Remove marketing content
for file in introduction.mdx mint.json; do
    [ -f "$file" ] && rm -f "$file" && echo "  ✅ Removed docs/$file"
done

for dir in snippets images logo; do
    [ -d "$dir" ] && rm -rf "$dir" && echo "  ✅ Removed docs/$dir/"
done

# Remove advanced self-hosting docs
if [ -d "self-hosting/apps" ]; then
    rm -rf self-hosting/apps && echo "  ✅ Removed self-hosting/apps/"
fi
if [ -d "self-hosting/deployments" ]; then
    rm -rf self-hosting/deployments && echo "  ✅ Removed self-hosting/deployments/"
fi
if [ -f "self-hosting/sso-setup.mdx" ]; then
    rm -f self-hosting/sso-setup.mdx && echo "  ✅ Removed self-hosting/sso-setup.mdx"
fi
if [ -f "self-hosting/license-key.mdx" ]; then
    rm -f self-hosting/license-key.mdx && echo "  ✅ Removed self-hosting/license-key.mdx"
fi

cd ..

echo ""
echo "✅ Cleanup complete!"
echo ""
echo "📋 Next steps:"
echo "  1. Review package.json and remove unused scripts (see REMOVAL_PLAN.md)"
echo "  2. Review turbo.json and remove deleted app pipelines"
echo "  3. Run: yarn clean"
echo "  4. Run: rm -rf node_modules yarn.lock && yarn install"
echo "  5. Run: yarn prisma generate"
echo "  6. Run: yarn type-check:ci --force"
echo "  7. Run: yarn build"
echo "  8. Test: yarn dev"
echo ""
echo "📄 See REMOVAL_PLAN.md for detailed next steps and validation checklist"
echo ""
echo -e "${GREEN}🎉 Production cleanup successful!${NC}"
