const letters = { a: 'A', b: 'B', c: 'C', d: 'D' }

export default function OptionButton({ optionKey, text, selected, correct, revealed, disabled, onClick }) {
  let stateClasses = 'border-slate-200 hover:border-brand-300 hover:bg-brand-50/50 dark:border-slate-700 dark:hover:border-brand-500 dark:hover:bg-brand-900/20'

  if (revealed) {
    if (correct) {
      stateClasses = 'border-emerald-400 bg-emerald-50 dark:border-emerald-600 dark:bg-emerald-950/40'
    } else if (selected && !correct) {
      stateClasses = 'border-red-400 bg-red-50 dark:border-red-600 dark:bg-red-950/40'
    } else {
      stateClasses = 'border-slate-200 opacity-70 dark:border-slate-700'
    }
  } else if (selected) {
    stateClasses = 'border-brand-500 bg-brand-50 dark:border-brand-400 dark:bg-brand-900/30'
  }

  return (
    <button
      type="button"
      disabled={disabled}
      onClick={onClick}
      className={`flex w-full items-start gap-3 rounded-lg border-2 px-4 py-3 text-left text-sm transition-colors disabled:cursor-default ${stateClasses}`}
    >
      <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full border border-current text-xs font-semibold text-slate-700 dark:text-slate-300">
        {letters[optionKey]}
      </span>
      <span className="text-slate-800 dark:text-slate-100">{text}</span>
      {revealed && correct && <span className="ml-auto text-emerald-600 dark:text-emerald-400">✓</span>}
      {revealed && selected && !correct && <span className="ml-auto text-red-600 dark:text-red-400">✗</span>}
    </button>
  )
}
