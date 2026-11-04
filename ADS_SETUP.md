# Advertising synchronization — activation and boundaries

Implemented: owner-scoped OAuth authorization, one-use expiring state, encrypted credentials (AES-256-GCM), Meta/Google/TikTok direct account discovery, SAR-only account selection, date-range sync (max 90 days), revision-safe save, no duplicate day imports, manual/import overlap rejection, status and disconnect. Disconnect removes stored credentials; historical expenses remain. Google refresh tokens are used server-side. Meta requires reconnect on expiry. No automatic schedule or campaign filtering is implemented. Each selected account must exclusively represent its workspace. Do not activate for shared campaign accounts until campaign filtering is added.

Required server secrets (never browser input):
- ADS_ENCRYPTION_KEY: base64 encoded 32 random bytes. Persist safely; rotating without re-encrypting existing records breaks connections.
- GOOGLE_CLIENT_ID / GOOGLE_CLIENT_SECRET / GOOGLE_ADS_DEVELOPER_TOKEN / GOOGLE_ADS_API_VERSION (approved current version, e.g. vNN)
- TIKTOK_CLIENT_ID / TIKTOK_CLIENT_SECRET: approved Marketing API app, v1.3 adapter; authorization and reports require live verification.
- META_CLIENT_ID / META_CLIENT_SECRET / META_API_VERSION (approved current Graph version, e.g. vNN.0)
- Register callback exactly: https://qeyam-profit-lab.storeqeyam.chatgpt.site/api/advertising/callback

Configure through Sites runtime secrets. None are currently configured by this change; buttons accurately show pending setup. Real advertiser authorization and live end-to-end verification remain required. Google OAuth uses the Ads scope, not a read-only Google-specific scope; our implementation performs reporting requests only. Meta requests ads_read. Follow provider app review/verification requirements before merchant distribution.

Google currently supports directly accessible non-manager customer accounts only. Reporting data retains the advertiser account's reporting date/timezone, and only SAR currency is accepted. Taxes/invoice adjustments are not imported. No FX rates or VAT assumptions are invented.

X card explicitly show integration in development, with no mock connected state or false activation button. Its OAuth/reporting adapter remains to be built and tested using approved developer applications.

Privacy boundary: Site audience remains private. No service-account scheduled trigger has been added. Merchants need authorized Site access before using their workspaces. Do not broaden access merely to test OAuth.

No OAuth codes or access/refresh tokens are returned in browser API responses. Provider request errors are intentionally redacted. Ad account ids/currency/last-sync metadata are returned only after workspace ownership checks.
