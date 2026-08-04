import Foundation

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date = Date()
}

@MainActor
class CoachViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var isThinking = false

    private let geminiService = GeminiService.shared
    private let workoutRepository = WorkoutRepository.shared

    init() {
        messages.append(ChatMessage(
            content: "Hola, soy Khor. Tu coach de fitness con IA. ¿En qué te puedo ayudar hoy?",
            isUser: false
        ))
    }

    func sendMessage(_ text: String) async {
        messages.append(ChatMessage(content: text, isUser: true))
        isThinking = true

        let context = await buildContext()
        let response = await geminiService.chat(
            userMessage: text,
            systemContext: context,
            history: messages.dropLast()
        )

        isThinking = false
        messages.append(ChatMessage(content: response, isUser: false))
    }

    private func buildContext() async -> String {
        let recentWorkouts = await workoutRepository.getRecentWorkouts(limit: 5)
        let streak = await workoutRepository.calculateStreak()

        var context = "Eres Khor, un coach de fitness IA experto. Eres directo, motivador y personalizado.\n\n"
        context += "RACHA ACTUAL: \(streak) días\n"
        context += "SESIONES RECIENTES: \(recentWorkouts.count)\n"
        if let last = recentWorkouts.first {
            context += "ÚLTIMO ENTRENO: \(last.programName ?? "Libre") - \(last.date.formatted(date: .abbreviated, time: .omitted))\n"
        }
        return context
    }
}
