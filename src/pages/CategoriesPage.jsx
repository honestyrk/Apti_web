import { Link } from 'react-router-dom'
import { useCategories } from '../hooks/useCategories'
import Card from '../components/ui/Card'
import Spinner from '../components/ui/Spinner'

const icons = {
  'quantitative-aptitude': '🧮',
  'logical-reasoning': '🧩',
  'verbal-ability': '📖',
  technical: '💻',
}

export default function CategoriesPage() {
  const { categories, loading } = useCategories()

  return (
    <div className="mx-auto max-w-6xl px-4 py-10 sm:px-6">
      <h1 className="font-heading text-2xl font-bold text-slate-900">Choose a category</h1>
      <p className="mt-1 text-slate-500">Pick a subject to start practicing.</p>

      {loading ? (
        <div className="mt-10 flex justify-center"><Spinner /></div>
      ) : (
        <div className="mt-8 grid gap-5 sm:grid-cols-2 lg:grid-cols-4">
          {categories.map((cat) => (
            <Link key={cat.id} to={`/categories/${cat.slug}`}>
              <Card hover className="h-full p-6">
                <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-brand-50 text-2xl">
                  {icons[cat.slug] ?? '📘'}
                </div>
                <h2 className="mt-4 font-heading font-semibold text-slate-900">{cat.name}</h2>
                <p className="mt-1.5 text-sm leading-relaxed text-slate-500">{cat.description}</p>
              </Card>
            </Link>
          ))}
        </div>
      )}
    </div>
  )
}
