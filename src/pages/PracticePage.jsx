import { Link, useParams } from 'react-router-dom'
import { useTopic } from '../hooks/useTopics'
import { usePracticeSession } from '../hooks/usePracticeSession'
import Card from '../components/ui/Card'
import Spinner from '../components/ui/Spinner'
import Button from '../components/ui/Button'
import ProgressBar from '../components/ui/ProgressBar'
import QuestionCard from '../components/questions/QuestionCard'

export default function PracticePage() {
  const { topicId } = useParams()
  const { topic } = useTopic(topicId)
  const {
    currentQuestion,
    index,
    total,
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
  } = usePracticeSession(topicId)

  if (loading) {
    return <div className="flex min-h-[60vh] items-center justify-center"><Spinner /></div>
  }

  if (error) {
    return <p className="mx-auto max-w-2xl px-4 py-10 text-red-600 dark:text-red-400">{error}</p>
  }

  if (total === 0) {
    return (
      <div className="mx-auto max-w-2xl px-4 py-10 text-center">
        <p className="text-slate-500 dark:text-slate-400">No questions available for this topic yet.</p>
        <Link to="/categories" className="mt-4 inline-block"><Button variant="outline">Back to categories</Button></Link>
      </div>
    )
  }

  if (finished) {
    return (
      <div className="mx-auto max-w-lg px-4 py-16 text-center">
        <Card className="p-8">
          <h1 className="text-2xl font-bold text-slate-900 dark:text-white">Practice complete!</h1>
          <p className="mt-2 text-slate-500 dark:text-slate-400">{topic?.name}</p>
          <div className="mt-6 grid grid-cols-3 gap-4">
            <div>
              <p className="text-2xl font-bold text-brand-800 dark:text-brand-300">{summary?.correct_count ?? correctCount}</p>
              <p className="text-xs text-slate-500 dark:text-slate-400">Correct</p>
            </div>
            <div>
              <p className="text-2xl font-bold text-slate-700 dark:text-slate-200">{summary?.incorrect_count ?? attemptedCount - correctCount}</p>
              <p className="text-xs text-slate-500 dark:text-slate-400">Incorrect</p>
            </div>
            <div>
              <p className="text-2xl font-bold text-accent-600 dark:text-accent-400">{summary?.score ?? 0}%</p>
              <p className="text-xs text-slate-500 dark:text-slate-400">Accuracy</p>
            </div>
          </div>
          <div className="mt-8 flex justify-center gap-3">
            <Link to="/categories"><Button variant="outline">More topics</Button></Link>
            <Link to="/dashboard"><Button>Go to dashboard</Button></Link>
          </div>
        </Card>
      </div>
    )
  }

  return (
    <div className="mx-auto max-w-2xl px-4 py-8 sm:px-6">
      <div className="mb-4">
        <p className="text-sm font-medium text-slate-500 dark:text-slate-400">{topic?.name} · Practice Mode</p>
        <ProgressBar value={(index / total) * 100} className="mt-2" />
      </div>

      <Card className="p-6">
        <QuestionCard
          question={currentQuestion}
          index={index}
          total={total}
          selected={selected}
          correctOption={feedback?.correct_option}
          revealed={revealed}
          isCorrect={feedback?.is_correct}
          explanation={feedback?.explanation}
          disabled={revealed || submitting}
          onSelect={submitAnswer}
        />

        <div className="mt-6 flex items-center justify-between">
          <p className="text-sm text-slate-500 dark:text-slate-400">
            {correctCount}/{attemptedCount} correct so far
          </p>
          {revealed && (
            <Button onClick={goToNext}>
              {index + 1 < total ? 'Next question' : 'Finish'}
            </Button>
          )}
        </div>
      </Card>
    </div>
  )
}
