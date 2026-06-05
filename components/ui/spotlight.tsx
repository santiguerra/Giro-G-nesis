'use client'

import React, { useRef, useState } from 'react'
import { cn } from '@/lib/utils'

type SpotlightProps = {
  className?: string
  fill?: string
}

export const Spotlight = ({ className, fill = 'white' }: SpotlightProps) => {
  const divRef = useRef<HTMLDivElement>(null)
  const [position, setPosition] = useState({ x: 0, y: 0 })
  const [opacity, setOpacity] = useState(0)

  const handleMouseMove = (e: React.MouseEvent<HTMLDivElement>) => {
    if (!divRef.current) return
    const rect = divRef.current.getBoundingClientRect()
    setPosition({ x: e.clientX - rect.left, y: e.clientY - rect.top })
  }

  const handleMouseEnter = () => setOpacity(1)
  const handleMouseLeave = () => setOpacity(0)

  return (
    <div
      ref={divRef}
      onMouseMove={handleMouseMove}
      onMouseEnter={handleMouseEnter}
      onMouseLeave={handleMouseLeave}
      className="absolute inset-0 overflow-hidden pointer-events-auto z-0"
    >
      {/* Radial gradient spotlight that follows the mouse */}
      <div
        className="absolute pointer-events-none transition-opacity duration-300"
        style={{
          opacity,
          background: `radial-gradient(600px circle at ${position.x}px ${position.y}px, ${fill === 'white' ? 'rgba(255,255,255,0.08)' : 'rgba(59,130,246,0.12)'} 0%, transparent 70%)`,
          inset: 0,
        }}
      />
      {/* Static ambient spotlight (always visible) */}
      <svg
        className={cn(
          'animate-spotlight pointer-events-none absolute z-[1] h-[169%] w-[138%] lg:w-[84%] opacity-0',
          className
        )}
        xmlns="http://www.w3.org/2000/svg"
        viewBox="0 0 3787 2842"
        fill="none"
      >
        <g filter="url(#spotlight-filter)">
          <ellipse
            cx="1924.71"
            cy="273.501"
            rx="1924.71"
            ry="273.501"
            transform="matrix(-0.822377 -0.568943 -0.568943 0.822377 3631.88 2291.09)"
            fill={fill}
            fillOpacity="0.15"
          />
        </g>
        <defs>
          <filter
            id="spotlight-filter"
            x="0.860352"
            y="0.838989"
            width="3785.16"
            height="2840.26"
            filterUnits="userSpaceOnUse"
            colorInterpolationFilters="sRGB"
          >
            <feFlood floodOpacity="0" result="BackgroundImageFix" />
            <feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape" />
            <feGaussianBlur stdDeviation="151" result="effect1_foregroundBlur_1065_8" />
          </filter>
        </defs>
      </svg>
    </div>
  )
}
