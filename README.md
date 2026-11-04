# هامش — multi-workspace profitability pilot

Arabic RTL SaaS pilot for merchants. The previous Qeyam static demo has been replaced with a Vinext/React application, D1 persistence and Sites-managed sign-in. The Site remains private to its owner; this is not an approved or publicly distributed Salla application.

## Implemented
- Marketing page, interactive seeded demo, authenticated workspace creation/switching.
- Per-owner server authorization for every list/read/write; no owner identifiers accepted from client requests.
- D1 workspace documents, optimistic revisions preventing stale writes, atomic 20-workspace cap.
- Validated order inputs, cancellation/full and quantity-based partial return calculations, actual-cost overrides.
- Dated ad expenses, date-filtered dashboard, product contribution report, optional fixed costs.
- CSV template, quoted CSV parser, validation and explicit preview before import; duplicate order rejection and spreadsheet-formula escaping on export.
- Proposed pricing preferences only. No billing, free-trial expiration or paid entitlements represented as active.

## Limits and next release
- No Salla OAuth, token storage, webhooks, historical sync or automatic ad integration has been enabled/implemented. The integrations screen states this plainly.
- Production distribution requires the owner's verified Salla Partners application and approved installation/authorization setup. Keep application secrets server-side. Easy Mode authorization is documented at https://docs.salla.dev/421118m0 ; webhooks at https://docs.salla.dev/421119m0 . Confirm published-app authorization requirements before implementing; do not assume development Custom Mode is accepted for distribution.
- Private Sites cannot receive anonymous Salla webhook requests through the private access boundary. Choose a supported authenticated ingestion service or intentionally publish the required backend with signature verification before connecting external callbacks. Do not expose tenant read/write endpoints without authorization.
- A workspace is currently owner-only, not a collaborative team. No platform-wide admin console is implemented.
- Orders support a single SKU/quantity per order. Mixed baskets can be represented as an aggregate order (quantity 1) with a corresponding loss of product-level detail. True line-item modeling is required before production Salla sync.
- Values use a consistent ex-tax input basis. No VAT return/accounting reconciliation. Full returns assume saleable stock and refund collected shipping; partial returns retain shipping income and allocate discount proportionally. Payment fees are retained unless manually overridden.
- Order profitability excludes ad spend. Period net profit subtracts date-matched ad spend even when there are no orders. Optional fixed costs are a single explicit amount for the selected period, not prorated monthly.
- Pilot bounds: 2,000 orders, 1,000 ad records per workspace. Use normalized tables and pagination before larger commercial rollout.
- Final privacy policy, terms, retention/deletion workflows, billing integration and Salla review remain release gates. No customer personal data is requested by the CSV schema.

## Development
Use the Sites skill's build/install/preview helpers. D1 migrations are in `drizzle/`.

Checks:
```
node node_modules/typescript/bin/tsc --noEmit
node --experimental-strip-types --test tests/model.test.mjs tests/api.test.mjs
```
The API unit suite executes the actual transpiled route handlers against SQLite with a D1-compatible adapter and mocked authenticated identities. It checks anonymous access, cross-owner reads/writes, CSRF, stale revisions, validation and the workspace cap. It is not an external Salla end-to-end test.

`tests/api.integration.mjs` is an optional HTTP smoke test for a reachable local development server with synthetic local identity headers; never use it against production. Local preview uses separate D1 state; test data is not seeded into production migrations.
