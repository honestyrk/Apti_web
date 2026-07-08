export default function ExplanationPanel({ isCorrect, explanation }) {
  return (
    <div
      className={`mt-4 rounded-lg border px-4 py-3 text-sm ${
        isCorrect
          ? 'border-emerald-200 bg-emerald-50 text-emerald-800 dark:border-emerald-800 dark:bg-emerald-950/40 dark:text-emerald-300'
          : 'border-red-200 bg-red-50 text-red-800 dark:border-red-800 dark:bg-red-950/40 dark:text-red-300'
      }`}
    >
      <p className="font-semibold">{isCorrect ? 'Correct!' : 'Incorrect'}</p>
      {explanation && <p className="mt-1 text-slate-700 dark:text-slate-300">{explanation}</p>}
    </div>
  )
}
