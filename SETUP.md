# Setup Guide — Placement Preparation Website

This is a step-by-step guide to get the project running locally and deployed to production. Follow the steps in order.

---

## 1. Prerequisites

- Node.js 18+ and npm installed
- A [Supabase](https://supabase.com) account (free tier is enough to start)
- A [Vercel](https://vercel.com) account
- Git installed, and access to the GitHub repo: `https://github.com/honestyrk/Apti_web.git`

---

## 2. Create the Supabase project

1. Go to [supabase.com/dashboard](https://supabase.com/dashboard) and click **New Project**.
2. Choose an organization, name the project (e.g. `apti-web`), set a strong database password (save it somewhere safe), and pick a region close to your users.
3. Wait ~2 minutes for the project to finish provisioning.

---

## 3. Get your API credentials

1. In the Supabase dashboard, go to **Project Settings → API**.
2. Copy the **Project URL** (looks like `https://xxxxx.supabase.co`).
3. Copy the **`anon` `public`** key (a long JWT string). Do **not** use the `service_role` key anywhere in this project — it must never be exposed to the browser.

---

## 4. Run the database migrations

The SQL that creates every table, security policy, view, and function lives in `supabase/migrations/`. Run them **in this exact order** using the Supabase SQL Editor:

1. In the Supabase dashboard, go to **SQL Editor → New query**.
2. Open [`supabase/migrations/0001_init_schema.sql`](supabase/migrations/0001_init_schema.sql) from this repo, copy its full contents, paste into the SQL editor, and click **Run**.
3. Repeat for [`supabase/migrations/0002_rls_policies.sql`](supabase/migrations/0002_rls_policies.sql).
4. Repeat for [`supabase/migrations/0003_views.sql`](supabase/migrations/0003_views.sql).
5. Repeat for [`supabase/migrations/0004_functions.sql`](supabase/migrations/0004_functions.sql).
6. Repeat for [`supabase/migrations/0005_fix_view_grants.sql`](supabase/migrations/0005_fix_view_grants.sql) (closes a gap where Supabase's default privileges made the question bank readable by unauthenticated requests).
7. Repeat for [`supabase/migrations/0006_fix_progress_view.sql`](supabase/migrations/0006_fix_progress_view.sql) (fixes a bug where the Dashboard's "Overall accuracy" and "Questions attempted" stats were stuck at 0 for every user, because the underlying view had no permission to read the column it needed).

Each file must succeed before running the next one, since later files depend on tables/functions created earlier.

> **Alternative (Supabase CLI):** if you have the [Supabase CLI](https://supabase.com/docs/guides/cli) installed, you can instead run `supabase link --project-ref <your-project-ref>` followed by `supabase db push` from the project root, which applies all files in `supabase/migrations/` in order automatically.

---

## 5. Load the sample question bank (seed data)

1. In the SQL Editor, open a **New query**.
2. Copy the full contents of [`supabase/seed.sql`](supabase/seed.sql) and run it.
3. Then run [`supabase/seed_02_expanded_topics.sql`](supabase/seed_02_expanded_topics.sql) — adds a Data Interpretation category and a much broader Quantitative Aptitude / Logical Reasoning topic list (Problems on Trains, Pipes & Cisterns, Boats & Streams, Probability, Analogy, Classification, and more).
4. Then run [`supabase/seed_03_remaining_topics.sql`](supabase/seed_03_remaining_topics.sql) — fills in sample MCQs for every topic added in step 3 that didn't already get sample questions, so every topic in the app has practiceable content.
5. Then run, in order, every remaining file from `seed_04_quant_batch1.sql` through `seed_20_cs_batch1.sql` (17 files, numbered in the order they should run). Together these complete **every topic on the platform** — Quantitative Aptitude (32 topics), Logical Reasoning (12 topics), Verbal Ability (5 topics), Data Interpretation (4 topics), and Technical > CS/IT (5 topics) — each with 25+ hand-verified questions. (Technical > ECE, Mechanical, Civil, and EEE branches still have empty topics, reserved for a future pass or for you to fill via the Admin Panel.)

All seed files are additive and safe to run once each, in the order listed (by filename number), on a fresh database; don't re-run any of them, since re-running would try to insert duplicate topics or questions.

Together these create the full category/branch/topic tree (Quantitative Aptitude, Logical Reasoning, Verbal Ability, Data Interpretation, and Technical with 5 engineering branches) plus 1900+ sample MCQs, so you can test Practice and Test mode immediately. You can add more questions later through the Admin Panel.

---

## 6. Configure Auth settings (with Resend for email delivery)

1. In the Supabase dashboard, go to **Authentication → Providers → Email**, and confirm Email provider is enabled (it is by default).
2. Leave **"Confirm email"** turned **on** (the default). The app requires users to click the confirmation link in their inbox before they can log in — after signup they'll see a "check your inbox" screen, and the login page shows a "resend confirmation email" option if they try to log in too early.
3. **Set the Site URL and Redirect URLs** (this controls where the confirmation link in the email actually points — a common source of "link doesn't work" bugs):
   - Go to **Authentication → URL Configuration**.
   - Set **Site URL** to your production URL (e.g. `https://your-app.vercel.app`).
   - Under **Redirect URLs**, add both:
     - `http://localhost:5173/**` (local dev — Vite's default port)
     - `https://your-app.vercel.app/**` (production)
4. **Create a Resend account** at [resend.com](https://resend.com) (free tier is enough to start).
5. **Add and verify a sending domain:**
   - In the Resend dashboard, go to **Domains → Add Domain**, enter a domain you control, and add the DNS records (DKIM/SPF) it gives you at your domain registrar.
   - Verification can take a few minutes to a few hours depending on DNS propagation.
   - *Skipping this for quick local testing:* Resend also lets you send from `onboarding@resend.dev` without verifying a domain, but delivery is more limited — verify your own domain before inviting real users.
6. **Get a Resend API key:** in the Resend dashboard, go to **API Keys → Create API Key**, and copy it (you won't be able to see it again — store it safely).
7. **Connect Resend to Supabase as a custom SMTP provider** (this is the actual integration point — Supabase Auth sends emails through whatever SMTP server you configure, and Resend exposes a standard SMTP relay):
   - In the Supabase dashboard, go to **Project Settings → Auth → SMTP Settings** (or **Authentication → Emails → SMTP Settings**, depending on dashboard version).
   - Toggle **Enable Custom SMTP** on.
   - Fill in:
     - **Sender email:** an address on your verified domain (e.g. `noreply@yourdomain.com`), or `onboarding@resend.dev` if you skipped domain verification.
     - **Sender name:** e.g. `PlacementPrep`
     - **Host:** `smtp.resend.com`
     - **Port:** `465` (SSL) — or `587` (TLS)
     - **Username:** `resend` (this literal string, not your email)
     - **Password:** your Resend API key from step 6
   - Save.
8. **(Optional) Customize the email template:** go to **Authentication → Email Templates → Confirm signup** to edit the subject line and body copy sent to new users.
9. **Test it:** sign up with a real email address through the running app and confirm the email arrives via Resend (check the Resend dashboard's **Logs** tab to see delivery status if it doesn't show up).
10. This app only uses email/password authentication — no other providers need to be configured.

---

## 7. Set up local environment variables

1. In the project root, copy the example env file:
   ```
   cp .env.example .env.local
   ```
   (On Windows PowerShell: `Copy-Item .env.example .env.local`)
2. Open `.env.local` and fill in the two values from Step 3:
   ```
   VITE_SUPABASE_URL=https://xxxxx.supabase.co
   VITE_SUPABASE_ANON_KEY=your-anon-public-key
   ```
   `.env.local` is already gitignored — it will never be committed.

---

## 8. Install dependencies and run locally

```
npm install
npm run dev
```

Open the printed local URL (usually `http://localhost:5173`) in your browser.

---

## 9. Create your first admin user

Regular signups always get the `user` role — nobody can promote themselves to `admin` through the app (this is enforced by a database trigger). To make yourself an admin:

1. Sign up for an account through the running app (Step 8), then click the confirmation link in your email.
2. In the Supabase dashboard, go to **SQL Editor** and run (replacing the email):
   ```sql
   update public.profiles set role = 'admin' where email = 'you@example.com';
   ```
3. Log out and back in. You should now see the Admin Panel link in the app.

---

## 10. Connect the GitHub repo

If you're setting this up fresh from this codebase:

```
git init
git remote add origin https://github.com/honestyrk/Apti_web.git
git add .
git commit -m "Initial commit"
git branch -M main
git push -u origin main
```

(If you're continuing from an existing local repo already connected to this remote, just commit and push as usual.)

---

## 11. Deploy to Vercel

1. Go to [vercel.com/new](https://vercel.com/new) and import the `honestyrk/Apti_web` GitHub repository.
2. Vercel should auto-detect the **Vite** framework preset. Confirm:
   - **Build command:** `npm run build`
   - **Output directory:** `dist`
3. Under **Environment Variables**, add the same two variables from Step 7 (apply to Production, Preview, and Development):
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
4. Click **Deploy**. Every future push to `main` will auto-deploy; pull requests get their own preview URLs automatically.

---

## 12. Verify everything works end-to-end

- [ ] Sign up for a new account and see the "check your inbox" confirmation screen.
- [ ] Click the confirmation link in the email, then log in successfully.
- [ ] Browse Categories → a topic (try Technical → CS/IT → DBMS).
- [ ] Complete a Practice session and confirm you get instant feedback with explanations.
- [ ] Start a Test mode mock test, let the timer run, and confirm it auto-submits and shows a scored review.
- [ ] Check the Dashboard reflects your accuracy stats.
- [ ] Log in as your admin account and add a new question — confirm it's immediately practiceable by a regular user.

If any step fails, double check that all six migration files ran successfully and in order, that the Resend SMTP settings in Supabase are saved correctly (check the Resend **Logs** tab for delivery errors), and that both environment variables are set correctly in both `.env.local` and Vercel.
