import { Link } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import Button from '../components/ui/Button'
import Card from '../components/ui/Card'

const features = [
  {
    title: 'Practice Mode',
    description: 'Untimed, topic-wise practice with instant feedback and explanations for every question.',
  },
  {
    title: 'Timed Mock Tests',
    description: 'Simulate real placement exams with a countdown timer, auto-submit, and detailed scoring.',
  },
  {
    title: 'Progress Tracking',
    description: 'See your accuracy by topic, spot weak areas, and track your improvement over time.',
  },
  {
    title: 'Curated Question Bank',
    description: 'Quantitative Aptitude, Logical Reasoning, Verbal Ability, and branch-wise Technical questions.',
  },
]

export default function HomePage() {
  const { user } = useAuth()

  return (
    <div>
      <section className="bg-gradient-to-b from-brand-900 to-brand-800 py-20 text-white">
        <div className="mx-auto max-w-4xl px-4 text-center sm:px-6">
          <h1 className="text-4xl font-bold tracking-tight sm:text-5xl">
            Ace Your Campus Placements
          </h1>
          <p className="mx-auto mt-4 max-w-2xl text-lg text-brand-100">
            Practice thousands of aptitude, reasoning, verbal, and technical MCQs. Take timed
            mock tests and track your progress topic by topic.
          </p>
          <div className="mt-8 flex justify-center gap-4">
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
                  <Button variant="outline" size="lg" className="border-white/40 bg-transparent text-white hover:bg-white/10">
                    Log in
                  </Button>
                </Link>
              </>
            )}
          </div>
        </div>
      </section>

      <section className="mx-auto max-w-6xl px-4 py-16 sm:px-6">
        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
          {features.map((f) => (
            <Card key={f.title} className="p-6">
              <h3 className="font-semibold text-slate-900">{f.title}</h3>
              <p className="mt-2 text-sm text-slate-500">{f.description}</p>
            </Card>
          ))}
        </div>
      </section>
    </div>
  )
}
