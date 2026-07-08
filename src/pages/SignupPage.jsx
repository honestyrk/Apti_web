import { useState } from 'react'
import { Link, Navigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import { supabase } from '../lib/supabaseClient'
import Button from '../components/ui/Button'
import Card from '../components/ui/Card'

const inputClass =
  'w-full rounded-lg border border-slate-200 px-3.5 py-2.5 text-sm shadow-sm transition-colors focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20 dark:border-slate-700 dark:bg-slate-800 dark:text-white dark:placeholder-slate-500'

export default function SignupPage() {
  const { user, signUp } = useAuth()
  const [fullName, setFullName] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)
  const [submittedEmail, setSubmittedEmail] = useState('')
  const [resending, setResending] = useState(false)
  const [resendMessage, setResendMessage] = useState('')

  if (user) return <Navigate to="/dashboard" replace />

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    if (password.length < 6) {
      setError('Password must be at least 6 characters.')
      return
    }
    setLoading(true)
    const { error } = await signUp(email, password, fullName)
    setLoading(false)
    if (error) {
      setError(error.message)
      return
    }
    setSubmittedEmail(email)
  }

  const handleResend = async () => {
    setResending(true)
    setResendMessage('')
    const { error } = await supabase.auth.resend({ type: 'signup', email: submittedEmail })
    setResending(false)
    setResendMessage(error ? error.message : 'Confirmation email resent.')
  }

  if (submittedEmail) {
    return (
      <div className="mx-auto flex min-h-[70vh] max-w-md flex-col justify-center px-4 py-12">
        <Card className="p-8 text-center">
          <div className="mx-auto flex h-14 w-14 items-center justify-center rounded-full bg-accent-100 text-2xl dark:bg-accent-900/40">
            ✉️
          </div>
          <h1 className="mt-5 font-heading text-xl font-bold text-slate-900 dark:text-white">Check your inbox</h1>
          <p className="mt-2 text-sm leading-relaxed text-slate-500 dark:text-slate-400">
            We've sent a confirmation link to <span className="font-medium text-slate-700 dark:text-slate-200">{submittedEmail}</span>.
            Click the link to verify your account, then come back and log in.
          </p>

          {resendMessage && <p className="mt-4 text-sm text-slate-600 dark:text-slate-300">{resendMessage}</p>}

          <div className="mt-6 flex flex-col gap-3">
            <Button variant="outline" loading={resending} onClick={handleResend}>
              Resend confirmation email
            </Button>
            <Link to="/login">
              <Button className="w-full">Go to login</Button>
            </Link>
          </div>
        </Card>
      </div>
    )
  }

  return (
    <div className="mx-auto flex min-h-[70vh] max-w-md flex-col justify-center px-4 py-12">
      <Card className="p-8">
        <span className="flex h-11 w-11 items-center justify-center rounded-xl bg-linear-to-br from-brand-600 to-brand-800 font-heading text-lg font-bold text-white">
          P
        </span>
        <h1 className="mt-5 font-heading text-2xl font-bold text-slate-900 dark:text-white">Create your account</h1>
        <p className="mt-1 text-sm text-slate-500 dark:text-slate-400">Start practicing for your placement tests.</p>

        <form className="mt-6 space-y-4" onSubmit={handleSubmit}>
          <div>
            <label htmlFor="fullName" className="mb-1.5 block text-sm font-medium text-slate-700 dark:text-slate-300">Full name</label>
            <input
              id="fullName"
              type="text"
              required
              value={fullName}
              onChange={(e) => setFullName(e.target.value)}
              className={inputClass}
              placeholder="Jane Doe"
            />
          </div>
          <div>
            <label htmlFor="email" className="mb-1.5 block text-sm font-medium text-slate-700 dark:text-slate-300">Email</label>
            <input
              id="email"
              type="email"
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className={inputClass}
              placeholder="you@example.com"
            />
          </div>
          <div>
            <label htmlFor="password" className="mb-1.5 block text-sm font-medium text-slate-700 dark:text-slate-300">Password</label>
            <input
              id="password"
              type="password"
              required
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className={inputClass}
              placeholder="At least 6 characters"
            />
          </div>

          {error && <p className="rounded-lg bg-red-50 px-3.5 py-2.5 text-sm text-red-700 dark:bg-red-950/40 dark:text-red-300">{error}</p>}

          <Button type="submit" className="w-full" size="lg" loading={loading}>Sign up</Button>
        </form>

        <p className="mt-6 text-center text-sm text-slate-500 dark:text-slate-400">
          Already have an account?{' '}
          <Link to="/login" className="font-medium text-brand-700 hover:underline dark:text-brand-300">Log in</Link>
        </p>
      </Card>
    </div>
  )
}
