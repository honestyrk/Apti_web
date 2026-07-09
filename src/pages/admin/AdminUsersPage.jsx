import { useEffect, useMemo, useState } from 'react'
import { supabase } from '../../lib/supabaseClient'
import Card from '../../components/ui/Card'
import Badge from '../../components/ui/Badge'
import Spinner from '../../components/ui/Spinner'
import StatCard from '../../components/dashboard/StatCard'

export default function AdminUsersPage() {
  const [users, setUsers] = useState([])
  const [search, setSearch] = useState('')
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    let mounted = true
    async function load() {
      setLoading(true)
      const { data, error } = await supabase.rpc('admin_list_users')
      if (!mounted) return
      if (error) setError(error.message)
      else setUsers(data ?? [])
      setLoading(false)
    }
    load()
    return () => {
      mounted = false
    }
  }, [])

  const totals = useMemo(
    () =>
      users.reduce(
        (acc, u) => ({
          questionsAttempted: acc.questionsAttempted + u.questions_attempted,
          practiceSessions: acc.practiceSessions + u.practice_sessions,
          testsTaken: acc.testsTaken + u.tests_taken,
        }),
        { questionsAttempted: 0, practiceSessions: 0, testsTaken: 0 }
      ),
    [users]
  )

  const filtered = users.filter((u) => {
    const q = search.trim().toLowerCase()
    if (!q) return true
    return u.full_name?.toLowerCase().includes(q) || u.email?.toLowerCase().includes(q)
  })

  if (loading) {
    return <div className="flex min-h-[60vh] items-center justify-center"><Spinner /></div>
  }

  if (error) {
    return <p className="mx-auto max-w-2xl px-4 py-10 text-red-600 dark:text-red-400">{error}</p>
  }

  return (
    <div className="mx-auto max-w-6xl px-4 py-10 sm:px-6">
      <h1 className="text-2xl font-bold text-slate-900 dark:text-white">Users</h1>
      <p className="mt-1 text-slate-500 dark:text-slate-400">Activity across every registered user.</p>

      <div className="mt-8 grid grid-cols-2 gap-4 sm:grid-cols-4">
        <StatCard label="Total users" value={users.length} icon="👥" />
        <StatCard label="Questions attempted" value={totals.questionsAttempted} tone="accent" icon="📝" />
        <StatCard label="Practice sessions" value={totals.practiceSessions} tone="neutral" icon="🎯" />
        <StatCard label="Tests taken" value={totals.testsTaken} tone="neutral" icon="⏱️" />
      </div>

      <input
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        placeholder="Search by name or email..."
        className="mt-6 w-full max-w-sm rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-slate-700 dark:bg-slate-800 dark:text-white"
      />

      <Card className="mt-4 overflow-x-auto">
        <table className="w-full min-w-[760px] text-left text-sm">
          <thead className="border-b border-slate-200 text-slate-500 dark:border-slate-800 dark:text-slate-400">
            <tr>
              <th className="px-4 py-3 font-medium">User</th>
              <th className="px-4 py-3 font-medium">Role</th>
              <th className="px-4 py-3 font-medium">Questions attempted</th>
              <th className="px-4 py-3 font-medium">Accuracy</th>
              <th className="px-4 py-3 font-medium">Practice sessions</th>
              <th className="px-4 py-3 font-medium">Tests taken</th>
              <th className="px-4 py-3 font-medium">Joined</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-slate-100 dark:divide-slate-800">
            {filtered.length === 0 && (
              <tr>
                <td colSpan={7} className="px-4 py-6 text-center text-slate-500 dark:text-slate-400">
                  No users found.
                </td>
              </tr>
            )}
            {filtered.map((u) => (
              <tr key={u.id}>
                <td className="px-4 py-3">
                  <p className="font-medium text-slate-800 dark:text-slate-100">{u.full_name || 'Unnamed user'}</p>
                  <p className="text-xs text-slate-400 dark:text-slate-500">{u.email}</p>
                </td>
                <td className="px-4 py-3">
                  <Badge variant={u.role === 'admin' ? 'brand' : 'neutral'} className="capitalize">{u.role}</Badge>
                </td>
                <td className="px-4 py-3 text-slate-700 dark:text-slate-200">{u.questions_attempted}</td>
                <td className="px-4 py-3 text-slate-700 dark:text-slate-200">
                  {u.questions_attempted > 0 ? `${u.accuracy_pct}%` : '—'}
                </td>
                <td className="px-4 py-3 text-slate-700 dark:text-slate-200">{u.practice_sessions}</td>
                <td className="px-4 py-3 text-slate-700 dark:text-slate-200">{u.tests_taken}</td>
                <td className="px-4 py-3 text-slate-500 dark:text-slate-400">
                  {new Date(u.created_at).toLocaleDateString()}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </Card>
    </div>
  )
}
