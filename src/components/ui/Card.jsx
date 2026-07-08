export default function Card({ className = '', hover = false, children, ...props }) {
  return (
    <div
      className={`rounded-2xl border border-slate-200/80 bg-white shadow-(--shadow-card) ${
        hover ? 'transition-all duration-200 hover:-translate-y-0.5 hover:shadow-(--shadow-card-hover)' : ''
      } ${className}`}
      {...props}
    >
      {children}
    </div>
  )
}
