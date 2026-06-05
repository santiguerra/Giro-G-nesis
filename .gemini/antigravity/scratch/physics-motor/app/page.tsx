'use client'

import { SplineScene } from "@/components/ui/splite"
import { Spotlight } from "@/components/ui/spotlight"
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card"
import {
  Construction,
  Zap,
  Magnet,
  Battery,
  User,
  GraduationCap,
  BookOpen,
  University,
  FlaskConical,
  Cpu,
  Lightbulb,
  History,
} from "lucide-react"

/* ─────────────────────────────────────────────────────────────────────────────
   DATA
───────────────────────────────────────────────────────────────────────────── */

const authors = [
  {
    name: "Santiago Guerra Puertas",
    programa: "Ingeniería de Sistemas y Computación",
    universidad: "Universidad Tecnológica de Pereira",
    curso: "Física 2",
  },
  {
    name: "Daniel Felipe Riaño Hernández",
    programa: "Ingeniería de Sistemas y Computación",
    universidad: "Universidad Tecnológica de Pereira",
    curso: "Física 2",
  },
]

const estadoDelArte = [
  {
    year: "1820",
    title: "Descubrimiento de Ørsted",
    description:
      "Hans Christian Ørsted observó que una aguja magnética se desviaba al acercarla a un conductor con corriente, demostrando por primera vez la relación entre electricidad y magnetismo.",
    icon: Lightbulb,
  },
  {
    year: "1821",
    title: "Primera Rotación Electromagnética (Faraday)",
    description:
      "Michael Faraday construyó el primer dispositivo capaz de convertir energía eléctrica en movimiento mecánico continuo, sentando las bases conceptuales del motor eléctrico moderno.",
    icon: Zap,
  },
  {
    year: "1832",
    title: "Motor DC de Pixii",
    description:
      "Hippolyte Pixii desarrolló el primer generador con conmutador, permitiendo producir corriente continua unidireccional, elemento fundamental en los motores DC posteriores.",
    icon: Cpu,
  },
  {
    year: "1888",
    title: "Motor de Inducción de Tesla",
    description:
      "Nikola Tesla patentó el motor de corriente alterna de inducción, revolucionando la industria eléctrica y estableciendo el estándar de transmisión de energía a larga distancia.",
    icon: FlaskConical,
  },
  {
    year: "Hoy",
    title: "Motores Caseros como Herramienta Pedagógica",
    description:
      "La construcción artesanal de motores DC sencillos sigue siendo una de las formas más efectivas de enseñar electromagnetismo aplicado, permitiendo a los estudiantes experimentar directamente la Fuerza de Lorentz y el principio de conmutación.",
    icon: GraduationCap,
  },
]

const principios = [
  {
    icon: Magnet,
    title: "Fuerza de Lorentz",
    body: "Cuando la corriente eléctrica fluye por la bobina de cobre en presencia del campo magnético del imán, experimenta una fuerza perpendicular que hace girar la estructura. Esta fuerza se expresa como F = qv × B.",
  },
  {
    icon: Zap,
    title: "Electromagnetismo",
    body: "Al lijar solo la mitad del esmalte en uno de los ejes, creamos un conmutador rudimentario. Esto rompe el circuito cada media vuelta, permitiendo que la inercia mantenga el giro en una sola dirección.",
  },
  {
    icon: Battery,
    title: "Torque y Dinámica",
    body: "Las fuerzas magnéticas crean un torque sobre la espira. La eficiencia depende del número de vueltas de la bobina, la corriente de la fuente y la fuerza del imán de neodimio: τ = NIAB sin θ.",
  },
]

