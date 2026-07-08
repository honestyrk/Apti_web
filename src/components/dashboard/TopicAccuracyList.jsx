import Card from '../ui/Card'
import ProgressBar from '../ui/ProgressBar'

export default function TopicAccuracyList({ rows }) {
  if (rows.length === 0) {
    return (
      <Card className="p-6 text-sm text-slate-500 dark:text-slate-400">
        No practice data yet. Start practicing a topic to see your accuracy breakdown here.
      </Card>
    )
  }

  return (
    <Card className="divide-y divide-slate-100 dark:divide-slate-800">
      {rows.map((row) => (
        <div key={row.topic_id} className="flex items-center justify-between gap-4 px-5 py-4">
          <div className="min-w-0 flex-1">
            <p className="truncate text-sm font-medium text-slate-800 dark:text-slate-100">{row.topic_name}</p>
            <ProgressBar
              value={row.accuracy_pct}
              className="mt-2"
              tone={row.accuracy_pct >= 70 ? 'success' : row.accuracy_pct >= 40 ? 'brand' : 'danger'}
            />
          </div>
          <div className="w-16 shrink-0 text-right">
            <p className="text-sm font-semibold text-slate-700 dark:text-slate-200">{row.accuracy_pct}%</p>
            <p className="text-xs text-slate-400 dark:text-slate-500">{row.questions_attempted} qs</p>
          </div>
        </div>
      ))}
    </Card>
  )
}
