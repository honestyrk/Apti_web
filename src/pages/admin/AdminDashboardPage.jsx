import { Link } from 'react-router-dom'
import Card from '../../components/ui/Card'

export default function AdminDashboardPage() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-10 sm:px-6">
      <h1 className="text-2xl font-bold text-slate-900 dark:text-white">Admin panel</h1>
      <p className="mt-1 text-slate-500 dark:text-slate-400">Manage the question bank, topic tree, and view user activity.</p>

      <div className="mt-8 grid gap-5 sm:grid-cols-2">
        <Link to="/admin/users">
          <Card hover className="p-6">
            <h2 className="font-semibold text-slate-900 dark:text-white">Users</h2>
            <p className="mt-1 text-sm text-slate-500 dark:text-slate-400">See every user's questions attempted, accuracy, practice sessions, and tests taken.</p>
          </Card>
        </Link>
        <Link to="/admin/questions">
          <Card hover className="p-6">
            <h2 className="font-semibold text-slate-900 dark:text-white">Questions</h2>
            <p className="mt-1 text-sm text-slate-500 dark:text-slate-400">Add, edit, or deactivate MCQs.</p>
          </Card>
        </Link>
        <Link to="/admin/topics">
          <Card hover className="p-6">
            <h2 className="font-semibold text-slate-900 dark:text-white">Topics</h2>
            <p className="mt-1 text-sm text-slate-500 dark:text-slate-400">Manage categories, branches, and topics.</p>
          </Card>
        </Link>
      </div>
    </div>
  )
}