const bitacora = [
  {
    step: 1,
    title: "Preparación de la Bobina",
    body: "Se enrolló alambre de cobre esmaltado firmemente. Se dejaron dos extremos rectos como ejes. Se lijó completamente el esmalte de un extremo, y solo la mitad del otro para crear el efecto conmutador.",
  },
  {
    step: 2,
    title: "Soportes y Base",
    body: "Se montaron dos clips conductores sobre la base para servir como soporte estructural y contactos eléctricos. Se aseguraron de estar nivelados para reducir la fricción mecánica al mínimo.",
  },
  {
    step: 3,
    title: "Integración del Imán",
    body: "Se colocó un imán circular permanentemente debajo de la bobina. Se ajustó la altura para maximizar el campo magnético sin obstruir la rotación física del cobre.",
  },
  {
    step: 4,
    title: "Prueba y Encendido",
    body: "Se conectaron los caimanes desde la fuente de poder a los clips. Con un ligero empuje manual para romper la inercia, se logró una rotación estable y continua de alto torque.",
  },
]

/* ─────────────────────────────────────────────────────────────────────────────
   PAGE
───────────────────────────────────────────────────────────────────────────── */

export default function PhysicsProjectPage() {
  return (
    <main className="min-h-screen bg-slate-950 text-slate-50 selection:bg-blue-500/30 pb-24">

      {/* ── 1. HERO ─────────────────────────────────────────────────────────── */}
      <div className="p-4 md:p-8 max-w-7xl mx-auto mt-4 md:mt-12">
        <Card className="w-full h-[600px] bg-black/[0.96] relative overflow-hidden border-slate-800">
          <Spotlight className="-top-40 left-0 md:left-60 md:-top-20" fill="white" />

          <div className="flex flex-col md:flex-row h-full">
            {/* Left */}
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

            {/* Right — Spline 3D */}
            <div className="flex-1 relative hidden md:block">
              <SplineScene
                scene="https://prod.spline.design/kZDDjO5HuC9GJUM2/scene.splinecode"
                className="w-full h-full"
              />
            </div>
          </div>
        </Card>
      </div>

      {/* ── 2. AUTORES ──────────────────────────────────────────────────────── */}
      <section className="py-20 px-4 max-w-7xl mx-auto">
        <h2 className="text-3xl font-bold text-slate-100 mb-4 text-center flex items-center justify-center gap-3">
          <GraduationCap className="text-blue-500" /> Equipo de Trabajo
        </h2>
        <p className="text-slate-400 text-center mb-12 max-w-xl mx-auto">
          Estudiantes de pregrado del programa de Ingeniería de Sistemas y Computación,
          Universidad Tecnológica de Pereira.
        </p>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {authors.map((author) => (
            <Card
              key={author.name}
              className="bg-slate-900/50 border-slate-800 backdrop-blur-sm hover:border-blue-500/40 transition-colors duration-300"
            >
              <CardContent className="p-8">
                <div className="flex items-start gap-6">
                  {/* Avatar placeholder */}
                  <div className="shrink-0 w-20 h-20 rounded-2xl bg-slate-800 border border-slate-700 flex items-center justify-center">
                    <User className="w-10 h-10 text-blue-400" />
                  </div>

                  {/* Info */}
                  <div className="space-y-3 min-w-0">
                    <h3 className="text-xl font-bold text-slate-100 leading-snug">
                      {author.name}
                    </h3>

                    <div className="flex items-center gap-2 text-slate-400 text-sm">
                      <Cpu className="w-4 h-4 text-blue-400 shrink-0" />
                      <span>{author.programa}</span>
                    </div>
                    <div className="flex items-center gap-2 text-slate-400 text-sm">
                      <University className="w-4 h-4 text-blue-400 shrink-0" />
                      <span>{author.universidad}</span>
                    </div>
                    <div className="flex items-center gap-2 text-slate-400 text-sm">
                      <BookOpen className="w-4 h-4 text-blue-400 shrink-0" />
                      <span>{author.curso}</span>
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      </section>

      {/* ── 3. DESCRIPCIÓN DEL TEMA ─────────────────────────────────────────── */}
      <section className="py-20 px-4 max-w-4xl mx-auto border-t border-slate-800/50">
        <h2 className="text-3xl font-bold text-slate-100 mb-12 text-center flex items-center justify-center gap-3">
          <FlaskConical className="text-blue-500" /> Descripción del Tema
        </h2>

        <div className="space-y-6 text-slate-400 leading-relaxed text-base md:text-lg">
          <p>
            Un motor eléctrico de corriente continua (DC) es un dispositivo que convierte energía
            eléctrica en energía mecánica rotacional mediante la interacción entre un campo magnético
            y una corriente eléctrica. En su versión casera más sencilla —conocida como motor
            homopolar o motor de bobina simple—, este principio se materializa con elementos
            cotidianos: alambre de cobre esmaltado, clips metálicos, un imán de neodimio y una
            pila alcalina. A pesar de su aparente simplicidad constructiva, el dispositivo encapsula
            de forma elegante algunos de los fenómenos electromagnéticos más fundamentales descritos
            por las ecuaciones de Maxwell.
          </p>
          <p>
            La relevancia académica de construir un motor DC desde cero radica en la posibilidad de
            observar y cuantificar directamente la{" "}
            <span className="text-slate-200 font-medium">Fuerza de Lorentz</span> (
            <span className="font-mono text-blue-300 text-sm">F = qv × B</span>), el fenómeno de
            conmutación electromagnética y la conversión de energía. A diferencia de las simulaciones
            por computadora, el montaje físico expone al estudiante a variables reales —fricción
            mecánica, resistencia del conductor, campo magnético no uniforme— que enriquecen la
            comprensión teórica y desarrollan habilidades experimentales de análisis y resolución de
            problemas.
          </p>
          <p>
            Los objetivos centrales de este proyecto son: (1){" "}
            <span className="text-slate-200">diseñar y construir</span> un motor DC funcional de
            bajo costo a partir de materiales accesibles; (2){" "}
            <span className="text-slate-200">identificar y describir</span> los principios físicos
            que gobiernan su funcionamiento —electromagnetismo, dinámica rotacional y conversión
            de energía—; y (3){" "}
            <span className="text-slate-200">documentar el proceso</span> de montaje, calibración y
            prueba de forma sistemática, vinculando cada decisión de diseño con el marco teórico
            correspondiente del curso de Física II.
          </p>
        </div>
      </section>

      {/* ── 4. ESTADO DEL ARTE ──────────────────────────────────────────────── */}
      <section className="py-20 px-4 max-w-5xl mx-auto border-t border-slate-800/50">
        <h2 className="text-3xl font-bold text-slate-100 mb-4 text-center flex items-center justify-center gap-3">
          <History className="text-blue-500" /> Estado del Arte
        </h2>
        <p className="text-slate-400 text-center mb-14 max-w-2xl mx-auto">
          Contexto histórico y evolución del motor eléctrico, desde los primeros experimentos
          electromagnéticos hasta su aplicación pedagógica contemporánea.
        </p>

        {/* Timeline */}
        <div className="relative">
          {/* Vertical line */}
          <div className="absolute left-6 md:left-1/2 top-0 bottom-0 w-px bg-gradient-to-b from-transparent via-slate-700 to-transparent -translate-x-px" />

          <div className="space-y-10">
            {estadoDelArte.map((item, idx) => {
              const Icon = item.icon
              const isEven = idx % 2 === 0
              return (
                <div
                  key={item.year}
                  className={`relative flex items-start gap-6 md:gap-0 ${
                    isEven ? "md:flex-row" : "md:flex-row-reverse"
                  }`}
                >
                  {/* Year bubble — center on md */}
                  <div className="shrink-0 z-10 flex flex-col items-center md:absolute md:left-1/2 md:-translate-x-1/2">
                    <div className="w-12 h-12 rounded-full bg-slate-900 border border-blue-500/40 flex items-center justify-center shadow-lg shadow-blue-500/10">
                      <Icon className="w-5 h-5 text-blue-400" />
                    </div>
                    <span className="mt-2 text-xs font-mono text-blue-300 whitespace-nowrap">
                      {item.year}
                    </span>
                  </div>

                  {/* Content card */}
                  <div
                    className={`ml-6 md:ml-0 md:w-[calc(50%-3.5rem)] ${
                      isEven ? "md:mr-auto md:pr-4" : "md:ml-auto md:pl-4"
                    }`}
                  >
                    <Card className="bg-slate-900/50 border-slate-800 hover:border-blue-500/40 transition-colors duration-300">
                      <CardContent className="p-5">
                        <h3 className="font-bold text-slate-100 text-base mb-2">{item.title}</h3>
                        <p className="text-slate-400 text-sm leading-relaxed">{item.description}</p>
                      </CardContent>
                    </Card>
                  </div>
                </div>
              )
            })}
          </div>
        </div>
      </section>

      {/* ── 5. PRINCIPIOS FÍSICOS ───────────────────────────────────────────── */}
      <section className="py-20 px-4 max-w-7xl mx-auto border-t border-slate-800/50">
        <h2 className="text-3xl font-bold text-slate-100 mb-12 text-center flex items-center justify-center gap-3">
          <Zap className="text-blue-500" /> Principios Físicos Involucrados
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {principios.map((p) => {
            const Icon = p.icon
            return (
              <Card
                key={p.title}
                className="bg-slate-900/50 border-slate-800 backdrop-blur-sm hover:border-blue-500/50 transition-colors duration-300"
              >
                <CardHeader>
                  <Icon className="w-8 h-8 text-blue-400 mb-3" />
                  <CardTitle className="text-slate-100">{p.title}</CardTitle>
                </CardHeader>
                <CardContent className="text-slate-400">{p.body}</CardContent>
              </Card>
            )
          })}
        </div>
      </section>

      {/* ── 6. BITÁCORA ─────────────────────────────────────────────────────── */}
      <section className="py-20 px-4 max-w-4xl mx-auto border-t border-slate-800/50">
        <h2 className="text-3xl font-bold text-slate-100 mb-12 text-center flex items-center justify-center gap-3">
          <Construction className="text-blue-500" /> Bitácora de Montaje
        </h2>

        <div className="space-y-8 relative before:absolute before:inset-0 before:ml-5 before:-translate-x-px md:before:mx-auto md:before:translate-x-0 before:h-full before:w-0.5 before:bg-gradient-to-b before:from-transparent before:via-slate-800 before:to-transparent">
          {bitacora.map((item) => (
            <div
              key={item.step}
              className="relative flex items-center justify-between md:justify-normal md:odd:flex-row-reverse group"
            >
              {/* Step bubble */}
              <div className="flex items-center justify-center w-10 h-10 rounded-full border border-blue-500/30 bg-slate-950 text-blue-400 shadow shrink-0 md:order-1 md:group-odd:-translate-x-1/2 md:group-even:translate-x-1/2 z-10 font-semibold text-sm">
                {item.step}
              </div>

              {/* Content */}
              <div className="w-[calc(100%-4rem)] md:w-[calc(50%-2.5rem)] p-6 rounded-xl border border-slate-800 bg-slate-900/50 hover:border-blue-500/30 transition-colors duration-300">
                <h3 className="font-bold text-slate-100 text-lg mb-2">{item.title}</h3>
                <p className="text-slate-400 text-sm leading-relaxed">{item.body}</p>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* ── FOOTER ──────────────────────────────────────────────────────────── */}
      <footer className="border-t border-slate-800/50 mt-4 py-10 px-4 text-center">
        <p className="text-slate-500 text-sm">
          Universidad Tecnológica de Pereira · Ingeniería de Sistemas y Computación · Física II ·{" "}
          {new Date().getFullYear()}
        </p>
      </footer>
    </main>
  )
}
