# PlacementPrep — Project Overview

A campus placement preparation platform (similar in purpose to IndiaBix) for practicing
Quantitative Aptitude, Logical Reasoning, Verbal Ability, Data Interpretation, and
branch-wise Technical MCQs, with untimed practice, timed mock tests, progress tracking,
and an admin panel for managing the question bank.

Repository: https://github.com/honestyrk/Apti_web
Live deployment: Vercel (see SETUP.md for setup steps)

---

## 1. Tech Stack

### Frontend
- **React 19** — UI library
- **Vite 8** — build tool / dev server
- **React Router 7** (`react-router-dom`) — client-side routing
- **Tailwind CSS 4** — utility-first styling (CSS-first config via `@theme`, no `tailwind.config.js`)
- **PostCSS** + **Autoprefixer** — CSS processing
- **@fontsource/inter** — body font (self-hosted, no external CDN)
- **@fontsource/poppins** — heading font (self-hosted, no external CDN)
- **oxlint** — linter

### Backend / Data
- **Supabase** — backend-as-a-service, providing:
  - **Postgres** database
  - **Supabase Auth** (email/password only — no OAuth providers)
  - **Row Level Security (RLS)** policies on every table
  - **PostgREST** auto-generated REST API (accessed via `@supabase/supabase-js`)
  - **SQL functions (RPCs)** with `SECURITY DEFINER` for all answer-revealing or
    integrity-sensitive operations (practice/test flow, admin question CRUD)

### Deployment / Infra
- **Vercel** — frontend hosting, auto-deploy on push to `main`, preview deployments on PRs
- **Supabase Cloud** — hosts the Postgres database and Auth service
- **GitHub** — version control and CI trigger for Vercel

### State Management
- **React Context** only — `AuthContext` (user/profile/session) and `ThemeContext`
  (dark/light mode, persisted to `localStorage`, respects OS preference on first visit)
- No Redux/Zustand/TanStack Query — data fetching is done directly via custom hooks
  calling the Supabase client

### Tooling used to build this project
- Claude Code (Sonnet 5) — AI pair-programming agent that scaffolded, built, and
  iterated on the entire codebase in conversation with the project owner
- Git / GitHub CLI — version control and repo management
- npm — package management

---

## 2. Project Structure

```
Apti_web/
├── SETUP.md              Step-by-step manual setup guide (Supabase, env vars, deploy)
├── overview.md            This file
├── src/
│   ├── main.jsx            App entry point, wraps providers (Theme, Auth, Router)
│   ├── App.jsx              Route table
│   ├── index.css            Tailwind theme, fonts, dark-mode variant setup
│   ├── lib/supabaseClient.js   Single Supabase client instance
│   ├── context/
│   │   ├── AuthContext.jsx    Auth/profile state, sign up/in/out
│   │   └── ThemeContext.jsx   Dark/light mode toggle + persistence
│   ├── hooks/                Data-fetching hooks (categories, topics, practice
│   │                          session, test timer, etc.)
│   ├── components/
│   │   ├── layout/            Navbar, Footer, Layout, ProtectedRoute, AdminRoute
│   │   ├── ui/                 Button, Card, Badge, Modal, Spinner, ProgressBar,
│   │   │                       Timer, ThemeToggle, DifficultyBadge
│   │   ├── questions/          QuestionCard, OptionsList, OptionButton,
│   │   │                       ExplanationPanel
│   │   └── dashboard/          StatCard, TopicAccuracyList, RecentAttemptsList
│   └── pages/
│       ├── Home, Login, Signup, Dashboard, Categories, CategoryDetail,
│       │   BranchTopics, Practice, TestSetup, Test, Results, History, Profile,
│       │   NotFound
│       └── admin/               AdminDashboard, AdminQuestions,
│                                 AdminQuestionForm, AdminTopics
└── supabase/
    ├── migrations/            Numbered schema migrations (0001–0006)
    └── seed*.sql               Category/topic tree + question bank (seed.sql,
                                 seed_02 … seed_20)
```

---

## 3. Database Schema (Supabase / Postgres)

### Tables
- **profiles** — 1:1 extension of `auth.users` (full_name, email, role: user/admin)
- **categories** — top-level subjects (has_branches flag for Technical)
- **branches** — engineering branches, only populated under Technical
- **topics** — practice topics, optionally scoped to a branch
- **questions** — MCQs (question_text, 4 options, correct_option, explanation,
  difficulty, is_active). Base table has **no direct SELECT grant** — accessed only
  via `questions_public` view or RPCs, to prevent answer leakage.
