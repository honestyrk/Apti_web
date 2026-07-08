import { useEffect, useState, useCallback } from 'react'

/**
 * Countdown display only -- expires_at is the server-computed source of
 * truth (set by start_test_attempt) and every write is re-validated
 * server-side, so a manipulated client clock can't extend a test. This
 * hook just recomputes remaining time from expires_at on each tick and
 * resyncs on tab focus, since background tabs throttle setInterval and a
 * naive elapsed-tick counter would drift.
 */
export function useTestTimer(expiresAt, onExpire) {
  const computeRemaining = useCallback(() => {
    if (!expiresAt) return 0
    const ms = new Date(expiresAt).getTime() - Date.now()
    return Math.max(0, Math.round(ms / 1000))
  }, [expiresAt])

  const [remainingSeconds, setRemainingSeconds] = useState(computeRemaining)
  const [expired, setExpired] = useState(false)

  useEffect(() => {
    setRemainingSeconds(computeRemaining())
    setExpired(false)
  }, [computeRemaining])

  useEffect(() => {
    if (!expiresAt) return undefined

    const tick = () => {
      const remaining = computeRemaining()
      setRemainingSeconds(remaining)
      if (remaining <= 0) {
        setExpired((already) => {
          if (!already) onExpire?.()
          return true
        })
      }
    }

    const interval = setInterval(tick, 1000)
    const onVisibility = () => {
      if (document.visibilityState === 'visible') tick()
    }
    document.addEventListener('visibilitychange', onVisibility)
    window.addEventListener('focus', tick)

    return () => {
      clearInterval(interval)
      document.removeEventListener('visibilitychange', onVisibility)
      window.removeEventListener('focus', tick)
    }
  }, [expiresAt, computeRemaining, onExpire])

  const minutes = Math.floor(remainingSeconds / 60)
  const seconds = remainingSeconds % 60
  const label = `${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`

  return { remainingSeconds, label, expired }
}
