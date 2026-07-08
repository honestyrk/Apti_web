import Card from '../ui/Card'

export default function StatCard({ label, value, tone = 'brand' }) {
  const tones = {
    brand: 'text-brand-800',
    accent: 'text-accent-600',
    danger: 'text-red-600',
    neutral: 'text-slate-700',
  }
  return (
    <Card className="p-5">
      <p className={`text-3xl font-bold ${tones[tone]}`}>{value}</p>
      <p className="mt-1 text-sm text-slate-500">{label}</p>
    </Card>
  )
}
