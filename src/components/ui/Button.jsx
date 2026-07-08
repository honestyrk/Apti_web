import { forwardRef } from 'react'
import Spinner from './Spinner'

const variants = {
  primary:
    'bg-brand-700 text-white shadow-sm hover:bg-brand-800 hover:shadow-md focus-visible:outline-brand-700 active:bg-brand-900',
  accent:
    'bg-accent-500 text-white shadow-sm hover:bg-accent-600 hover:shadow-md focus-visible:outline-accent-500 active:bg-accent-700',
  outline:
    'border border-slate-200 text-slate-700 bg-white hover:border-slate-300 hover:bg-slate-50 focus-visible:outline-brand-700',
  ghost: 'text-slate-600 hover:bg-slate-100 focus-visible:outline-brand-700',
  danger:
    'bg-red-600 text-white shadow-sm hover:bg-red-700 hover:shadow-md focus-visible:outline-red-600',
}

const sizes = {
  sm: 'px-3.5 py-1.5 text-sm',
  md: 'px-4.5 py-2.5 text-sm',
  lg: 'px-6 py-3 text-base',
}

const Button = forwardRef(function Button(
  { variant = 'primary', size = 'md', loading = false, disabled, className = '', children, ...props },
  ref
) {
  return (
    <button
      ref={ref}
      disabled={disabled || loading}
      className={`inline-flex items-center justify-center gap-2 rounded-lg font-semibold transition-all duration-150 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 disabled:cursor-not-allowed disabled:opacity-50 disabled:shadow-none ${variants[variant]} ${sizes[size]} ${className}`}
      {...props}
    >
      {loading && <Spinner size="sm" className="border-white/40 border-t-white" />}
      {children}
    </button>
  )
})

export default Button
