import { Link, useParams } from 'react-router-dom'
import { useCategoryBySlug } from '../hooks/useCategories'
import { useBranches, useTopics } from '../hooks/useTopics'
import Card from '../components/ui/Card'
import Spinner from '../components/ui/Spinner'

export default function CategoryDetailPage() {
  const { categorySlug } = useParams()
  const { category, loading: loadingCategory } = useCategoryBySlug(categorySlug)
  const { branches, loading: loadingBranches } = useBranches(category?.has_branches ? category.id : null)
  const { topics, loading: loadingTopics } = useTopics({
    categoryId: !category?.has_branches ? category?.id : null,
    noBranchOnly: true,
  })

  if (loadingCategory || (category?.has_branches && loadingBranches) || (!category?.has_branches && loadingTopics)) {
    return <div className="flex min-h-[50vh] items-center justify-center"><Spinner /></div>
  }

  if (!category) {
    return <p className="mx-auto max-w-6xl px-4 py-10 text-slate-500">Category not found.</p>
  }

  return (
    <div className="mx-auto max-w-6xl px-4 py-10 sm:px-6">
      <nav className="text-sm text-slate-500">
        <Link to="/categories" className="hover:text-brand-700">Categories</Link>
        <span className="mx-1">/</span>
        <span className="text-slate-700">{category.name}</span>
      </nav>
      <h1 className="mt-2 text-2xl font-bold text-slate-900">{category.name}</h1>
      {category.description && <p className="mt-1 text-slate-500">{category.description}</p>}

      {category.has_branches ? (
        <div className="mt-8 grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
          {branches.map((b) => (
            <Link key={b.id} to={`/categories/${category.slug}/branches/${b.slug}`}>
              <Card className="h-full p-6 transition-shadow hover:shadow-md">
                <h2 className="font-semibold text-slate-900">{b.name}</h2>
                {b.description && <p className="mt-1 text-sm text-slate-500">{b.description}</p>}
              </Card>
            </Link>
          ))}
        </div>
      ) : (
        <TopicGrid topics={topics} />
      )}
    </div>
  )
}

export function TopicGrid({ topics }) {
  if (topics.length === 0) {
    return <p className="mt-8 text-slate-500">No topics available yet.</p>
  }
  return (
    <div className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
      {topics.map((t) => (
        <Card key={t.id} className="flex flex-col justify-between p-5">
          <div>
            <h3 className="font-semibold text-slate-900">{t.name}</h3>
            {t.description && <p className="mt-1 text-sm text-slate-500">{t.description}</p>}
          </div>
          <div className="mt-4 flex gap-2">
            <Link
              to={`/practice/${t.id}`}
              className="flex-1 rounded-lg bg-brand-700 px-3 py-2 text-center text-sm font-medium text-white hover:bg-brand-800"
            >
              Practice
            </Link>
            <Link
              to={`/test/setup/${t.id}`}
              className="flex-1 rounded-lg border border-slate-300 px-3 py-2 text-center text-sm font-medium text-slate-700 hover:bg-slate-50"
            >
              Take Test
            </Link>
          </div>
        </Card>
      ))}
    </div>
  )
}
