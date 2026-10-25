# Ceviche de Cenicienta — Supabase + Cloudflare Pages

This version adds phone/password login and cloud synchronization. It uses a single private JSON row per authenticated user for simplicity. For one user entering sales on one device at a time, this is a simple starting point; simultaneous edits from two devices could overwrite each other.

## Security warning
- Do NOT use `2222` as your password. It is extremely easy to guess and Supabase's default password policy normally requires at least 6 characters. Use a unique password with at least 8–12 characters. The app does not prefill your phone number, so your personal number is not published in the GitHub source.
- The phone number is the login identifier; in the UI, enter your Peruvian mobile number. The app prefixes `+51` if you do not include a country code.
- The Supabase publishable/anon key is intended for browser use. NEVER put the `service_role` key or any secret key in this site.
- The SQL file enables Row Level Security (RLS) and allows each authenticated user to access only their own row.
- For a one-person private app, turn off new signups after creating your account.

## Setup steps

### 1. Create the Supabase project
1. Open https://supabase.com/dashboard and create a project.
2. Save the database password securely; it is not the app login password.
3. Wait for the project to finish provisioning.

### 2. Create the private table
1. In your project, open **SQL Editor**.
2. Choose **New query**.
3. Paste all of `setup.sql` and click **Run**.
4. Confirm the `app_state` table appears in Table Editor.

### 3. Enable phone/password authentication
1. Open **Authentication → Sign In / Providers** (the label may vary).
2. Enable the **Phone** provider.
3. For easiest initial setup, you can temporarily turn off phone confirmation if available. Otherwise, configure an SMS provider and verify the phone. SMS provider messages may cost money.
4. Use a strong password. Do not use `2222`.
5. The page has a **CREAR MI CUENTA** button for the first account. Create the account with your own phone and password.
6. After account creation succeeds, go to **Authentication → Users** and verify the user exists.
7. Disable new signups / new user registration in Auth settings after your account is created, so strangers cannot create accounts through the app. If your project requires phone verification, complete that flow first.

If the phone confirmation setting cannot be disabled, configure an SMS provider or create/verify the account through Supabase's supported Auth flow. Do not try to bypass phone verification with SQL.

### 4. Add the Supabase client settings to the app
1. In Supabase, open **Project Settings → API** (or **Connect**).
2. Copy the **Project URL**.
3. Copy the **publishable key** (or legacy `anon` public key). Do NOT copy `service_role` or a secret key.
4. In `index.html`, find:
   `const SUPABASE_URL = "PASTE_YOUR_SUPABASE_PROJECT_URL_HERE";`
   `const SUPABASE_ANON_KEY = "PASTE_YOUR_SUPABASE_PUBLISHABLE_OR_ANON_KEY_HERE";`
5. Replace the two placeholder strings with your actual Project URL and publishable/anon key.

### 5. Publish through the GitHub repository already connected to Cloudflare
1. In your GitHub repository, replace the existing `index.html` with this `index.html`.
2. Add `setup.sql` and this `README.md` to the repository too (the SQL is for Supabase; Cloudflare does not run it).
3. Commit the changes. Cloudflare Pages should deploy automatically.
4. Open your site, create your account once, then sign in. Add a test sale, reload the page, and confirm it remains. Then sign out and verify you cannot see the records until signing in again.

### 6. Backups and migration
- Existing records in the browser are imported to Supabase on the first login only if the cloud row for that user does not already exist and the same browser still has its old `localStorage` data.
- Before replacing the site, use **DESCARGAR COPIA** from the old site and keep the CSV.
- The app still offers **DESCARGAR COPIA**. Download backups regularly and keep them outside the device.
- Supabase free tier has limits. A free project may pause after inactivity and does not guarantee automatic daily backups; keep your own CSV backups.
- Cloud sync requires an internet connection to save. Do not enter sales while offline expecting them to sync until a later version explicitly supports an offline queue.

## Documentation
- Password authentication: https://supabase.com/docs/guides/auth/passwords
- Row Level Security: https://supabase.com/docs/guides/database/postgres/row-level-security
- Cloudflare Pages settings: https://developers.cloudflare.com/pages/configuration/build-configuration/
