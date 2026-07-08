import { useState } from 'react'
import { Link, Navigate, useLocation, useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import { supabase } from '../lib/supabaseClient'
import Button from '../components/ui/Button'
import Card from '../components/ui/Card'

export default function LoginPage() {
  const { user, signIn } = useAuth()
  const navigate = useNavigate()
  const location = useLocation()
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [unconfirmed, setUnconfirmed] = useState(false)
  const [loading, setLoading] = useState(false)
  const [resending, setResending] = useState(false)
  const [resendMessage, setResendMessage] = useState('')

  if (user) {
    const redirectTo = location.state?.from?.pathname ?? '/dashboard'
    return <Navigate to={redirectTo} replace />
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    setUnconfirmed(false)
    setResendMessage('')
    setLoading(true)
    const { error } = await signIn(email, password)
    setLoading(false)
    if (error) {
      if (/email.*not.*confirm/i.test(error.message)) {
        setUnconfirmed(true)
      } else {
        setError(error.message)
      }
      return
    }
    navigate(location.state?.from?.pathname ?? '/dashboard', { replace: true })
  }

  const handleResend = async () => {
    setResending(true)
    setResendMessage('')
    const { error } = await supabase.auth.resend({ type: 'signup', email })
    setResending(false)
    setResendMessage(error ? error.message : 'Confirmation email resent — check your inbox.')
  }

  return (
    <div className="mx-auto flex min-h-[70vh] max-w-md flex-col justify-center px-4 py-12">
      <Card className="p-8">
        <span className="flex h-11 w-11 items-center justify-center rounded-xl bg-linear-to-br from-brand-600 to-brand-800 font-heading text-lg font-bold text-white">
          P
        </span>
        <h1 className="mt-5 font-heading text-2xl font-bold text-slate-900">Welcome back</h1>
        <p className="mt-1 text-sm text-slate-500">Log in to continue your placement prep.</p>

        <form className="mt-6 space-y-4" onSubmit={handleSubmit}>
          <div>
            <label htmlFor="email" className="mb-1.5 block text-sm font-medium text-slate-700">Email</label>
            <input
              id="email"
              type="email"
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full rounded-lg border border-slate-200 px-3.5 py-2.5 text-sm shadow-sm transition-colors focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20"
              placeholder="you@example.com"
            />
          </div>
          <div>
            <label htmlFor="password" className="mb-1.5 block text-sm font-medium text-slate-700">Password</label>
            <input
              id="password"
              type="password"
              required
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full rounded-lg border border-slate-200 px-3.5 py-2.5 text-sm shadow-sm transition-colors focus:border-brand-500 focus:outline-none focus:ring-2 focus:ring-brand-500/20"
              placeholder="••••••••"
            />
          </div>

          {error && <p className="rounded-lg bg-red-50 px-3.5 py-2.5 text-sm text-red-700">{error}</p>}

          {unconfirmed && (
            <div className="rounded-lg bg-amber-50 px-3.5 py-2.5 text-sm text-amber-800">
              <p>Your email hasn't been confirmed yet. Check your inbox for the confirmation link.</p>
              <button
                type="button"
                onClick={handleResend}
                disabled={resending}
                className="mt-2 font-medium text-amber-900 underline underline-offset-2 disabled:opacity-60"
              >
                {resending ? 'Resending…' : 'Resend confirmation email'}
              </button>
              {resendMessage && <p className="mt-1 text-amber-700">{resendMessage}</p>}
            </div>
          )}

          <Button type="submit" className="w-full" size="lg" loading={loading}>Log in</Button>
        </form>

        <p className="mt-6 text-center text-sm text-slate-500">
          Don't have an account?{' '}
          <Link to="/signup" className="font-medium text-brand-700 hover:underline">Sign up</Link>
        </p>
      </Card>
    </div>
  )
}
