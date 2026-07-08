import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { supabase } from '../../lib/supabaseClient'
import Card from '../../components/ui/Card'
import Button from '../../components/ui/Button'
import Spinner from '../../components/ui/Spinner'

const emptyForm = {
  topic_id: '',
  question_text: '',
  option_a: '',
  option_b: '',
  option_c: '',
  option_d: '',
  correct_option: 'a',
  explanation: '',
  difficulty: 'medium',
  is_active: true,
}

const inputClass =
  'w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500 dark:border-slate-700 dark:bg-slate-800 dark:text-white'

export default function AdminQuestionFormPage() {
  const { id } = useParams()
  const isEdit = Boolean(id)
  const navigate = useNavigate()

  const [topicOptions, setTopicOptions] = useState([])
  const [form, setForm] = useState(emptyForm)
  const [loading, setLoading] = useState(isEdit)
  const [saving, setSaving] = useState(false)
  const [error, setError] = useState('')

  useEffect(() => {
    async function loadTopics() {
      const { data } = await supabase
        .from('topics')
        .select('id, name, categories(name), branches(name)')
        .order('name')
      setTopicOptions(
        (data ?? []).map((t) => ({
          id: t.id,
          label: `${t.categories?.name ?? ''}${t.branches?.name ? ' / ' + t.branches.name : ''} / ${t.name}`,
        }))
      )
    }
    loadTopics()
  }, [])

  useEffect(() => {
    if (!isEdit) return
    async function loadQuestion() {
      setLoading(true)
      const { data, error } = await supabase.rpc('admin_get_question', { p_id: id })
      setLoading(false)
      if (error) {
        setError(error.message)
        return
      }
      const row = Array.isArray(data) ? data[0] : data
      if (row) setForm(row)
    }
    loadQuestion()
  }, [id, isEdit])

  const update = (field) => (e) => {
    const value = e.target.type === 'checkbox' ? e.target.checked : e.target.value
    setForm((f) => ({ ...f, [field]: value }))
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    setSaving(true)
    setError('')

    const rpcName = isEdit ? 'admin_update_question' : 'admin_create_question'
    const params = isEdit
      ? {
          p_id: id,
          p_topic_id: form.topic_id,
          p_question_text: form.question_text,
          p_option_a: form.option_a,
          p_option_b: form.option_b,
          p_option_c: form.option_c,
          p_option_d: form.option_d,
          p_correct_option: form.correct_option,
          p_explanation: form.explanation,
          p_difficulty: form.difficulty,
          p_is_active: form.is_active,
        }
      : {
          p_topic_id: form.topic_id,
          p_question_text: form.question_text,
          p_option_a: form.option_a,
          p_option_b: form.option_b,
          p_option_c: form.option_c,
          p_option_d: form.option_d,
          p_correct_option: form.correct_option,
          p_explanation: form.explanation,
          p_difficulty: form.difficulty,
        }

    const { error } = await supabase.rpc(rpcName, params)
    setSaving(false)
    if (error) {
      setError(error.message)
      return
    }
    navigate('/admin/questions')
  }

  if (loading) {
    return <div className="flex min-h-[60vh] items-center justify-center"><Spinner /></div>
  }

  return (
    <div className="mx-auto max-w-2xl px-4 py-10 sm:px-6">
      <h1 className="text-2xl font-bold text-slate-900 dark:text-white">{isEdit ? 'Edit question' : 'Add question'}</h1>

      <Card className="mt-6 p-6">
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="mb-1 block text-sm font-medium text-slate-700 dark:text-slate-300">Topic</label>
            <select
              required
              value={form.topic_id}
              onChange={update('topic_id')}
              className={inputClass}
            >
              <option value="">Select a topic</option>
              {topicOptions.map((t) => (
                <option key={t.id} value={t.id}>{t.label}</option>
              ))}
            </select>
          </div>

          <div>
            <label className="mb-1 block text-sm font-medium text-slate-700 dark:text-slate-300">Question text</label>
            <textarea
              required
              rows={3}
              value={form.question_text}
              onChange={update('question_text')}
              className={inputClass}
            />
          </div>

          {['a', 'b', 'c', 'd'].map((key) => (
            <div key={key} className="flex items-center gap-3">
              <input
                type="radio"
                name="correct_option"
                checked={form.correct_option === key}
                onChange={() => setForm((f) => ({ ...f, correct_option: key }))}
                className="h-4 w-4"
                aria-label={`Mark option ${key.toUpperCase()} as correct`}
              />
              <input
                required
                value={form[`option_${key}`]}
                onChange={update(`option_${key}`)}
                placeholder={`Option ${key.toUpperCase()}`}
                className={inputClass}
              />
            </div>
          ))}
          <p className="text-xs text-slate-400 dark:text-slate-500">Select the radio button next to the correct option.</p>

          <div>
            <label className="mb-1 block text-sm font-medium text-slate-700 dark:text-slate-300">Explanation</label>
            <textarea
              rows={2}
              value={form.explanation}
              onChange={update('explanation')}
              className={inputClass}
            />
          </div>

          <div>
            <label className="mb-1 block text-sm font-medium text-slate-700 dark:text-slate-300">Difficulty</label>
            <select
              value={form.difficulty}
              onChange={update('difficulty')}
              className={inputClass}
            >
              <option value="easy">Easy</option>
              <option value="medium">Medium</option>
              <option value="hard">Hard</option>
            </select>
          </div>

          {isEdit && (
            <label className="flex items-center gap-2 text-sm text-slate-700 dark:text-slate-300">
              <input type="checkbox" checked={form.is_active} onChange={update('is_active')} className="h-4 w-4" />
              Active (visible in practice/tests)
            </label>
          )}

          {error && <p className="text-sm text-red-600 dark:text-red-400">{error}</p>}

          <div className="flex gap-3">
            <Button type="submit" loading={saving}>{isEdit ? 'Save changes' : 'Create question'}</Button>
            <Button type="button" variant="outline" onClick={() => navigate('/admin/questions')}>Cancel</Button>
          </div>
        </form>
      </Card>
    </div>
  )
}
