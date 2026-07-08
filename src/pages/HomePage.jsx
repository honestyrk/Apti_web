import { Link } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import Button from '../components/ui/Button'
import Card from '../components/ui/Card'

const features = [
  {
    icon: '🎯',
    title: 'Practice Mode',
    description: 'Untimed, topic-wise practice with instant feedback and explanations for every question.',
  },
  {
    icon: '⏱️',
    title: 'Timed Mock Tests',
    description: 'Simulate real placement exams with a countdown timer, auto-submit, and detailed scoring.',
  },
  {
    icon: '📊',
    title: 'Progress Tracking',
    description: 'See your accuracy by topic, spot weak areas, and track your improvement over time.',
  },
  {
    icon: '📚',
    title: 'Curated Question Bank',
    description: 'Quantitative Aptitude, Logical Reasoning, Verbal Ability, and branch-wise Technical questions.',
  },
]

const stats = [
  { value: '4', label: 'Core categories' },
  { value: '30+', label: 'Topics covered' },
  { value: '5', label: 'Engineering branches' },
  { value: '100%', label: 'Free to practice' },
]

export default function HomePage() {
  const { user } = useAuth()

  return (
    <div>
      <section className="relative overflow-hidden bg-linear-to-b from-brand-950 via-brand-900 to-brand-800 py-24 text-white">
        <div
          className="pointer-events-none absolute inset-0 opacity-20"
          style={{
            backgroundImage:
              'radial-gradient(circle at 20% 20%, rgba(20,181,135,0.4), transparent 40%), radial-gradient(circle at 80% 0%, rgba(92,133,189,0.5), transparent 40%)',
          }}
        />
        <div className="relative mx-auto max-w-4xl px-4 text-center sm:px-6">
          <span className="inline-flex items-center gap-1.5 rounded-full bg-white/10 px-3.5 py-1 text-xs font-medium text-accent-200 ring-1 ring-white/20">
            Built for campus placements
          </span>
          <h1 className="mt-5 font-heading text-4xl font-bold tracking-tight text-balance sm:text-6xl">
            Ace Your Campus Placements
          </h1>
          <p className="mx-auto mt-5 max-w-2xl text-lg leading-relaxed text-brand-100">
            Practice thousands of aptitude, reasoning, verbal, and technical MCQs. Take timed
            mock tests and track your progress topic by topic.
          </p>
          <div className="mt-9 flex flex-col justify-center gap-3 sm:flex-row">
            {user ? (
              <Link to="/dashboard">
                <Button variant="accent" size="lg">Go to Dashboard</Button>
              </Link>
            ) : (
              <>
                <Link to="/signup">
                  <Button variant="accent" size="lg">Get Started Free</Button>
                </Link>
                <Link to="/login">
                  <Button
                    variant="outline"
                    size="lg"
                    className="border-white/30 bg-white/5 text-white hover:border-white/50 hover:bg-white/10"
                  >
                    Log in
                  </Button>
                </Link>
              </>
            )}
          </div>

          <div className="mx-auto mt-16 grid max-w-2xl grid-cols-2 gap-6 border-t border-white/10 pt-8 sm:grid-cols-4">
            {stats.map((s) => (
              <div key={s.label}>
                <p className="font-heading text-2xl font-bold text-white">{s.value}</p>
                <p className="mt-1 text-xs text-brand-200">{s.label}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      <section className="mx-auto max-w-6xl px-4 py-20 sm:px-6">
        <div className="mx-auto max-w-2xl text-center">
          <h2 className="font-heading text-3xl font-bold tracking-tight text-slate-900 dark:text-white">Everything you need to prepare</h2>
          <p className="mt-3 text-slate-500 dark:text-slate-400">A focused toolkit for aptitude, reasoning, verbal, and technical rounds.</p>
        </div>

        <div className="mt-12 grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
          {features.map((f) => (
            <Card key={f.title} hover className="p-6">
              <div className="flex h-11 w-11 items-center justify-center rounded-xl bg-brand-50 text-xl dark:bg-brand-900/40">
                {f.icon}
              </div>
              <h3 className="mt-4 font-heading font-semibold text-slate-900 dark:text-white">{f.title}</h3>
              <p className="mt-2 text-sm leading-relaxed text-slate-500 dark:text-slate-400">{f.description}</p>
            </Card>
          ))}
        </div>
      </section>

      {!user && (
        <section className="mx-auto max-w-6xl px-4 pb-20 sm:px-6">
          <Card className="flex flex-col items-center gap-5 bg-linear-to-br from-brand-800 to-brand-900 p-10 text-center text-white sm:flex-row sm:justify-between sm:text-left">
            <div>
              <h3 className="font-heading text-xl font-bold">Ready to start practicing?</h3>
              <p className="mt-1 text-sm text-brand-100">Create a free account and take your first mock test today.</p>
            </div>
            <Link to="/signup" className="shrink-0">
              <Button variant="accent" size="lg">Create free account</Button>
            </Link>
          </Card>
        </section>
      )}
    </div>
  )
}
