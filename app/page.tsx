'use client'

import { useRef } from 'react'
import {
  motion,
  useScroll,
  useTransform,
  useSpring,
} from 'framer-motion'

import Image from 'next/image'

import { SplineScene } from '@/components/ui/splite'
import { Spotlight } from '@/components/ui/spotlight'
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card'
import { ScrollSection } from '@/components/ui/scroll-section'
import { asset, cn } from '@/lib/utils'
import {
  Construction,
  Zap,
  Magnet,
  Battery,
  GraduationCap,
  BookOpen,
  University,
  FlaskConical,
  Cpu,
  Lightbulb,
  History,
  Wrench,
  Flame,
  Puzzle,
} from 'lucide-react'

/* ─────────────────────────────────────────────────────────────────────────────
   DATA
───────────────────────────────────────────────────────────────────────────── */

type MediaItem = {
  src: string
  type: 'image' | 'video'
  caption?: string
}

const authors = [
  {
    name: 'Santiago Guerra Puertas',
    photo: '/media/Santiago.jpg',
    programa: 'Ingeniería de Sistemas y Computación',
    universidad: 'Universidad Tecnológica de Pereira',
    curso: 'Física 2',
  },
  {
    name: 'Daniel Felipe Riaño Hernández',
    photo: '/media/Daniel.jpeg',
    programa: 'Ingeniería de Sistemas y Computación',
    universidad: 'Universidad Tecnológica de Pereira',
    curso: 'Física 2',
  },
]

const estadoDelArte = [
  {
    year: '1820',
    title: 'Descubrimiento de Ørsted',
    description:
      'Hans Christian Ørsted observó que una aguja magnética se desviaba al acercarla a un conductor con corriente, demostrando por primera vez la relación entre electricidad y magnetismo.',
    icon: Lightbulb,
  },
  {
    year: '1821',
    title: 'Primera Rotación Electromagnética (Faraday)',
    description:
      'Michael Faraday construyó el primer dispositivo capaz de convertir energía eléctrica en movimiento mecánico continuo, sentando las bases conceptuales del motor eléctrico moderno.',
    icon: Zap,
  },
  {
    year: '1832',
    title: 'Motor DC de Pixii',
    description:
      'Hippolyte Pixii desarrolló el primer generador con conmutador, permitiendo producir corriente continua unidireccional, elemento fundamental en los motores DC posteriores.',
    icon: Cpu,
  },
  {
    year: '1888',
    title: 'Motor de Inducción de Tesla',
    description:
      'Nikola Tesla patentó el motor de corriente alterna de inducción, revolucionando la industria eléctrica y estableciendo el estándar de transmisión de energía a larga distancia.',
    icon: FlaskConical,
  },
  {
    year: 'Hoy',
    title: 'Motores Caseros como Herramienta Pedagógica',
    description:
      'La construcción artesanal de motores DC sencillos sigue siendo una de las formas más efectivas de enseñar electromagnetismo aplicado, permitiendo a los estudiantes experimentar directamente la Fuerza de Lorentz y el principio de conmutación.',
    icon: GraduationCap,
  },
]

const principios = [
  {
    icon: Magnet,
    title: 'Fuerza de Lorentz',
    body: 'Cuando la corriente eléctrica fluye por la bobina de cobre en presencia del campo magnético del imán, experimenta una fuerza perpendicular que hace girar la estructura. Esta fuerza se expresa como F = qv × B.',
  },
  {
    icon: Zap,
    title: 'Electromagnetismo',
    body: 'Al lijar solo la mitad del esmalte en uno de los ejes, creamos un conmutador rudimentario. Esto rompe el circuito cada media vuelta, permitiendo que la inercia mantenga el giro en una sola dirección.',
  },
  {
    icon: Battery,
    title: 'Torque y Dinámica',
    body: 'Las fuerzas magnéticas crean un torque sobre la espira. La eficiencia depende del número de vueltas de la bobina, la corriente de la fuente y la fuerza del imán de neodimio: τ = NIAB sin θ.',
  },
]

