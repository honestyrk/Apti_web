import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { supabase } from '../lib/supabaseClient'
import { useCategories } from '../hooks/useCategories'
import { useBranches, useTopic, useTopics } from '../hooks/useTopics'
import Card from '../components/ui/Card'
import Button from '../components/ui/Button'
import Spinner from '../components/ui/Spinner'

const DURATIONS = [
  { label: '10 minutes', seconds: 600 },
  { label: '20 minutes', seconds: 1200 },
  { label: '30 minutes', seconds: 1800 },
  { label: '45 minutes', seconds: 2700 },
]

const COUNTS = [10, 15, 20, 25]

export default function TestSetupPage() {
  const { topicId: presetTopicId } = useParams()
  const navigate = useNavigate()
  const { topic: presetTopic } = useTopic(presetTopicId)

  const { categories } = useCategories()
  const [categoryId, setCategoryId] = useState('')
  const [branchId, setBranchId] = useState('')
  const [topicId, setTopicId] = useState(presetTopicId ?? '')
  const [questionCount, setQuestionCount] = useState(10)
  const [duration, setDuration] = useState(1200)
  const [starting, setStarting] = useState(false)
  const [error, setError] = useState('')

  const selectedCategory = categories.find((c) => c.id === categoryId)
  const { branches } = useBranches(selectedCategory?.has_branches ? categoryId : null)
  const { topics } = useTopics({
    categoryId: categoryId || null,
    branchId: branchId || null,
    noBranchOnly: !selectedCategory?.has_branches,
  })

  useEffect(() => {
    if (presetTopic) {
      setCategoryId(presetTopic.category_id)
      setBranchId(presetTopic.branch_id ?? '')
    }
  }, [presetTopic])

  const scopeType = presetTopicId || topicId ? 'topic' : branchId ? 'branch' : categoryId ? 'category' : 'full'

  const handleStart = async () => {
    setStarting(true)
    setError('')
    const activeTopicId = presetTopicId || topicId || null
    const { data, error } = await supabase.rpc('start_test_attempt', {
      p_scope_type: scopeType,
      p_topic_id: scopeType === 'topic' ? activeTopicId : null,
      p_branch_id: scopeType === 'branch' ? branchId : null,
      p_category_id: scopeType === 'category' ? categoryId : null,
      p_total_questions: questionCount,
      p_duration_seconds: duration,
    })
    setStarting(false)
    if (error) {
      setError(error.message)
      return
    }
    navigate(`/test/${data}`)
  }

  return (
    <div className="mx-auto max-w-2xl px-4 py-10 sm:px-6">
      <h1 className="text-2xl font-bold text-slate-900 dark:text-white">Set up your mock test</h1>
      <p className="mt-1 text-slate-500 dark:text-slate-400">
        {presetTopic ? `Topic-wise test: ${presetTopic.name}` : 'Choose a scope, question count, and duration.'}
      </p>

      <Card className="mt-6 space-y-6 p-6">
        {!presetTopicId && (
          <>
            <div>
              <label className="mb-1 block text-sm font-medium text-slate-700 dark:text-slate-300">Category</label>
              <select
                value={categoryId}
                onChange={(e) => {
                  setCategoryId(e.target.value)
                  setBranchId('')
                  setTopicId('')
                }}
                className="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-slate-700 dark:bg-slate-800 dark:text-white"
              >
                <option value="">Full-length (all categories)</option>
                {categories.map((c) => (
                  <option key={c.id} value={c.id}>{c.name}</option>
                ))}
              </select>
            </div>

            {selectedCategory?.has_branches && (
              <div>
                <label className="mb-1 block text-sm font-medium text-slate-700 dark:text-slate-300">Branch</label>
                <select
                  value={branchId}
                  onChange={(e) => {
                    setBranchId(e.target.value)
                    setTopicId('')
                  }}
                  className="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-slate-700 dark:bg-slate-800 dark:text-white"
                >
                  <option value="">All branches</option>
                  {branches.map((b) => (
                    <option key={b.id} value={b.id}>{b.name}</option>
                  ))}
                </select>
              </div>
            )}

            {categoryId && (
              <div>
                <label className="mb-1 block text-sm font-medium text-slate-700 dark:text-slate-300">Topic (optional)</label>
                <select
                  value={topicId}
                  onChange={(e) => setTopicId(e.target.value)}
                  className="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-slate-700 dark:bg-slate-800 dark:text-white"
                >
                  <option value="">All topics in this scope</option>
                  {topics.map((t) => (
                    <option key={t.id} value={t.id}>{t.name}</option>
                  ))}
                </select>
              </div>
            )}
          </>
        )}

        <div>
          <label className="mb-1 block text-sm font-medium text-slate-700 dark:text-slate-300">Number of questions</label>
          <div className="flex gap-2">
            {COUNTS.map((c) => (
              <button
                key={c}
                type="button"
                onClick={() => setQuestionCount(c)}
                className={`rounded-lg border px-4 py-2 text-sm font-medium ${
                  questionCount === c
                    ? 'border-brand-600 bg-brand-50 text-brand-800 dark:border-brand-500 dark:bg-brand-900/30 dark:text-brand-200'
                    : 'border-slate-300 text-slate-600 hover:bg-slate-50 dark:border-slate-700 dark:text-slate-300 dark:hover:bg-slate-800'
                }`}
              >
                {c}
              </button>
            ))}
          </div>
        </div>

        <div>
          <label className="mb-1 block text-sm font-medium text-slate-700 dark:text-slate-300">Duration</label>
          <div className="flex flex-wrap gap-2">
            {DURATIONS.map((d) => (
              <button
                key={d.seconds}
                type="button"
                onClick={() => setDuration(d.seconds)}
                className={`rounded-lg border px-4 py-2 text-sm font-medium ${
                  duration === d.seconds
                    ? 'border-brand-600 bg-brand-50 text-brand-800 dark:border-brand-500 dark:bg-brand-900/30 dark:text-brand-200'
                    : 'border-slate-300 text-slate-600 hover:bg-slate-50 dark:border-slate-700 dark:text-slate-300 dark:hover:bg-slate-800'
                }`}
              >
                {d.label}
              </button>
            ))}
          </div>
        </div>

        {error && <p className="text-sm text-red-600 dark:text-red-400">{error}</p>}

        <Button className="w-full" size="lg" onClick={handleStart} loading={starting}>
          Start test
        </Button>
      </Card>
    </div>
  )
}
