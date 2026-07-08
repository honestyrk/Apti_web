export default function ProgressBar({ value = 0, className = '', tone = 'brand' }) {
  const pct = Math.max(0, Math.min(100, value))
  const tones = {
    brand: 'bg-brand-600',
    accent: 'bg-accent-500',
    success: 'bg-emerald-500',
    danger: 'bg-red-500',
  }
  return (
    <div className={`h-2 w-full overflow-hidden rounded-full bg-slate-100 dark:bg-slate-800 ${className}`}>
      <div
        className={`h-full rounded-full transition-all ${tones[tone]}`}
        style={{ width: `${pct}%` }}
      />
    </div>
  )
}
