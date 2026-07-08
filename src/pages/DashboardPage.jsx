import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../lib/supabaseClient'
import { useAuth } from '../context/AuthContext'
import StatCard from '../components/dashboard/StatCard'
import TopicAccuracyList from '../components/dashboard/TopicAccuracyList'
import RecentAttemptsList from '../components/dashboard/RecentAttemptsList'
import Button from '../components/ui/Button'
import Spinner from '../components/ui/Spinner'

export default function DashboardPage() {
  const { profile } = useAuth()
  const [progressRows, setProgressRows] = useState([])
  const [recentAttempts, setRecentAttempts] = useState([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    let mounted = true
    async function load() {
      setLoading(true)
      const [{ data: progress }, { data: topics }, { data: attempts }] = await Promise.all([
        supabase.from('user_topic_progress').select('*'),
        supabase.from('topics').select('id, name'),
        supabase.from('test_attempts').select('*').order('started_at', { ascending: false }).limit(6),
      ])
      if (!mounted) return

      const topicNameById = new Map((topics ?? []).map((t) => [t.id, t.name]))
      const rows = (progress ?? [])
        .map((r) => ({ ...r, topic_name: topicNameById.get(r.topic_id) ?? 'Unknown topic' }))
        .sort((a, b) => a.accuracy_pct - b.accuracy_pct)

      setProgressRows(rows)
      setRecentAttempts(attempts ?? [])
      setLoading(false)
    }
    load()
    return () => {
      mounted = false
    }
  }, [])

  if (loading) {
    return <div className="flex min-h-[60vh] items-center justify-center"><Spinner /></div>
  }

  const totalAttempted = progressRows.reduce((sum, r) => sum + r.questions_attempted, 0)
  const totalCorrect = progressRows.reduce((sum, r) => sum + r.correct_count, 0)
  const overallAccuracy = totalAttempted > 0 ? Math.round((totalCorrect / totalAttempted) * 1000) / 10 : 0
  const testsTaken = recentAttempts.filter((a) => a.mode === 'test' && a.status !== 'in_progress').length

  return (
    <div className="mx-auto max-w-5xl px-4 py-10 sm:px-6">
      <div className="flex flex-wrap items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-slate-900">Welcome back{profile?.full_name ? `, ${profile.full_name.split(' ')[0]}` : ''}</h1>
          <p className="mt-1 text-slate-500">Here's how your preparation is going.</p>
        </div>
        <div className="flex gap-3">
          <Link to="/categories"><Button variant="outline">Practice</Button></Link>
          <Link to="/test/setup"><Button>Take a mock test</Button></Link>
        </div>
      </div>

      <div className="mt-8 grid grid-cols-2 gap-4 sm:grid-cols-4">
        <StatCard label="Questions attempted" value={totalAttempted} icon="📝" />
        <StatCard label="Overall accuracy" value={`${overallAccuracy}%`} tone="accent" icon="🎯" />
        <StatCard label="Tests taken" value={testsTaken} tone="neutral" icon="⏱️" />
        <StatCard label="Topics practiced" value={progressRows.length} tone="neutral" icon="📚" />
      </div>

      <div className="mt-10 grid gap-8 lg:grid-cols-2">
        <div>
          <h2 className="mb-3 text-lg font-semibold text-slate-900">Topic-wise accuracy</h2>
          <TopicAccuracyList rows={progressRows.slice(0, 8)} />
        </div>
        <div>
          <div className="mb-3 flex items-center justify-between">
            <h2 className="text-lg font-semibold text-slate-900">Recent activity</h2>
            <Link to="/history" className="text-sm font-medium text-brand-700 hover:underline">View all</Link>
          </div>
          <RecentAttemptsList attempts={recentAttempts} />
        </div>
      </div>
    </div>
  )
}
