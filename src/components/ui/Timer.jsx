export default function Timer({ label, low = false }) {
  return (
    <div
      className={`inline-flex items-center gap-2 rounded-lg border px-3 py-1.5 font-mono text-sm font-semibold tabular-nums ${
        low ? 'border-red-300 bg-red-50 text-red-700' : 'border-slate-300 bg-white text-slate-700'
      }`}
    >
      <span aria-hidden>⏱</span>
      {label}
    </div>
  )
}
