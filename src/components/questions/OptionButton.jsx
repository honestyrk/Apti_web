const letters = { a: 'A', b: 'B', c: 'C', d: 'D' }

export default function OptionButton({ optionKey, text, selected, correct, revealed, disabled, onClick }) {
  let stateClasses = 'border-slate-200 hover:border-brand-300 hover:bg-brand-50/50'

  if (revealed) {
    if (correct) {
      stateClasses = 'border-emerald-400 bg-emerald-50'
    } else if (selected && !correct) {
      stateClasses = 'border-red-400 bg-red-50'
    } else {
      stateClasses = 'border-slate-200 opacity-70'
    }
  } else if (selected) {
    stateClasses = 'border-brand-500 bg-brand-50'
  }

  return (
    <button
      type="button"
      disabled={disabled}
      onClick={onClick}
      className={`flex w-full items-start gap-3 rounded-lg border-2 px-4 py-3 text-left text-sm transition-colors disabled:cursor-default ${stateClasses}`}
    >
      <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full border border-current text-xs font-semibold">
        {letters[optionKey]}
      </span>
      <span className="text-slate-800">{text}</span>
      {revealed && correct && <span className="ml-auto text-emerald-600">✓</span>}
      {revealed && selected && !correct && <span className="ml-auto text-red-600">✗</span>}
    </button>
  )
}
