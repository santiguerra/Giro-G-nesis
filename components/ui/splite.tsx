'use client'

import dynamic from 'next/dynamic'
import { cn } from '@/lib/utils'

// Spline must be client-only — WebGL is not available in SSR
const Spline = dynamic(() => import('@splinetool/react-spline'), {
  ssr: false,
  loading: () => (
    <div className="w-full h-full flex items-center justify-center bg-black/40">
      <div className="w-16 h-16 rounded-full border-2 border-blue-500/30 border-t-blue-400 animate-spin" />
    </div>
  ),
})

type SplineSceneProps = {
  scene: string
  className?: string
}

export function SplineScene({ scene, className }: SplineSceneProps) {
  return (
    <div className={cn('w-full h-full', className)}>
      <Spline scene={scene} />
    </div>
  )
}
