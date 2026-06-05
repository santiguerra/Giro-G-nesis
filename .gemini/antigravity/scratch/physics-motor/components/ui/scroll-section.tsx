'use client'

import { useRef } from 'react'
import { motion, useInView, Variants } from 'framer-motion'

/* ─── spring that feels mechanical-but-fluid ─────────────────────────── */
const SPRING = { type: 'spring' as const, stiffness: 90, damping: 20 }

/* ─── cylinder-face variants ─────────────────────────────────────────── */
const variants: Variants = {
  hidden: {
    opacity: 0,
    rotateX: -40,
    y: 60,
    scale: 0.96,
  },
  visible: {
    opacity: 1,
    rotateX: 0,
    y: 0,
    scale: 1,
    transition: { ...SPRING, opacity: { duration: 0.4 } },
  },
  exit: {
    opacity: 0,
    rotateX: 40,
    y: -40,
    scale: 0.96,
    transition: { ...SPRING, opacity: { duration: 0.3 } },
  },
}

type Props = {
  children: React.ReactNode
  className?: string
  /** delay in seconds before animation fires */
  delay?: number
}

export function ScrollSection({ children, className = '', delay = 0 }: Props) {
  const ref = useRef<HTMLDivElement>(null)

  /* fire once when ≥ 15 % of the section enters the viewport */
  const inView = useInView(ref, { once: false, amount: 0.15 })

  return (
    /* perspective wrapper — each section lives in its own 3-D context */
    <div style={{ perspective: '1200px' }} className={className}>
      <motion.div
        ref={ref}
        variants={variants}
        initial="hidden"
        animate={inView ? 'visible' : 'hidden'}
        custom={delay}
        style={{ transformOrigin: 'center bottom', willChange: 'transform, opacity' }}
        transition={{ ...SPRING, delay }}
      >
        {children}
      </motion.div>
    </div>
  )
}
