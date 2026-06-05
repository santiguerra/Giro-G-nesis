'use client'

import { SplineScene } from "@/components/ui/splite";
import { Spotlight } from "@/components/ui/spotlight"
import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card"
import { Construction, Zap, Magnet, Battery } from "lucide-react"

export default function PhysicsProjectPage() {
  return (
    <main className="min-h-screen bg-slate-950 text-slate-50 selection:bg-blue-500/30 pb-20">
      
      {/* Hero Section - EXACT MATCH TO REFERENCE */}
      <div className="p-4 md:p-8 max-w-7xl mx-auto mt-4 md:mt-12">
        <Card className="w-full h-[600px] bg-black/[0.96] relative overflow-hidden border-slate-800">
          <Spotlight
            className="-top-40 left-0 md:left-60 md:-top-20"
            fill="white"
          />
          
          <div className="flex flex-col md:flex-row h-full">
            {/* Left content */}
            <div className="flex-1 p-8 md:p-12 relative z-10 flex flex-col justify-center">
              <div className="inline-flex w-fit items-center rounded-full border border-blue-500/30 bg-blue-500/10 px-3 py-1 text-sm font-medium text-blue-300 mb-6">
                Física II - Proyecto Final
              </div>
              <h1 className="text-4xl md:text-6xl font-bold bg-clip-text text-transparent bg-gradient-to-b from-neutral-50 to-neutral-400 mb-6">
                Motor Electromagnético
              </h1>
              <p className="mt-4 text-neutral-300 max-w-lg text-lg leading-relaxed">
                Una exploración de la dinámica y el electromagnetismo a través de la construcción de un motor DC casero de alto torque.
              </p>
            </div>

            {/* Right content */}
            <div className="flex-1 relative hidden md:block">
              <SplineScene 
                scene="https://my.spline.design/robotfollowcursorforlandingpage-PUqrwZGah4DygoDzg0WQcQft/"
                className="w-full h-full"
              />
            </div>
          </div>
        </Card>
      </div>

      {/* Physics Principles Section */}
      <section className="py-20 px-4 max-w-7xl mx-auto">
        <h2 className="text-3xl font-bold text-slate-100 mb-12 text-center flex items-center justify-center gap-3">
          <Zap className="text-blue-500" /> Principios Físicos
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <Card className="bg-slate-900/50 border-slate-800 backdrop-blur-sm">
            <CardHeader>
              <Magnet className="w-8 h-8 text-blue-400 mb-3" />
              <CardTitle className="text-slate-100">Fuerza de Lorentz</CardTitle>
            </CardHeader>
            <CardContent className="text-slate-400">
              Cuando la corriente eléctrica fluye por la bobina de cobre en presencia del campo magnético del imán, experimenta una fuerza perpendicular que hace girar la estructura.
            </CardContent>
          </Card>
          <Card className="bg-slate-900/50 border-slate-800 backdrop-blur-sm">
            <CardHeader>
              <Zap className="w-8 h-8 text-blue-400 mb-3" />
              <CardTitle className="text-slate-100">Electromagnetismo</CardTitle>
            </CardHeader>
            <CardContent className="text-slate-400">
              Al lijar solo la mitad del esmalte en uno de los ejes, creamos un conmutador rudimentario. Esto rompe el circuito cada media vuelta, permitiendo que la inercia mantenga el giro en una sola dirección.
            </CardContent>
          </Card>
          <Card className="bg-slate-900/50 border-slate-800 backdrop-blur-sm">
            <CardHeader>
              <Battery className="w-8 h-8 text-blue-400 mb-3" />
              <CardTitle className="text-slate-100">Torque y Dinámica</CardTitle>
            </CardHeader>
            <CardContent className="text-slate-400">
              Las fuerzas magnéticas crean un torque sobre la espira. La eficiencia de esta rotación depende del número de vueltas de la bobina, la corriente de la fuente y la fuerza del imán de neodimio.
            </CardContent>
          </Card>
        </div>
      </section>

      {/* Bitácora Section */}
      <section className="py-20 px-4 max-w-4xl mx-auto border-t border-slate-800/50">
        <h2 className="text-3xl font-bold text-slate-100 mb-12 text-center flex items-center justify-center gap-3">
          <Construction className="text-blue-500" /> Bitácora de Montaje
        </h2>
        <div className="space-y-8 relative before:absolute before:inset-0 before:ml-5 before:-translate-x-px md:before:mx-auto md:before:translate-x-0 before:h-full before:w-0.5 before:bg-gradient-to-b before:from-transparent before:via-slate-800 before:to-transparent">
          
          <div className="relative flex items-center justify-between md:justify-normal md:odd:flex-row-reverse group is-active">
            <div className="flex items-center justify-center w-10 h-10 rounded-full border border-blue-500/30 bg-slate-950 text-blue-400 shadow shrink-0 md:order-1 md:group-odd:-translate-x-1/2 md:group-even:translate-x-1/2 z-10">
              1
            </div>
            <div className="w-[calc(100%-4rem)] md:w-[calc(50%-2.5rem)] p-6 rounded-xl border border-slate-800 bg-slate-900/50">
              <h3 className="font-bold text-slate-100 text-lg mb-2">Preparación de la Bobina</h3>
              <p className="text-slate-400 text-sm">Se enrolló alambre de cobre esmaltado firmemente. Se dejaron dos extremos rectos como ejes. Se lijó completamente el esmalte de un extremo, y solo la mitad del otro para crear el efecto conmutador.</p>
            </div>
          </div>

          <div className="relative flex items-center justify-between md:justify-normal md:odd:flex-row-reverse group is-active">
            <div className="flex items-center justify-center w-10 h-10 rounded-full border border-blue-500/30 bg-slate-950 text-blue-400 shadow shrink-0 md:order-1 md:group-odd:-translate-x-1/2 md:group-even:translate-x-1/2 z-10">
              2
            </div>
            <div className="w-[calc(100%-4rem)] md:w-[calc(50%-2.5rem)] p-6 rounded-xl border border-slate-800 bg-slate-900/50">
              <h3 className="font-bold text-slate-100 text-lg mb-2">Soportes y Base</h3>
              <p className="text-slate-400 text-sm">Se montaron dos clips conductores sobre la base para servir como soporte estructural y contactos eléctricos. Se aseguraron de estar nivelados para reducir la fricción mecánica al mínimo.</p>
            </div>
          </div>

          <div className="relative flex items-center justify-between md:justify-normal md:odd:flex-row-reverse group is-active">
            <div className="flex items-center justify-center w-10 h-10 rounded-full border border-blue-500/30 bg-slate-950 text-blue-400 shadow shrink-0 md:order-1 md:group-odd:-translate-x-1/2 md:group-even:translate-x-1/2 z-10">
              3
            </div>
            <div className="w-[calc(100%-4rem)] md:w-[calc(50%-2.5rem)] p-6 rounded-xl border border-slate-800 bg-slate-900/50">
              <h3 className="font-bold text-slate-100 text-lg mb-2">Integración del Imán</h3>
              <p className="text-slate-400 text-sm">Se colocó un imán circular permanentemente debajo de la bobina. Se ajustó la altura para maximizar el campo magnético sin obstruir la rotación física del cobre.</p>
            </div>
          </div>

          <div className="relative flex items-center justify-between md:justify-normal md:odd:flex-row-reverse group is-active">
            <div className="flex items-center justify-center w-10 h-10 rounded-full border border-blue-500/30 bg-slate-950 text-blue-400 shadow shrink-0 md:order-1 md:group-odd:-translate-x-1/2 md:group-even:translate-x-1/2 z-10">
              4
            </div>
            <div className="w-[calc(100%-4rem)] md:w-[calc(50%-2.5rem)] p-6 rounded-xl border border-slate-800 bg-slate-900/50">
              <h3 className="font-bold text-slate-100 text-lg mb-2">Prueba y Encendido</h3>
              <p className="text-slate-400 text-sm">Se conectaron los caimanes desde la fuente de poder a los clips. Con un ligero empuje manual para romper la inercia, se logró una rotación estable y continua de alto torque.</p>
            </div>
          </div>

        </div>
      </section>
    </main>
  )
}
