import { useEffect, useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { supabase } from '../lib/supabaseClient'
import Card from '../components/ui/Card'
import Button from '../components/ui/Button'
import Spinner from '../components/ui/Spinner'
import DifficultyBadge from '../components/ui/DifficultyBadge'

const letters = { a: 'A', b: 'B', c: 'C', d: 'D' }

export default function ResultsPage() {
  const { attemptId } = useParams()
  const [attempt, setAttempt] = useState(null)
  const [review, setReview] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    let mounted = true
    async function load() {
      setLoading(true)
      const { data: attemptData, error: attemptError } = await supabase
        .from('test_attempts')
        .select('*')
        .eq('id', attemptId)
        .single()
      if (!mounted) return
      if (attemptError) {
        setError(attemptError.message)
        setLoading(false)
        return
      }
      if (attemptData.status === 'in_progress') {
        setError('This attempt is still in progress.')
        setLoading(false)
        return
      }
      setAttempt(attemptData)

      const { data: reviewData, error: reviewError } = await supabase.rpc('get_attempt_review', {
        p_attempt_id: attemptId,
      })
      if (!mounted) return
      if (reviewError) {
        setError(reviewError.message)
        setLoading(false)
        return
      }
      setReview(reviewData ?? [])
      setLoading(false)
    }
    load()
    return () => {
      mounted = false
    }
  }, [attemptId])

  if (loading) {
    return <div className="flex min-h-[60vh] items-center justify-center"><Spinner /></div>
  }

  if (error) {
    return <p className="mx-auto max-w-2xl px-4 py-10 text-red-600 dark:text-red-400">{error}</p>
  }

  return (
    <div className="mx-auto max-w-3xl px-4 py-10 sm:px-6">
      <Card className="p-6">
        <h1 className="text-2xl font-bold text-slate-900 dark:text-white">
          {attempt.status === 'auto_submitted'
            ? "Time's up — Test auto-submitted"
            : attempt.mode === 'practice'
              ? 'Practice session complete'
              : 'Test submitted'}
        </h1>
        <div className="mt-6 grid grid-cols-4 gap-4 text-center">
          <div>
            <p className="text-2xl font-bold text-brand-800 dark:text-brand-300">{attempt.score}%</p>
            <p className="text-xs text-slate-500 dark:text-slate-400">Score</p>
          </div>
          <div>
            <p className="text-2xl font-bold text-emerald-600 dark:text-emerald-400">{attempt.correct_count}</p>
            <p className="text-xs text-slate-500 dark:text-slate-400">Correct</p>
          </div>
          <div>
            <p className="text-2xl font-bold text-red-600 dark:text-red-400">{attempt.incorrect_count}</p>
            <p className="text-xs text-slate-500 dark:text-slate-400">Incorrect</p>
          </div>
          <div>
            <p className="text-2xl font-bold text-slate-500 dark:text-slate-400">{attempt.unanswered_count}</p>
            <p className="text-xs text-slate-500 dark:text-slate-400">Unanswered</p>
          </div>
        </div>
      </Card>

      <h2 className="mt-8 text-lg font-semibold text-slate-900 dark:text-white">Review</h2>
      <div className="mt-4 space-y-4">
        {review.map((q) => (
          <Card key={q.question_id} className="p-5">
            <div className="flex items-center justify-between text-sm text-slate-500 dark:text-slate-400">
              <span>Question {q.order_index + 1}</span>
              <DifficultyBadge difficulty={q.difficulty ?? 'medium'} />
            </div>
            <p className="mt-2 font-medium text-slate-900 dark:text-white">{q.question_text}</p>

            <div className="mt-3 space-y-2">
              {['a', 'b', 'c', 'd'].map((key) => {
                const isCorrectOpt = q.correct_option === key
                const isSelectedOpt = q.selected_option === key
                let classes = 'border-slate-200 dark:border-slate-700'
                if (isCorrectOpt) classes = 'border-emerald-400 bg-emerald-50 dark:border-emerald-600 dark:bg-emerald-950/40'
                else if (isSelectedOpt && !isCorrectOpt) classes = 'border-red-400 bg-red-50 dark:border-red-600 dark:bg-red-950/40'
                return (
                  <div key={key} className={`flex items-center gap-3 rounded-lg border-2 px-3 py-2 text-sm text-slate-800 dark:text-slate-100 ${classes}`}>
                    <span className="flex h-5 w-5 shrink-0 items-center justify-center rounded-full border border-current text-xs font-semibold">
                      {letters[key]}
                    </span>
                    <span>{q[`option_${key}`]}</span>
                    {isCorrectOpt && <span className="ml-auto text-emerald-600 dark:text-emerald-400">✓ Correct</span>}
                    {isSelectedOpt && !isCorrectOpt && <span className="ml-auto text-red-600 dark:text-red-400">✗ Your answer</span>}
                  </div>
                )
              })}
              {!q.selected_option && <p className="text-xs italic text-slate-400 dark:text-slate-500">You did not answer this question.</p>}
            </div>

            {q.explanation && (
              <div className="mt-3 rounded-lg bg-slate-50 px-4 py-3 text-sm text-slate-600 dark:bg-slate-800/60 dark:text-slate-300">
                <span className="font-semibold text-slate-700 dark:text-slate-200">Explanation: </span>
                {q.explanation}
              </div>
            )}
          </Card>
        ))}
      </div>

      <div className="mt-8 flex justify-center gap-3">
        <Link to="/history"><Button variant="outline">View history</Button></Link>
        <Link to="/dashboard"><Button>Go to dashboard</Button></Link>
      </div>
    </div>
  )
}
