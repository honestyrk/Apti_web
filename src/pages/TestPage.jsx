import { useCallback, useEffect, useRef, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { supabase } from '../lib/supabaseClient'
import { useTestTimer } from '../hooks/useTestTimer'
import Card from '../components/ui/Card'
import Button from '../components/ui/Button'
import Spinner from '../components/ui/Spinner'
import Timer from '../components/ui/Timer'
import Modal from '../components/ui/Modal'
import DifficultyBadge from '../components/ui/DifficultyBadge'
import OptionsList from '../components/questions/OptionsList'

export default function TestPage() {
  const { attemptId } = useParams()
  const navigate = useNavigate()

  const [attempt, setAttempt] = useState(null)
  const [questions, setQuestions] = useState([])
  const [answers, setAnswers] = useState({})
  const [index, setIndex] = useState(0)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [confirmOpen, setConfirmOpen] = useState(false)
  const [submittingFinal, setSubmittingFinal] = useState(false)
  const finalizingRef = useRef(false)

  const loadAttempt = useCallback(async () => {
    const { data, error } = await supabase.from('test_attempts').select('*').eq('id', attemptId).single()
    if (error) {
      setError(error.message)
      return null
    }
    setAttempt(data)
    return data
  }, [attemptId])

  const finalize = useCallback(
    async (auto) => {
      if (finalizingRef.current) return
      finalizingRef.current = true
      setSubmittingFinal(true)
      await supabase.rpc('finalize_attempt', { p_attempt_id: attemptId, p_auto: auto })
      navigate(`/test/${attemptId}/results`, { replace: true })
    },
    [attemptId, navigate]
  )

  const { label, expired } = useTestTimer(attempt?.expires_at, () => finalize(true))

  useEffect(() => {
    let mounted = true
    async function init() {
      setLoading(true)
      const attemptData = await loadAttempt()
      if (!mounted || !attemptData) {
        setLoading(false)
        return
      }
      if (attemptData.status !== 'in_progress') {
        navigate(`/test/${attemptId}/results`, { replace: true })
        return
      }
      const { data: qData, error: qError } = await supabase.rpc('get_test_questions', { p_attempt_id: attemptId })
      if (!mounted) return
      if (qError) {
        setError(qError.message)
        setLoading(false)
        return
      }
      setQuestions(qData ?? [])
      const initialAnswers = {}
      for (const q of qData ?? []) {
        if (q.selected_option) initialAnswers[q.question_id] = q.selected_option
      }
      setAnswers(initialAnswers)
      setLoading(false)
    }
    init()
    return () => {
      mounted = false
    }
  }, [attemptId, loadAttempt, navigate])

  const current = questions[index]

  const handleSelect = async (optionKey) => {
    if (!current || expired) return
    setAnswers((prev) => ({ ...prev, [current.question_id]: optionKey }))
    const { error } = await supabase.rpc('submit_test_answer', {
      p_attempt_id: attemptId,
      p_question_id: current.question_id,
      p_selected_option: optionKey,
    })
    if (error) setError(error.message)
  }

  if (loading) {
    return <div className="flex min-h-[60vh] items-center justify-center"><Spinner /></div>
  }

  if (error) {
    return <p className="mx-auto max-w-2xl px-4 py-10 text-red-600 dark:text-red-400">{error}</p>
  }

  if (!current) {
    return <p className="mx-auto max-w-2xl px-4 py-10 text-slate-500 dark:text-slate-400">No questions found for this test.</p>
  }

  const answeredCount = Object.keys(answers).length

  return (
    <div className="mx-auto max-w-5xl px-4 py-6 sm:px-6">
      <div className="mb-4 flex items-center justify-between">
        <div>
          <p className="text-sm font-medium text-slate-500 dark:text-slate-400">Test Mode</p>
          <p className="text-xs text-slate-400 dark:text-slate-500">{answeredCount}/{questions.length} answered</p>
        </div>
        <div className="flex items-center gap-3">
          <Timer label={label} low={attempt && (new Date(attempt.expires_at) - Date.now()) / 1000 < 60} />
          <Button variant="danger" size="sm" onClick={() => setConfirmOpen(true)}>Submit test</Button>
        </div>
      </div>

      <div className="grid gap-6 lg:grid-cols-[1fr_240px]">
        <Card className="p-6">
          <div className="flex items-center justify-between text-sm text-slate-500 dark:text-slate-400">
            <span>Question {index + 1} of {questions.length}</span>
            {current.difficulty && <DifficultyBadge difficulty={current.difficulty} />}
          </div>
          <h2 className="mt-2 text-lg font-medium text-slate-900 dark:text-white">{current.question_text}</h2>

          <OptionsList
            question={current}
            selected={answers[current.question_id] ?? null}
            correctOption={null}
            revealed={false}
            disabled={expired}
            onSelect={handleSelect}
          />

          <div className="mt-6 flex justify-between">
            <Button variant="outline" disabled={index === 0} onClick={() => setIndex((i) => i - 1)}>
              Previous
            </Button>
            {index + 1 >= questions.length ? (
              <Button variant="danger" onClick={() => setConfirmOpen(true)}>
                Submit test
              </Button>
            ) : (
              <Button onClick={() => setIndex((i) => i + 1)}>Next</Button>
            )}
          </div>
        </Card>

        <Card className="h-fit p-4">
          <p className="mb-3 text-sm font-medium text-slate-700 dark:text-slate-300">Questions</p>
          <div className="grid grid-cols-5 gap-2">
            {questions.map((q, i) => {
              const isAnswered = Boolean(answers[q.question_id])
              return (
                <button
                  key={q.question_id}
                  onClick={() => setIndex(i)}
                  className={`flex h-9 w-9 items-center justify-center rounded-md text-xs font-semibold ${
                    i === index
                      ? 'bg-brand-700 text-white'
                      : isAnswered
                        ? 'bg-accent-100 text-accent-800 dark:bg-accent-900/40 dark:text-accent-200'
                        : 'bg-slate-100 text-slate-500 dark:bg-slate-800 dark:text-slate-400'
                  }`}
                >
                  {i + 1}
                </button>
              )
            })}
          </div>
        </Card>
      </div>

      <Modal
        open={confirmOpen}
        onClose={() => setConfirmOpen(false)}
        title="Submit test?"
        footer={
          <>
            <Button variant="outline" onClick={() => setConfirmOpen(false)}>Cancel</Button>
            <Button variant="danger" loading={submittingFinal} onClick={() => finalize(false)}>
              Submit
            </Button>
          </>
        }
      >
        <p className="text-sm text-slate-600 dark:text-slate-300">
          You've answered {answeredCount} of {questions.length} questions. Once submitted, you can't change your answers.
        </p>
      </Modal>
    </div>
  )
}
