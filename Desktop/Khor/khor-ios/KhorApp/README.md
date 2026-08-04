# Khor iOS

Adaptación nativa de Khor para iOS con SwiftUI.

## Stack

- **SwiftUI** — UI declarativa nativa
- **Firebase Auth** — autenticación (email + Google Sign-In)
- **Firestore** — base de datos en la nube
- **Gemini API** — coach IA (mismo backend que Android)
- **Swift Concurrency** — async/await en lugar de Coroutines

## Equivalencias Android → iOS

| Android | iOS |
|---|---|
| Jetpack Compose | SwiftUI |
| ViewModel (MVVM) | `@StateObject` / `ObservableObject` |
| Room (SQLite) | SwiftData / CoreData |
| Kotlin Coroutines | Swift async/await + actors |
| Hilt/DI | `actor` singletons + `@EnvironmentObject` |
| Navigation Component | `NavigationStack` |
| DataStore | `UserDefaults` / `@AppStorage` |
| WorkManager | `BGTaskScheduler` |

## Estructura

```
KhorApp/
├── App/                    # Entry point, AppDelegate, AppState
├── Auth/                   # Login, SignUp, ForgotPassword
├── Core/
│   ├── Models/             # UserProfile, Workout, Nutrition, Exercise
│   └── Services/           # AuthService, GeminiService
├── Data/
│   └── Repository/         # WorkoutRepository, NutritionRepository
├── Features/
│   ├── Dashboard/          # Home screen
│   ├── Workout/            # Workout tracking + history
│   ├── Coach/              # Chat con IA Khor
│   ├── Nutrition/          # Registro de comidas
│   ├── Progress/           # Gráficas y PRs
│   ├── Onboarding/         # Flujo de bienvenida
│   └── Settings/           # Ajustes y perfil
└── UI/
    ├── Theme/              # Colores, fuentes (mismo paleta que Android)
    ├── Components/         # Botones, campos, cards reutilizables
    └── Navigation/         # RootView, MainTabView
```

## Setup

1. Crear proyecto Xcode nuevo (SwiftUI, iOS 17+)
2. Añadir dependencias via SPM (ver `Package.swift`)
3. Añadir `GoogleService-Info.plist` de Firebase Console
4. Añadir `GEMINI_API_KEY` en Info.plist

## Pendiente

- [ ] Persistencia local con SwiftData
- [ ] Sincronización con Firestore
- [ ] Notificaciones push (APNs)
- [ ] Análisis de foto de comida (cámara)
- [ ] Paywall con StoreKit 2 (reemplaza Google Play Billing)
- [ ] Apple Sign-In (requerido por App Store si hay Google Sign-In)
- [ ] HealthKit integration