const bitacoraIntro = {
  title: 'Nuestro Motor Eléctrico Casero (y la odisea para hacerlo girar)',
  plan:
    'El Plan: Armar un motorcito casero de corriente continua siguiendo un tutorial de YouTube, aplicar lo que vimos en clase y no rendirnos en el intento.',
  media: [
    {
      src: 'Together.jpeg',
      type: 'image' as const,
      caption: 'El equipo en plena sesión de experimentación',
    },
  ],
}

const bitacoraSections = [
  {
    icon: Wrench,
    title: '1. ¿Qué usamos? (Los Materiales)',
    items: [
      {
        body: 'Pila de 9V y cables comunes.',
      },
      {
        body: 'Clips tamaño "jumbo": Los modificamos para que sirvieran de "cama" o soporte para la bobina.',
      },
      {
        body: 'Alambre esmaltado: Compramos calibre 20 y 24 por si las dudas.',
      },
      {
        body: 'El Imán: ¡Costó la vida conseguirlo! Terminamos yendo al centro y un viejito nos vendió uno que sacó de un estéreo de los viejos. Una verdadera joya.',
        media: [
          {
            src: 'Bulding.jpeg',
            type: 'image' as const,
            caption: 'Montaje inicial con pila, clips y bobina',
          },
        ],
      },
    ],
  },
  {
    icon: Construction,
    title: '2. El Proceso (Entre el caos y el éxito)',
    items: [
      {
        title: 'Fase 1: El problema del grosor',
        body: 'Armamos la base con los clips y la pila. Hicimos nuestra primera bobina con el alambre calibre 20, la pusimos en los clips y... nada. Cero movimiento. Pensamos que era muy grueso y pesado, así que armamos otra con el calibre 24. ¿El resultado? Tampoco se movió.',
        media: [
          {
            src: 'FailAtemp.mp4',
            type: 'video' as const,
            caption: 'Primer intento: cero movimiento',
          },
        ],
      },
      {
        title: 'Fase 2: La lija asesina y la bobina epiléptica',
        body: 'Después de revisar bien, nos dimos cuenta de nuestro error de novatos: no sabíamos pelar el alambre esmaltado, así que obvio no pasaba corriente. Nos pusimos a lijarlo. Casi perdimos un dedo en el proceso, pero al menos la cosa dio señales de vida. La bobina empezó a tambalear rarísimo, como si tuviera un ataque de epilepsia. A veces hasta se quedaba flotando, totalmente congelada por el imán.',
        media: [
          {
            src: 'PorloMenosSeMueve.mp4',
            type: 'video' as const,
            caption: 'Por lo menos se mueve… un poco',
          },
          {
            src: 'SeQuedoTieso.mp4',
            type: 'video' as const,
            caption: 'Se quedó tieso, congelado por el imán',
          },
        ],
      },
      {
        title: 'Fase 3: La culpa es de los clips',
        body: 'Como seguía sin girar bien, le echamos la culpa a los clips. Los teníamos en forma de gancho abierto, así que los cerramos para dejar solo un huequito donde encajaran las puntas de la bobina. Spoiler: no surtió ningún efecto.',
        media: [
          {
            src: 'Work.mp4',
            type: 'video' as const,
            caption: 'Ajustando los clips sin mucho éxito',
          },
        ],
      },
      {
        title: 'Fase 4: Fuego, la vieja confiable',
        body: 'Vimos por ahí que era mejor quemar el esmalte con fuego y después lijarlo suavemente. Lo intentamos, lo pusimos en los clips y ¡listo! Funcionó perfecto. Grito de victoria y experimento "completado".',
        media: [
          {
            src: 'FirstTImeWork.mp4',
            type: 'video' as const,
            caption: '¡La primera vez que giró de verdad!',
          },
        ],
      },
    ],
  },
  {
    icon: Puzzle,
    title: '3. Jugando a ser ingenieros (O por qué no arreglar lo que no está roto)',
    items: [
      {
        title: 'El intento de "Mejorar" el conmutador',
        body: 'Como ya servía, nos pusimos a jugar tratando de aplicar los conceptos de la clase. Sobra decir que casi nos quedamos sin proyecto: quisimos optimizar la parte del alambre pelado que hace contacto (el conmutador). Al "mejorarla", el motor dejó de servir. Después de molestar un buen rato, logramos que reviviera haciendo un Frankenstein con los clips: dejamos uno en forma de gancho y el otro en forma de hueco. Así le gustó.',
        media: [
          {
            src: 'Working.mp4',
            type: 'video' as const,
            caption: 'El motor funcionando después del arreglo Frankenstein',
          },
        ],
      },
      {
        title: 'Buscando el "Punto Máximo"',
        body: 'No conformes con que ya girara, queríamos más potencia. Subimos la altura de los clips para "llegar al punto máximo del campo magnético" del imán. ¡Oh sorpresa!, se volvió a morir. Después de pelear otro rato con los clips, logramos que volviera a funcionar y ahí sí, quietecito, lo dejamos en paz y dimos por hecho el experimento. ¡Misión cumplida!',
        media: [
          {
            src: 'Working.mp4',
            type: 'video' as const,
            caption: 'Misión cumplida: el motor girando estable',
          },
        ],
      },
    ],
  },
]

