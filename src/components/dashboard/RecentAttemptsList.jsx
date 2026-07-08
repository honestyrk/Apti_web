import { Link } from 'react-router-dom'
import Card from '../ui/Card'
import Badge from '../ui/Badge'

const statusVariant = {
  submitted: 'success',
  auto_submitted: 'warning',
  in_progress: 'brand',
  abandoned: 'neutral',
}

export default function RecentAttemptsList({ attempts }) {
  if (attempts.length === 0) {
    return <Card className="p-6 text-sm text-slate-500">No attempts yet.</Card>
  }

  return (
    <Card className="divide-y divide-slate-100">
      {attempts.map((a) => (
        <Link
          key={a.id}
          to={a.status === 'in_progress' && a.mode === 'test' ? `/test/${a.id}` : `/test/${a.id}/results`}
          className="flex items-center justify-between gap-4 px-5 py-4 hover:bg-slate-50"
        >
          <div>
            <p className="text-sm font-medium text-slate-800 capitalize">{a.mode} · {a.scope_type}</p>
            <p className="text-xs text-slate-400">{new Date(a.started_at).toLocaleString()}</p>
          </div>
          <div className="flex items-center gap-3">
            {a.score != null && <span className="text-sm font-semibold text-slate-700">{a.score}%</span>}
            <Badge variant={statusVariant[a.status] ?? 'neutral'} className="capitalize">
              {a.status.replace('_', ' ')}
            </Badge>
          </div>
        </Link>
      ))}
    </Card>
  )
}
