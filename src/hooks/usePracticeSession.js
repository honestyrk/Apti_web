import { useCallback, useEffect, useState } from 'react'
import { supabase } from '../lib/supabaseClient'

function shuffle(arr) {
  const copy = [...arr]
  for (let i = copy.length - 1; i > 0; i -= 1) {
    const j = Math.floor(Math.random() * (i + 1))
    ;[copy[i], copy[j]] = [copy[j], copy[i]]
  }
  return copy
}

export function usePracticeSession(topicId) {
  const [attemptId, setAttemptId] = useState(null)
  const [questions, setQuestions] = useState([])
  const [index, setIndex] = useState(0)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  const [selected, setSelected] = useState(null)
  const [revealed, setRevealed] = useState(false)
  const [feedback, setFeedback] = useState(null)
  const [submitting, setSubmitting] = useState(false)

  const [correctCount, setCorrectCount] = useState(0)
  const [attemptedCount, setAttemptedCount] = useState(0)
  const [finished, setFinished] = useState(false)
  const [summary, setSummary] = useState(null)

  useEffect(() => {
    let mounted = true
    async function init() {
      setLoading(true)
      setError(null)
      const { data: newAttemptId, error: attemptError } = await supabase.rpc('start_practice_session', {
        p_topic_id: topicId,
      })
      if (!mounted) return
      if (attemptError) {
        setError(attemptError.message)
        setLoading(false)
        return
      }
      const { data: qData, error: qError } = await supabase
        .from('questions_public')
        .select('*')
        .eq('topic_id', topicId)
      if (!mounted) return
      if (qError) {
        setError(qError.message)
        setLoading(false)
        return
      }
      setAttemptId(newAttemptId)
      setQuestions(shuffle(qData ?? []))
      setLoading(false)
    }
    init()
    return () => {
      mounted = false
    }
  }, [topicId])

  const currentQuestion = questions[index] ?? null

  const submitAnswer = useCallback(
    async (optionKey) => {
      if (!currentQuestion || revealed || submitting) return
      setSubmitting(true)
      setSelected(optionKey)
      const { data, error } = await supabase.rpc('submit_practice_answer', {
        p_attempt_id: attemptId,
        p_question_id: currentQuestion.id,
        p_selected_option: optionKey,
      })
      setSubmitting(false)
      if (error) {
        setError(error.message)
        return
      }
      const row = Array.isArray(data) ? data[0] : data
      setFeedback(row)
      setRevealed(true)
      setAttemptedCount((c) => c + 1)
      if (row.is_correct) setCorrectCount((c) => c + 1)
    },
    [attemptId, currentQuestion, revealed, submitting]
  )

  const goToNext = useCallback(async () => {
    if (index + 1 < questions.length) {
      setIndex((i) => i + 1)
      setSelected(null)
      setRevealed(false)
      setFeedback(null)
      return
    }
    const { data } = await supabase.rpc('finalize_attempt', { p_attempt_id: attemptId })
    const row = Array.isArray(data) ? data[0] : data
    setSummary(row ?? null)
    setFinished(true)
  }, [attemptId, index, questions.length])

  return {
    attemptId,
    questions,
    currentQuestion,
    index,
    total: questions.length,
    loading,
    error,
    selected,
    revealed,
    feedback,
    submitting,
    submitAnswer,
    goToNext,
    correctCount,
    attemptedCount,
    finished,
    summary,
  }
}
