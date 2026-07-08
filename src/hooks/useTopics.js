import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabaseClient'

export function useBranches(categoryId, reloadKey = 0) {
  const [branches, setBranches] = useState([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!categoryId) {
      setBranches([])
      setLoading(false)
      return undefined
    }
    let mounted = true
    setLoading(true)
    supabase
      .from('branches')
      .select('*')
      .eq('category_id', categoryId)
      .order('display_order')
      .then(({ data }) => {
        if (!mounted) return
        setBranches(data ?? [])
        setLoading(false)
      })
    return () => {
      mounted = false
    }
  }, [categoryId, reloadKey])

  return { branches, loading }
}

export function useTopics({ categoryId, branchId, noBranchOnly = false, reloadKey = 0 }) {
  const [topics, setTopics] = useState([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!categoryId) {
      setTopics([])
      setLoading(false)
      return undefined
    }
    let mounted = true
    setLoading(true)
    let query = supabase.from('topics').select('*').eq('category_id', categoryId)
    if (branchId) query = query.eq('branch_id', branchId)
    else if (noBranchOnly) query = query.is('branch_id', null)
    query.order('display_order').then(({ data }) => {
      if (!mounted) return
      setTopics(data ?? [])
      setLoading(false)
    })
    return () => {
      mounted = false
    }
  }, [categoryId, branchId, noBranchOnly, reloadKey])

  return { topics, loading }
}

export function useTopic(topicId) {
  const [topic, setTopic] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!topicId) {
      setTopic(null)
      setLoading(false)
      return undefined
    }
    let mounted = true
    setLoading(true)
    supabase
      .from('topics')
      .select('*, categories(name, slug, has_branches), branches(name, slug)')
      .eq('id', topicId)
      .single()
      .then(({ data }) => {
        if (!mounted) return
        setTopic(data ?? null)
        setLoading(false)
      })
    return () => {
      mounted = false
    }
  }, [topicId])

  return { topic, loading }
}
