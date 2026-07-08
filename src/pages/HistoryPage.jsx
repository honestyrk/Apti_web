import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabaseClient'
import RecentAttemptsList from '../components/dashboard/RecentAttemptsList'
import Spinner from '../components/ui/Spinner'
import Button from '../components/ui/Button'

const FILTERS = [
  { key: 'all', label: 'All' },
  { key: 'practice', label: 'Practice' },
  { key: 'test', label: 'Tests' },
]

export default function HistoryPage() {
  const [attempts, setAttempts] = useState([])
  const [loading, setLoading] = useState(true)
  const [filter, setFilter] = useState('all')

  useEffect(() => {
    let mounted = true
    supabase
      .from('test_attempts')
      .select('*')
      .order('started_at', { ascending: false })
      .limit(50)
      .then(({ data }) => {
        if (!mounted) return
        setAttempts(data ?? [])
        setLoading(false)
      })
    return () => {
      mounted = false
    }
  }, [])

  const filtered = filter === 'all' ? attempts : attempts.filter((a) => a.mode === filter)

  return (
    <div className="mx-auto max-w-3xl px-4 py-10 sm:px-6">
      <h1 className="text-2xl font-bold text-slate-900">History</h1>
      <p className="mt-1 text-slate-500">All your past practice sessions and tests.</p>

      <div className="mt-6 flex gap-2">
        {FILTERS.map((f) => (
          <Button
            key={f.key}
            variant={filter === f.key ? 'primary' : 'outline'}
            size="sm"
            onClick={() => setFilter(f.key)}
          >
            {f.label}
          </Button>
        ))}
      </div>

      <div className="mt-6">
        {loading ? (
          <div className="flex justify-center py-10"><Spinner /></div>
        ) : (
          <RecentAttemptsList attempts={filtered} />
        )}
      </div>
    </div>
  )
}
