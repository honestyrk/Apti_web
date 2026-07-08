export default function Footer() {
  return (
    <footer className="border-t border-slate-200 bg-white">
      <div className="mx-auto max-w-6xl px-4 py-8 sm:px-6">
        <div className="flex flex-col items-center justify-between gap-3 sm:flex-row">
          <div className="flex items-center gap-2">
            <span className="flex h-7 w-7 items-center justify-center rounded-lg bg-linear-to-br from-brand-600 to-brand-800 font-heading text-sm font-bold text-white">
              P
            </span>
            <span className="font-heading text-sm font-semibold text-slate-700">PlacementPrep</span>
          </div>
          <p className="text-sm text-slate-400">
            © {new Date().getFullYear()} PlacementPrep. Practice smart, place better.
          </p>
        </div>
      </div>
    </footer>
  )
}
