import Foundation

actor GeminiService {
    static let shared = GeminiService()
    private init() {}

    private let apiKey = Bundle.main.infoDictionary?["GEMINI_API_KEY"] as? String ?? ""
    private let baseURL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent"

    func chat(userMessage: String, systemContext: String, history: ArraySlice<ChatMessage>) async -> String {
        var contents: [[String: Any]] = []

        // Add history
        for msg in history {
            contents.append([
                "role": msg.isUser ? "user" : "model",
                "parts": [["text": msg.content]]
            ])
        }

        // Add current message with system context prepended to first user message
        let messageWithContext = contents.isEmpty
            ? "\(systemContext)\n\nUsuario: \(userMessage)"
            : userMessage
        contents.append(["role": "user", "parts": [["text": messageWithContext]]])

        let body: [String: Any] = ["contents": contents]

        guard let url = URL(string: "\(baseURL)?key=\(apiKey)"),
              let data = try? JSONSerialization.data(withJSONObject: body) else {
            return "Error: no se pudo conectar con Khor."
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data

        do {
            let (responseData, _) = try await URLSession.shared.data(for: request)
            if let json = try? JSONSerialization.jsonObject(with: responseData) as? [String: Any],
               let candidates = json["candidates"] as? [[String: Any]],
               let content = candidates.first?["content"] as? [String: Any],
               let parts = content["parts"] as? [[String: Any]],
               let text = parts.first?["text"] as? String {
                return text
            }
        } catch {
            return "Error de conexión. Inténtalo de nuevo."
        }
        return "No pude procesar eso. Inténtalo de nuevo."
    }

    func analyzeNutritionPhoto(imageData: Data) async -> NutritionAnalysisResult? {
        let base64 = imageData.base64EncodedString()
        let body: [String: Any] = [
            "contents": [[
                "parts": [
                    ["text": "Analiza esta foto de comida y devuelve: nombre del plato, calorías estimadas, proteínas(g), carbohidratos(g), grasas(g). Responde en JSON con campos: name, calories, protein, carbs, fat."],
                    ["inline_data": ["mime_type": "image/jpeg", "data": base64]]
                ]
            ]]
        ]

        guard let url = URL(string: "\(baseURL)?key=\(apiKey)"),
              let data = try? JSONSerialization.data(withJSONObject: body) else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data

        do {
            let (responseData, _) = try await URLSession.shared.data(for: request)
            if let json = try? JSONSerialization.jsonObject(with: responseData) as? [String: Any],
               let candidates = json["candidates"] as? [[String: Any]],
               let content = candidates.first?["content"] as? [String: Any],
               let parts = content["parts"] as? [[String: Any]],
               let text = parts.first?["text"] as? String,
               let jsonStart = text.range(of: "{"),
               let jsonEnd = text.range(of: "}", options: .backwards) {
                let jsonString = String(text[jsonStart.lowerBound...jsonEnd.upperBound])
                if let jsonData = jsonString.data(using: .utf8),
                   let result = try? JSONDecoder().decode(NutritionAnalysisResult.self, from: jsonData) {
                    return result
                }
            }
        } catch {}
        return nil
    }
}

struct NutritionAnalysisResult: Codable {
    let name: String
    let calories: Double
    let protein: Double
    let carbs: Double
    let fat: Double
}
