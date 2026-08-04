import SwiftUI

struct CoachView: View {
    @StateObject private var viewModel = CoachViewModel()
    @State private var inputText = ""
    @FocusState private var isInputFocused: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                KhorColors.background.ignoresSafeArea()

                VStack(spacing: 0) {
                    // Messages
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.messages) { message in
                                    ChatBubble(message: message)
                                        .id(message.id)
                                }
                                if viewModel.isThinking {
                                    ThinkingIndicator()
                                        .id("thinking")
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                        }
                        .onChange(of: viewModel.messages.count) { _ in
                            withAnimation { proxy.scrollTo(viewModel.messages.last?.id) }
                        }
                        .onChange(of: viewModel.isThinking) { thinking in
                            if thinking { withAnimation { proxy.scrollTo("thinking") } }
                        }
                    }

                    // Input bar
                    HStack(spacing: 12) {
                        TextField("Pregúntale algo a Khor...", text: $inputText, axis: .vertical)
                            .lineLimit(1...4)
                            .font(KhorFonts.body())
                            .foregroundColor(KhorColors.textPrimary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(KhorColors.surface)
                            .cornerRadius(24)
                            .focused($isInputFocused)

                        Button {
                            guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
                            let text = inputText
                            inputText = ""
                            Task { await viewModel.sendMessage(text) }
                        } label: {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(size: 36))
                                .foregroundColor(inputText.isEmpty ? KhorColors.textDisabled : KhorColors.accent)
                        }
                        .disabled(inputText.isEmpty || viewModel.isThinking)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(KhorColors.surface)
                }
            }
            .navigationTitle("Khor IA")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ChatBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if message.isUser { Spacer(minLength: 60) }

            if !message.isUser {
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            colors: [KhorColors.accent, KhorColors.accentViolet],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 28, height: 28)
                    Text("K")
                        .font(KhorFonts.label(12))
                        .foregroundColor(.white)
                }
            }

            Text(message.content)
                .font(KhorFonts.body())
                .foregroundColor(message.isUser ? .white : KhorColors.textPrimary)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    message.isUser
                    ? LinearGradient(colors: [KhorColors.accent, KhorColors.accentViolet], startPoint: .topLeading, endPoint: .bottomTrailing)
                    : LinearGradient(colors: [KhorColors.surface, KhorColors.surface], startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(18)

            if !message.isUser { Spacer(minLength: 60) }
        }
    }
}

struct ThinkingIndicator: View {
    @State private var dotCount = 1

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        colors: [KhorColors.accent, KhorColors.accentViolet],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 28, height: 28)
                Text("K")
                    .font(KhorFonts.label(12))
                    .foregroundColor(.white)
            }
            Text(String(repeating: "●", count: dotCount))
                .font(.system(size: 10))
                .foregroundColor(KhorColors.textTertiary)
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(KhorColors.surface)
                .cornerRadius(18)
            Spacer()
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { t in
                dotCount = dotCount % 3 + 1
            }
        }
    }
}
