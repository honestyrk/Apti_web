import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabaseClient'
import { useCategories } from '../../hooks/useCategories'
import { useBranches, useTopics } from '../../hooks/useTopics'
import Card from '../../components/ui/Card'
import Button from '../../components/ui/Button'
import Spinner from '../../components/ui/Spinner'

function slugify(text) {
  return text
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/(^-|-$)/g, '')
}

export default function AdminTopicsPage() {
  const { categories, loading: loadingCategories } = useCategories()
  const [categoryId, setCategoryId] = useState('')
  const [branchId, setBranchId] = useState('')
  const [newBranchName, setNewBranchName] = useState('')
  const [newTopicName, setNewTopicName] = useState('')
  const [error, setError] = useState('')
  const [refreshKey, setRefreshKey] = useState(0)

  const selectedCategory = categories.find((c) => c.id === categoryId)
  const { branches, loading: loadingBranches } = useBranches(selectedCategory?.has_branches ? categoryId : null, refreshKey)
  const { topics, loading: loadingTopics } = useTopics({
    categoryId: categoryId || null,
    branchId: branchId || null,
    noBranchOnly: !selectedCategory?.has_branches,
    reloadKey: refreshKey,
  })

  useEffect(() => {
    setBranchId('')
  }, [categoryId])

  const refetch = () => setRefreshKey((k) => k + 1)

  const handleAddBranch = async (e) => {
    e.preventDefault()
    if (!newBranchName.trim()) return
    const { error } = await supabase.from('branches').insert({
      category_id: categoryId,
      name: newBranchName,
      slug: slugify(newBranchName),
    })
    if (error) setError(error.message)
    else {
      setNewBranchName('')
      refetch()
    }
  }

  const handleAddTopic = async (e) => {
    e.preventDefault()
    if (!newTopicName.trim()) return
    if (selectedCategory?.has_branches && !branchId) {
      setError('Select a branch first.')
      return
    }
    const { error } = await supabase.from('topics').insert({
      category_id: categoryId,
      branch_id: selectedCategory?.has_branches ? branchId : null,
      name: newTopicName,
      slug: slugify(newTopicName),
    })
    if (error) setError(error.message)
    else {
      setNewTopicName('')
      refetch()
    }
  }

  const handleDeleteTopic = async (topicId) => {
    if (!confirm('Delete this topic? Its questions will also be removed.')) return
    const { error } = await supabase.from('topics').delete().eq('id', topicId)
    if (error) setError(error.message)
    else refetch()
  }

  if (loadingCategories) {
    return <div className="flex min-h-[60vh] items-center justify-center"><Spinner /></div>
  }

  return (
    <div className="mx-auto max-w-3xl px-4 py-10 sm:px-6">
      <h1 className="text-2xl font-bold text-slate-900">Manage topics</h1>
      <p className="mt-1 text-slate-500">Categories are fixed; manage branches and topics below.</p>

      {error && <p className="mt-4 text-sm text-red-600">{error}</p>}

      <div className="mt-6 flex flex-wrap gap-3">
        {categories.map((c) => (
          <button
            key={c.id}
            onClick={() => setCategoryId(c.id)}
            className={`rounded-lg border px-4 py-2 text-sm font-medium ${
              categoryId === c.id ? 'border-brand-600 bg-brand-50 text-brand-800' : 'border-slate-300 text-slate-600 hover:bg-slate-50'
            }`}
          >
            {c.name}
          </button>
        ))}
      </div>

      {categoryId && selectedCategory?.has_branches && (
        <Card className="mt-6 p-5">
          <h2 className="font-semibold text-slate-800">Branches</h2>
          {loadingBranches ? (
            <Spinner size="sm" className="mt-3" />
          ) : (
            <div className="mt-3 flex flex-wrap gap-2">
              {branches.map((b) => (
                <button
                  key={b.id}
                  onClick={() => setBranchId(b.id)}
                  className={`rounded-lg border px-3 py-1.5 text-sm ${
                    branchId === b.id ? 'border-brand-600 bg-brand-50 text-brand-800' : 'border-slate-300 text-slate-600 hover:bg-slate-50'
                  }`}
                >
                  {b.name}
                </button>
              ))}
            </div>
          )}
          <form onSubmit={handleAddBranch} className="mt-3 flex gap-2">
            <input
              value={newBranchName}
              onChange={(e) => setNewBranchName(e.target.value)}
              placeholder="New branch name"
              className="w-full max-w-xs rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500"
            />
            <Button type="submit" size="sm" variant="outline">Add branch</Button>
          </form>
        </Card>
      )}

      {categoryId && (!selectedCategory?.has_branches || branchId) && (
        <Card className="mt-6 p-5">
          <h2 className="font-semibold text-slate-800">Topics</h2>
          {loadingTopics ? (
            <Spinner size="sm" className="mt-3" />
          ) : (
            <div className="mt-3 divide-y divide-slate-100">
              {topics.length === 0 && <p className="py-2 text-sm text-slate-500">No topics yet.</p>}
              {topics.map((t) => (
                <div key={t.id} className="flex items-center justify-between py-2">
                  <span className="text-sm text-slate-700">{t.name}</span>
                  <Button size="sm" variant="danger" onClick={() => handleDeleteTopic(t.id)}>Delete</Button>
                </div>
              ))}
            </div>
          )}
          <form onSubmit={handleAddTopic} className="mt-3 flex gap-2">
            <input
              value={newTopicName}
              onChange={(e) => setNewTopicName(e.target.value)}
              placeholder="New topic name"
              className="w-full max-w-xs rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500"
            />
            <Button type="submit" size="sm" variant="outline">Add topic</Button>
          </form>
        </Card>
      )}
    </div>
  )
}
