import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../../lib/supabaseClient'
import Card from '../../components/ui/Card'
import Button from '../../components/ui/Button'
import Badge from '../../components/ui/Badge'
import DifficultyBadge from '../../components/ui/DifficultyBadge'
import Spinner from '../../components/ui/Spinner'

const PAGE_SIZE = 20

export default function AdminQuestionsPage() {
  const [questions, setQuestions] = useState([])
  const [search, setSearch] = useState('')
  const [page, setPage] = useState(0)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')

  const load = async () => {
    setLoading(true)
    const { data, error } = await supabase.rpc('admin_list_questions', {
      p_search: search || null,
      p_limit: PAGE_SIZE,
      p_offset: page * PAGE_SIZE,
    })
    if (error) setError(error.message)
    else setQuestions(data ?? [])
    setLoading(false)
  }

  useEffect(() => {
    load()
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [page])

  const handleSearch = (e) => {
    e.preventDefault()
    setPage(0)
    load()
  }

  const handleDelete = async (id) => {
    if (!confirm('Deactivate this question? It will be hidden from practice/tests but existing history is preserved.')) return
    const { error } = await supabase.rpc('admin_delete_question', { p_id: id })
    if (error) {
      setError(error.message)
      return
    }
    load()
  }

  return (
    <div className="mx-auto max-w-5xl px-4 py-10 sm:px-6">
      <div className="flex flex-wrap items-center justify-between gap-4">
        <h1 className="text-2xl font-bold text-slate-900">Manage questions</h1>
        <Link to="/admin/questions/new"><Button>Add question</Button></Link>
      </div>

      <form onSubmit={handleSearch} className="mt-6 flex gap-2">
        <input
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          placeholder="Search question text..."
          className="w-full max-w-sm rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500"
        />
        <Button type="submit" variant="outline">Search</Button>
      </form>

      {error && <p className="mt-4 text-sm text-red-600">{error}</p>}

      {loading ? (
        <div className="mt-10 flex justify-center"><Spinner /></div>
      ) : (
        <Card className="mt-6 divide-y divide-slate-100">
          {questions.length === 0 && <p className="p-6 text-sm text-slate-500">No questions found.</p>}
          {questions.map((q) => (
            <div key={q.id} className="flex items-start justify-between gap-4 p-4">
              <div className="min-w-0">
                <p className="truncate font-medium text-slate-800">{q.question_text}</p>
                <div className="mt-1 flex flex-wrap items-center gap-2">
                  <Badge>{q.topic_name}</Badge>
                  <DifficultyBadge difficulty={q.difficulty} />
                  {!q.is_active && <Badge variant="danger">Inactive</Badge>}
                </div>
              </div>
              <div className="flex shrink-0 gap-2">
                <Link to={`/admin/questions/${q.id}/edit`}>
                  <Button size="sm" variant="outline">Edit</Button>
                </Link>
                {q.is_active && (
                  <Button size="sm" variant="danger" onClick={() => handleDelete(q.id)}>Deactivate</Button>
                )}
              </div>
            </div>
          ))}
        </Card>
      )}

      <div className="mt-4 flex justify-between">
        <Button variant="outline" size="sm" disabled={page === 0} onClick={() => setPage((p) => p - 1)}>Previous</Button>
        <Button variant="outline" size="sm" disabled={questions.length < PAGE_SIZE} onClick={() => setPage((p) => p + 1)}>Next</Button>
      </div>
    </div>
  )
}
