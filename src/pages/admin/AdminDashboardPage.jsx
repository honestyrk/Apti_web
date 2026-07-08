import { Link } from 'react-router-dom'
import Card from '../../components/ui/Card'

export default function AdminDashboardPage() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-10 sm:px-6">
      <h1 className="text-2xl font-bold text-slate-900">Admin panel</h1>
      <p className="mt-1 text-slate-500">Manage the question bank and topic tree.</p>

      <div className="mt-8 grid gap-5 sm:grid-cols-2">
        <Link to="/admin/questions">
          <Card className="p-6 transition-shadow hover:shadow-md">
            <h2 className="font-semibold text-slate-900">Questions</h2>
            <p className="mt-1 text-sm text-slate-500">Add, edit, or deactivate MCQs.</p>
          </Card>
        </Link>
        <Link to="/admin/topics">
          <Card className="p-6 transition-shadow hover:shadow-md">
            <h2 className="font-semibold text-slate-900">Topics</h2>
            <p className="mt-1 text-sm text-slate-500">Manage categories, branches, and topics.</p>
          </Card>
        </Link>
      </div>
    </div>
  )
}
