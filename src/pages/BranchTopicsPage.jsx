import { Link, useParams } from 'react-router-dom'
import { useCategoryBySlug } from '../hooks/useCategories'
import { useTopics } from '../hooks/useTopics'
import { supabase } from '../lib/supabaseClient'
import { useEffect, useState } from 'react'
import Spinner from '../components/ui/Spinner'
import { TopicGrid } from './CategoryDetailPage'

function useBranchBySlug(categoryId, branchSlug) {
  const [branch, setBranch] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!categoryId || !branchSlug) {
      setLoading(false)
      return undefined
    }
    let mounted = true
    setLoading(true)
    supabase
      .from('branches')
      .select('*')
      .eq('category_id', categoryId)
      .eq('slug', branchSlug)
      .single()
      .then(({ data }) => {
        if (!mounted) return
        setBranch(data ?? null)
        setLoading(false)
      })
    return () => {
      mounted = false
    }
  }, [categoryId, branchSlug])

  return { branch, loading }
}

export default function BranchTopicsPage() {
  const { categorySlug, branchSlug } = useParams()
  const { category, loading: loadingCategory } = useCategoryBySlug(categorySlug)
  const { branch, loading: loadingBranch } = useBranchBySlug(category?.id, branchSlug)
  const { topics, loading: loadingTopics } = useTopics({ categoryId: category?.id, branchId: branch?.id })

  if (loadingCategory || loadingBranch || (branch && loadingTopics)) {
    return <div className="flex min-h-[50vh] items-center justify-center"><Spinner /></div>
  }

  if (!category || !branch) {
    return <p className="mx-auto max-w-6xl px-4 py-10 text-slate-500 dark:text-slate-400">Branch not found.</p>
  }

  return (
    <div className="mx-auto max-w-6xl px-4 py-10 sm:px-6">
      <nav className="text-sm text-slate-500 dark:text-slate-400">
        <Link to="/categories" className="hover:text-brand-700 dark:hover:text-brand-300">Categories</Link>
        <span className="mx-1">/</span>
        <Link to={`/categories/${category.slug}`} className="hover:text-brand-700 dark:hover:text-brand-300">{category.name}</Link>
        <span className="mx-1">/</span>
        <span className="text-slate-700 dark:text-slate-300">{branch.name}</span>
      </nav>
      <h1 className="mt-2 text-2xl font-bold text-slate-900 dark:text-white">{branch.name}</h1>

      <TopicGrid topics={topics} />
    </div>
  )
}
