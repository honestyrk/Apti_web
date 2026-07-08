import { useState } from 'react'
import { useAuth } from '../context/AuthContext'
import { supabase } from '../lib/supabaseClient'
import Button from '../components/ui/Button'
import Card from '../components/ui/Card'
import Badge from '../components/ui/Badge'

export default function ProfilePage() {
  const { user, profile, refreshProfile, isAdmin } = useAuth()
  const [fullName, setFullName] = useState(profile?.full_name ?? '')
  const [saving, setSaving] = useState(false)
  const [message, setMessage] = useState('')

  const handleSave = async (e) => {
    e.preventDefault()
    setSaving(true)
    setMessage('')
    const { error } = await supabase.from('profiles').update({ full_name: fullName }).eq('id', user.id)
    setSaving(false)
    if (error) {
      setMessage(error.message)
      return
    }
    await refreshProfile()
    setMessage('Profile updated.')
  }

  return (
    <div className="mx-auto max-w-xl px-4 py-10 sm:px-6">
      <h1 className="text-2xl font-bold text-slate-900">Your profile</h1>

      <Card className="mt-6 p-6">
        <div className="mb-6 flex items-center gap-3">
          <div className="flex h-12 w-12 items-center justify-center rounded-full bg-brand-100 text-lg font-semibold text-brand-800">
            {(profile?.full_name || user.email)[0]?.toUpperCase()}
          </div>
          <div>
            <p className="font-medium text-slate-900">{profile?.full_name || 'Unnamed user'}</p>
            <p className="text-sm text-slate-500">{user.email}</p>
          </div>
          {isAdmin && <Badge variant="brand" className="ml-auto">Admin</Badge>}
        </div>

        <form onSubmit={handleSave} className="space-y-4">
          <div>
            <label htmlFor="fullName" className="mb-1 block text-sm font-medium text-slate-700">Full name</label>
            <input
              id="fullName"
              type="text"
              value={fullName}
              onChange={(e) => setFullName(e.target.value)}
              className="w-full rounded-lg border border-slate-300 px-3 py-2 text-sm focus:border-brand-500 focus:outline-none focus:ring-1 focus:ring-brand-500"
            />
          </div>
          <div>
            <label className="mb-1 block text-sm font-medium text-slate-700">Email</label>
            <input
              type="email"
              value={user.email}
              disabled
              className="w-full rounded-lg border border-slate-200 bg-slate-50 px-3 py-2 text-sm text-slate-500"
            />
          </div>

          {message && <p className="text-sm text-slate-600">{message}</p>}

          <Button type="submit" loading={saving}>Save changes</Button>
        </form>
      </Card>
    </div>
  )
}
