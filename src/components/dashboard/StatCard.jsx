import Card from '../ui/Card'

const tones = {
  brand: { text: 'text-brand-800', bg: 'bg-brand-50' },
  accent: { text: 'text-accent-600', bg: 'bg-accent-50' },
  danger: { text: 'text-red-600', bg: 'bg-red-50' },
  neutral: { text: 'text-slate-700', bg: 'bg-slate-100' },
}

export default function StatCard({ label, value, tone = 'brand', icon }) {
  const t = tones[tone]
  return (
    <Card className="p-5">
      <div className="flex items-center justify-between">
        <p className={`font-heading text-3xl font-bold ${t.text}`}>{value}</p>
        {icon && <span className={`flex h-9 w-9 items-center justify-center rounded-lg text-base ${t.bg}`}>{icon}</span>}
      </div>
      <p className="mt-1.5 text-sm text-slate-500">{label}</p>
    </Card>
  )
}
