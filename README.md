# PlacementPrep

A campus placement preparation platform for practicing Quantitative Aptitude, Logical Reasoning, Verbal Ability, and branch-wise Technical MCQs — with untimed practice, timed mock tests, progress tracking, and an admin panel for managing the question bank.

## Tech stack

- **Frontend:** React (Vite), Tailwind CSS, React Router
- **Backend:** Supabase (Postgres, Auth, Row Level Security)
- **Deployment:** Vercel

## Getting started

See [SETUP.md](SETUP.md) for the full step-by-step setup guide, covering Supabase project creation, running database migrations, environment variables, and deployment.

Quick local start once your `.env.local` is configured:

```
npm install
npm run dev
```

## Project structure

- `src/pages/` — route-level pages (auth, browsing, practice, test, dashboard, admin)
- `src/components/` — layout, UI primitives, and question-rendering components
- `src/hooks/` — data-fetching and session-state hooks
- `src/context/AuthContext.jsx` — auth/profile state
- `supabase/migrations/` — SQL schema, RLS policies, views, and RPC functions
- `supabase/seed.sql` — category/topic tree and sample question bank
