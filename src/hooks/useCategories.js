import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabaseClient'

export function useCategories() {
  const [categories, setCategories] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    let mounted = true
    setLoading(true)
    supabase
      .from('categories')
      .select('*')
      .order('display_order')
      .then(({ data, error }) => {
        if (!mounted) return
        if (error) setError(error)
        else setCategories(data)
        setLoading(false)
      })
    return () => {
      mounted = false
    }
  }, [])

  return { categories, loading, error }
}

export function useCategoryBySlug(slug) {
  const [category, setCategory] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    if (!slug) {
      setCategory(null)
      setLoading(false)
      return undefined
    }
    let mounted = true
    setLoading(true)
    supabase
      .from('categories')
      .select('*')
      .eq('slug', slug)
      .single()
      .then(({ data, error }) => {
        if (!mounted) return
        if (error) setError(error)
        else setCategory(data)
        setLoading(false)
      })
    return () => {
      mounted = false
    }
  }, [slug])

  return { category, loading, error }
}
