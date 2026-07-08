export default function ExplanationPanel({ isCorrect, explanation }) {
  return (
    <div
      className={`mt-4 rounded-lg border px-4 py-3 text-sm ${
        isCorrect ? 'border-emerald-200 bg-emerald-50 text-emerald-800' : 'border-red-200 bg-red-50 text-red-800'
      }`}
    >
      <p className="font-semibold">{isCorrect ? 'Correct!' : 'Incorrect'}</p>
      {explanation && <p className="mt-1 text-slate-700">{explanation}</p>}
    </div>
  )
}