- **test_attempts** — covers both Practice and Test mode sessions
- **test_attempt_questions** — locks in the randomized question set for a timed test
- **user_answers** — per-question responses within an attempt

### Views
- **questions_public** — `questions` minus `correct_option`/`explanation`, granted
  to `authenticated` only
- **user_topic_progress** — per-user, per-topic accuracy aggregation
  (`security_invoker = true` so it respects the querying user's own RLS)

### Key RPC functions (SECURITY DEFINER)
- `start_practice_session`, `submit_practice_answer` — practice mode, instant feedback
- `start_test_attempt`, `get_test_questions`, `submit_test_answer`,
  `finalize_attempt`, `get_attempt_review` — timed test mode, server-side timing
  and randomized question selection, no mid-test answer leakage
- `admin_list_questions`, `admin_get_question`, `admin_create_question`,
  `admin_update_question`, `admin_delete_question` — admin-only question CRUD
- `is_admin()` — recursion-safe admin role check used throughout RLS policies

### Security design highlights
- Row Level Security enabled on every table
- Admin role stored on `profiles.role`, self-promotion blocked by a `BEFORE UPDATE` trigger
- Answer-revealing columns (`correct_option`, `explanation`) never queryable directly —
  only returned via RPC responses at the correct moment (after answering in practice,
  after test submission in review)
- Timed tests validated server-side (`expires_at` computed and enforced in Postgres,
  not trusted from the client)

---

## 4. Categories & Topics (Question Bank)

**5 top-level categories, 70 topics total, ~1,450+ hand-verified MCQs**

### Quantitative Aptitude (32 topics — complete, 25+ questions each)
Percentages, Time and Work, Time/Speed/Distance, Profit and Loss, Simple & Compound
Interest, Number System, Ratio and Proportion, Problems on Trains, Height and Distance,
Problems on Ages, Calendar, Clock, Average, Area, Volume and Surface Area,
Permutation and Combination, Problems on H.C.F and L.C.M, Decimal Fraction,
Simplification, Square Root and Cube Root, Surds and Indices, Chain Rule,
Pipes and Cistern, Boats and Streams, Alligation or Mixture, Logarithm,
Races and Games, Stocks and Shares, Probability, True Discount, Banker's Discount,
Odd Man Out and Series

### Logical Reasoning (12 topics — complete, 25+ questions each)
Blood Relations, Coding-Decoding, Syllogisms, Seating Arrangement, Direction Sense,
Series Completion, Analogy, Classification, Statement and Argument,
Statement and Conclusion, Cause and Effect, Puzzle Test

### Verbal Ability (5 topics — complete, 25+ questions each)
Synonyms and Antonyms, Sentence Correction, Para Jumbles, Reading Comprehension,
Fill in the Blanks

### Data Interpretation (4 topics — complete, 25+ questions each)
Tables, Bar Charts, Pie Charts, Line Charts

### Technical (5 engineering branches)
- **CS/IT** (5 topics — complete, 25+ questions each): OOP Concepts, DBMS,
  Operating Systems, Computer Networks, Data Structures
- **ECE**, **Mechanical**, **Civil**, **EEE** (3 topics each, 15 topics total) —
  topic tree created, questions not yet seeded (reserved for a future content pass
  or manual entry via the Admin Panel)

Note: image-based Nonverbal Reasoning was intentionally excluded — the schema's
questions are text-only (question + 4 text options) and can't meaningfully express
figure-based items (mirror images, paper folding, etc.).

---

## 5. Core Features

- **Auth** — Supabase Auth email/password signup & login, with mandatory email
  confirmation (persistent "check your inbox" screen + resend option)
- **Practice Mode** — untimed, topic-wise, instant per-question feedback with
  explanations
- **Test Mode** — timed mock tests (topic/branch/category/full-length scope),
  auto-submit on timeout enforced server-side, scored results, full answer review
- **Progress Dashboard** — questions attempted, overall accuracy, topic-wise
  accuracy breakdown, recent activity
- **History** — full list of past practice sessions and tests, filterable
- **Admin Panel** — add/edit/deactivate questions, manage topics/branches,
  restricted to `role = 'admin'`
- **Dark / Light Mode** — toggle in the navbar, persisted, respects system
  preference on first visit, applied across every page and component
- **Responsive design** — mobile and desktop, Poppins headings + Inter body text,
  navy/slate + accent color theme

---

## 6. Deployment Summary

| Concern | Where |
|---|---|
| Frontend hosting | Vercel (auto-deploy from `main`) |
| Database + Auth | Supabase Cloud |
| Environment variables | `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY` (set in `.env.local` for dev, Vercel project settings for prod) |
| Full setup instructions | See `SETUP.md` in the repo root |