function BitacoraMedia({ items }: { items: MediaItem[] }) {
  if (!items.length) return null

  return (
    <div
      className={cn(
        'mt-4 grid gap-4',
        items.length > 1 ? 'md:grid-cols-2' : 'grid-cols-1'
      )}
    >
      {items.map((item, index) => (
        <figure
          key={`${item.src}-${index}`}
          className="rounded-xl overflow-hidden border border-slate-700/80 bg-slate-950/50"
        >
          {item.type === 'video' ? (
            <video
              src={asset(`/media/${item.src}`)}
              controls
              playsInline
              preload="none"
              loop={false}
              className="w-full aspect-video object-contain bg-black"
            />
          ) : (
            <Image
              src={asset(`/media/${item.src}`)}
              alt={item.caption ?? ''}
              width={800}
              height={500}
              unoptimized
              className="w-full object-cover"
            />
          )}
          {item.caption && (
            <figcaption className="text-xs text-slate-500 px-3 py-2 text-center border-t border-slate-800">
              {item.caption}
            </figcaption>
          )}
        </figure>
      ))}
    </div>
  )
}

/* ─────────────────────────────────────────────────────────────────────────────
   PAGE
───────────────────────────────────────────────────────────────────────────── */

export default function PhysicsProjectPage() {
  /* ── Scroll progress for the entire page ─────────────────────────────── */
  const pageRef = useRef<HTMLElement>(null)
  const { scrollYProgress } = useScroll({ target: pageRef, offset: ['start start', 'end end'] })

  /* Smooth spring on raw scroll progress */
  const smoothProgress = useSpring(scrollYProgress, { stiffness: 60, damping: 20 })

  /* Spline panel: rotates -25 → +25 deg on Y as you scroll the page */
  const splineRotateY = useTransform(smoothProgress, [0, 1], [-25, 25])

  /* Hero card: subtle upward parallax as user starts scrolling */
  const heroY = useTransform(smoothProgress, [0, 0.2], [0, -40])

  return (
    <main
      ref={pageRef}
      className="min-h-screen bg-slate-950 text-slate-50 selection:bg-blue-500/30 pb-24 overflow-x-hidden"
    >
      {/* ── 1. HERO (not inside ScrollSection — it's the anchor) ──────────── */}
      <motion.div
        style={{ y: heroY }}
        className="p-4 md:p-8 max-w-7xl mx-auto mt-4 md:mt-12"
      >
        <Card className="w-full h-[600px] bg-black/[0.96] relative overflow-hidden border-slate-800">
          <Spotlight className="-top-40 left-0 md:left-60 md:-top-20" fill="white" />

          <div className="flex flex-col md:flex-row h-full">
            {/* Left — text */}
            <div className="flex-1 p-8 md:p-12 relative z-10 flex flex-col justify-center">
              <div className="inline-flex w-fit items-center rounded-full border border-blue-500/30 bg-blue-500/10 px-3 py-1 text-sm font-medium text-blue-300 mb-6">
                Física II — Proyecto Final
              </div>
              <h1 className="text-4xl md:text-6xl font-bold bg-clip-text text-transparent bg-gradient-to-b from-neutral-50 to-neutral-400 mb-6 leading-tight">
                Motor Electromagnético
              </h1>
              <p className="mt-4 text-neutral-300 max-w-lg text-lg leading-relaxed">
                Una exploración de la dinámica y el electromagnetismo a través de la construcción
                de un motor DC casero de alto torque, aplicando los principios de la Fuerza de
                Lorentz y la inducción electromagnética.
              </p>
            </div>

            {/* Right — Spline 3D with scroll-linked Y rotation */}
            <div className="flex-1 relative hidden md:block">
              <motion.div
                style={{ rotateY: splineRotateY, transformOrigin: 'center center' }}
                className="w-full h-full"
              >
                <SplineScene
                  scene="https://prod.spline.design/kZDDjO5HuC9GJUM2/scene.splinecode"
                  className="w-full h-full"
                />
              </motion.div>
            </div>
          </div>
        </Card>
      </motion.div>

      {/* ── 2. AUTORES ──────────────────────────────────────────────────────── */}
      <ScrollSection className="py-20 px-4 max-w-7xl mx-auto">
        <h2 className="text-3xl font-bold text-slate-100 mb-4 text-center flex items-center justify-center gap-3">
          <GraduationCap className="text-blue-500" /> Equipo de Trabajo
        </h2>
        <p className="text-slate-400 text-center mb-12 max-w-xl mx-auto">
          Estudiantes de pregrado del programa de Ingeniería de Sistemas y Computación,
          Universidad Tecnológica de Pereira.
        </p>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
          {authors.map((author, i) => (
            <motion.div
              key={author.name}
              initial={{ opacity: 0, x: i === 0 ? -30 : 30 }}
              whileInView={{ opacity: 1, x: 0 }}
              transition={{ type: 'spring', stiffness: 80, damping: 18, delay: i * 0.1 }}
              viewport={{ once: false, amount: 0.3 }}
            >
              <Card className="bg-slate-900/50 border-slate-800 backdrop-blur-sm hover:border-blue-500/40 transition-colors duration-300 h-full">
                <CardContent className="p-8 md:p-10">
                  <div className="flex flex-col sm:flex-row items-center sm:items-start gap-8">
                    <div className="shrink-0 w-36 h-36 md:w-44 md:h-44 rounded-3xl overflow-hidden border-2 border-slate-700 bg-slate-800 shadow-lg shadow-blue-500/10">
                      <Image
                        src={asset(author.photo)}
                        alt={author.name}
                        width={176}
                        height={176}
                        unoptimized
                        className="w-full h-full object-cover"
                      />
                    </div>
                    <div className="space-y-4 min-w-0 text-center sm:text-left flex-1">
                      <h3 className="text-2xl md:text-3xl font-bold text-slate-100 leading-snug">
                        {author.name}
                      </h3>
                      <div className="flex items-center justify-center sm:justify-start gap-3 text-slate-400 text-base">
                        <Cpu className="w-5 h-5 text-blue-400 shrink-0" />
                        <span>{author.programa}</span>
                      </div>
                      <div className="flex items-center justify-center sm:justify-start gap-3 text-slate-400 text-base">
                        <University className="w-5 h-5 text-blue-400 shrink-0" />
                        <span>{author.universidad}</span>
                      </div>
                      <div className="flex items-center justify-center sm:justify-start gap-3 text-slate-400 text-base">
                        <BookOpen className="w-5 h-5 text-blue-400 shrink-0" />
                        <span>{author.curso}</span>
                      </div>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>
      </ScrollSection>

      {/* ── 3. DESCRIPCIÓN DEL TEMA ─────────────────────────────────────────── */}
      <ScrollSection className="py-20 px-4 max-w-4xl mx-auto border-t border-slate-800/50">
        <h2 className="text-3xl font-bold text-slate-100 mb-12 text-center flex items-center justify-center gap-3">
          <FlaskConical className="text-blue-500" /> Descripción del Tema
        </h2>

        <div className="space-y-6 text-slate-400 leading-relaxed text-base md:text-lg">
          {[
            <>
              Un motor eléctrico de corriente continua (DC) es un dispositivo que convierte energía
              eléctrica en energía mecánica rotacional mediante la interacción entre un campo magnético
              y una corriente eléctrica. En su versión casera más sencilla —conocida como motor
              homopolar o motor de bobina simple—, este principio se materializa con elementos
              cotidianos: alambre de cobre esmaltado, clips metálicos, un imán de neodimio y una
              pila alcalina. A pesar de su aparente simplicidad constructiva, el dispositivo encapsula
              de forma elegante algunos de los fenómenos electromagnéticos más fundamentales descritos
              por las ecuaciones de Maxwell.
            </>,
            <>
              La relevancia académica de construir un motor DC desde cero radica en la posibilidad
              de observar y cuantificar directamente la{' '}
              <span className="text-slate-200 font-medium">Fuerza de Lorentz</span> (
              <span className="font-mono text-blue-300 text-sm">F = qv × B</span>), el fenómeno de
              conmutación electromagnética y la conversión de energía. A diferencia de las
              simulaciones por computadora, el montaje físico expone al estudiante a variables
              reales —fricción mecánica, resistencia del conductor, campo magnético no uniforme—
              que enriquecen la comprensión teórica y desarrollan habilidades experimentales de
              análisis y resolución de problemas.
            </>,
            <>
              Los objetivos centrales de este proyecto son: (1){' '}
              <span className="text-slate-200">diseñar y construir</span> un motor DC funcional de
              bajo costo a partir de materiales accesibles; (2){' '}
              <span className="text-slate-200">identificar y describir</span> los principios físicos
              que gobiernan su funcionamiento —electromagnetismo, dinámica rotacional y conversión
              de energía—; y (3){' '}
              <span className="text-slate-200">documentar el proceso</span> de montaje, calibración y
              prueba de forma sistemática, vinculando cada decisión de diseño con el marco teórico
              correspondiente del curso de Física II.
            </>,
          ].map((para, i) => (
            <motion.p
              key={i}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              transition={{ type: 'spring', stiffness: 70, damping: 18, delay: i * 0.12 }}
              viewport={{ once: false, amount: 0.3 }}
            >
              {para}
            </motion.p>
          ))}
        </div>
      </ScrollSection>

      {/* ── 4. ESTADO DEL ARTE ──────────────────────────────────────────────── */}
      <ScrollSection className="py-20 px-4 max-w-5xl mx-auto border-t border-slate-800/50">
        <h2 className="text-3xl font-bold text-slate-100 mb-4 text-center flex items-center justify-center gap-3">
          <History className="text-blue-500" /> Estado del Arte
        </h2>
        <p className="text-slate-400 text-center mb-14 max-w-2xl mx-auto">
          Contexto histórico y evolución del motor eléctrico, desde los primeros experimentos
          electromagnéticos hasta su aplicación pedagógica contemporánea.
        </p>

        <div className="relative">
          <div className="absolute left-6 md:left-1/2 top-0 bottom-0 w-px bg-gradient-to-b from-transparent via-slate-700 to-transparent -translate-x-px" />

          <div className="space-y-10">
            {estadoDelArte.map((item, idx) => {
              const Icon = item.icon
              const isEven = idx % 2 === 0
              return (
                <motion.div
                  key={item.year}
                  initial={{ opacity: 0, x: isEven ? -40 : 40 }}
                  whileInView={{ opacity: 1, x: 0 }}
                  transition={{ type: 'spring', stiffness: 80, damping: 18, delay: idx * 0.07 }}
                  viewport={{ once: false, amount: 0.25 }}
                  className={`relative flex items-start gap-6 md:gap-0 ${
                    isEven ? 'md:flex-row' : 'md:flex-row-reverse'
                  }`}
                >
                  <div className="shrink-0 z-10 flex flex-col items-center md:absolute md:left-1/2 md:-translate-x-1/2">
                    <div className="w-12 h-12 rounded-full bg-slate-900 border border-blue-500/40 flex items-center justify-center shadow-lg shadow-blue-500/10">
                      <Icon className="w-5 h-5 text-blue-400" />
                    </div>
                    <span className="mt-2 text-xs font-mono text-blue-300 whitespace-nowrap">
                      {item.year}
                    </span>
                  </div>

                  <div
                    className={`ml-6 md:ml-0 md:w-[calc(50%-3.5rem)] ${
                      isEven ? 'md:mr-auto md:pr-4' : 'md:ml-auto md:pl-4'
                    }`}
                  >
                    <Card className="bg-slate-900/50 border-slate-800 hover:border-blue-500/40 transition-colors duration-300">
                      <CardContent className="p-5">
                        <h3 className="font-bold text-slate-100 text-base mb-2">{item.title}</h3>
                        <p className="text-slate-400 text-sm leading-relaxed">{item.description}</p>
                      </CardContent>
                    </Card>
                  </div>
                </motion.div>
              )
            })}
          </div>
        </div>
      </ScrollSection>

      {/* ── 5. PRINCIPIOS FÍSICOS ───────────────────────────────────────────── */}
      <ScrollSection className="py-20 px-4 max-w-7xl mx-auto border-t border-slate-800/50">
        <h2 className="text-3xl font-bold text-slate-100 mb-12 text-center flex items-center justify-center gap-3">
          <Zap className="text-blue-500" /> Principios Físicos Involucrados
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {principios.map((p, i) => {
            const Icon = p.icon
            return (
              <motion.div
                key={p.title}
                initial={{ opacity: 0, rotateY: -15, y: 30 }}
                whileInView={{ opacity: 1, rotateY: 0, y: 0 }}
                transition={{ type: 'spring', stiffness: 80, damping: 18, delay: i * 0.12 }}
                viewport={{ once: false, amount: 0.3 }}
                style={{ perspective: 800 }}
              >
                <Card className="bg-slate-900/50 border-slate-800 backdrop-blur-sm hover:border-blue-500/50 transition-colors duration-300 hover:shadow-lg hover:shadow-blue-500/10 h-full">
                  <CardHeader>
                    <Icon className="w-8 h-8 text-blue-400 mb-3" />
                    <CardTitle className="text-slate-100">{p.title}</CardTitle>
                  </CardHeader>
                  <CardContent className="text-slate-400">{p.body}</CardContent>
                </Card>
              </motion.div>
            )
          })}
        </div>
      </ScrollSection>

      {/* ── 6. BITÁCORA (sin ScrollSection — sección muy alta para animación 3D) ── */}
      <section className="py-20 px-4 max-w-4xl mx-auto border-t border-slate-800/50">
        <h2 className="text-3xl font-bold text-slate-100 mb-4 text-center flex items-center justify-center gap-3">
          <Flame className="text-blue-500" /> Bitácora de Proyecto
        </h2>
        <p className="text-slate-300 text-center text-lg font-medium mb-3 max-w-2xl mx-auto">
          {bitacoraIntro.title}
        </p>
        <p className="text-slate-400 text-center mb-10 max-w-2xl mx-auto leading-relaxed">
          {bitacoraIntro.plan}
        </p>

        <div className="mb-14 max-w-2xl mx-auto">
          <BitacoraMedia items={bitacoraIntro.media} />
        </div>

        <div className="space-y-14">
          {bitacoraSections.map((section) => {
            const SectionIcon = section.icon
            return (
              <div key={section.title}>
                <h3 className="text-2xl font-bold text-slate-100 mb-6 flex items-center gap-3">
                  <SectionIcon className="w-6 h-6 text-blue-400 shrink-0" />
                  {section.title}
                </h3>

                <div className="space-y-6">
                  {section.items.map((item, itemIdx) => (
                    <div
                      key={`${section.title}-${itemIdx}`}
                      className="p-6 rounded-xl border border-slate-800 bg-slate-900/50 hover:border-blue-500/30 transition-colors duration-300"
                    >
                      {'title' in item && item.title && (
                        <h4 className="font-semibold text-blue-300 text-base mb-2">
                          {item.title}
                        </h4>
                      )}
                      <p className="text-slate-400 text-sm leading-relaxed">{item.body}</p>
                      {'media' in item && item.media && (
                        <BitacoraMedia items={item.media} />
                      )}
                    </div>
                  ))}
                </div>
              </div>
            )
          })}
        </div>
      </section>

      {/* ── FOOTER ──────────────────────────────────────────────────────────── */}
      <motion.footer
        initial={{ opacity: 0 }}
        whileInView={{ opacity: 1 }}
        transition={{ duration: 0.8 }}
        viewport={{ once: true }}
        className="border-t border-slate-800/50 mt-4 py-10 px-4 text-center"
      >
        <p className="text-slate-500 text-sm">
          Universidad Tecnológica de Pereira · Ingeniería de Sistemas y Computación · Física II ·{' '}
          {new Date().getFullYear()}
        </p>
      </motion.footer>
    </main>
  )
}
