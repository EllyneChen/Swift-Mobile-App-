import SwiftUI

enum PageTint: String, CaseIterable, Identifiable {
    case cream = "Cream"
    case softBlue = "Soft Blue"
    case softAmber = "Soft Amber"

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .cream: return Color(red: 0.99, green: 0.98, blue: 0.95)
        case .softBlue: return Color(red: 0.92, green: 0.95, blue: 0.98)
        case .softAmber: return Color(red: 0.99, green: 0.96, blue: 0.90)
        }
    }
}

struct KidReaderView: View {
    let onOpenParentPortal: () -> Void

    @State private var passages: [ReadingPassage] = DataLoader.loadJSON("passages.json")
    @State private var currentIndex: Int = 0
    @State private var selectedTint: PageTint = .cream
    @State private var speechManager = SpeechManager()

    var currentPassage: ReadingPassage {
        passages[currentIndex]
    }

    var formattedAttributedText: AttributedString {
        var attributed = AttributedString(currentPassage.text)
        attributed.font = .system(size: 26, weight: .medium, design: .rounded)
        attributed.foregroundColor = Color(red: 0.15, green: 0.20, blue: 0.30)

        if let range = speechManager.currentSpokenRange,
           let stringRange = Range(range, in: currentPassage.text),
           let attrRange = Range(stringRange, in: attributed) {
            attributed[attrRange].backgroundColor = Color.yellow.opacity(0.45)
            attributed[attrRange].foregroundColor = Color.black
        }

        return attributed
    }

    var body: some View {
        ZStack {
            selectedTint.color
                .ignoresSafeArea()

            VStack(spacing: 20) {
                HStack {
                    Picker("Page Tint", selection: $selectedTint) {
                        ForEach(PageTint.allCases) { tint in
                            Text(tint.rawValue).tag(tint)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: 240)

                    Spacer()

                    Button(action: {
                        speechManager.stop()
                        onOpenParentPortal()
                    }) {
                        Label("Parent", systemImage: "lock.shield.fill")
                            .font(.caption)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundStyle(.indigo)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .shadow(color: .black.opacity(0.06), radius: 3)
                    }
                }
                .padding(.horizontal)

                Spacer()

                VStack(alignment: .leading, spacing: 16) {
                    Text(currentPassage.title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundStyle(.indigo)

                    Text(formattedAttributedText)
                        .lineSpacing(12)
                        .kerning(0.8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8)
                }
                .padding(26)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .shadow(color: .black.opacity(0.05), radius: 10, y: 4)
                .padding(.horizontal)

                Button(action: {
                    speechManager.speak(text: currentPassage.text)
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: speechManager.isSpeaking ? "stop.fill" : "speaker.wave.2.bubble.fill")
                        Text(speechManager.isSpeaking ? "Stop Reading" : "Read Aloud")
                    }
                    .font(.title3)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(speechManager.isSpeaking ? Color.red.opacity(0.85) : Color.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: (speechManager.isSpeaking ? Color.red : Color.orange).opacity(0.25), radius: 8, y: 4)
                }
                .padding(.horizontal)

                HStack {
                    Button(action: {
                        speechManager.stop()
                        if currentIndex > 0 { currentIndex -= 1 }
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .font(.system(size: 38))
                            .foregroundStyle(currentIndex > 0 ? .indigo : .gray.opacity(0.3))
                    }
                    .disabled(currentIndex == 0)

                    Spacer()

                    Text("Story \(currentIndex + 1) of \(passages.count)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .fontDesign(.rounded)
                        .foregroundStyle(.secondary)

                    Spacer()

                    Button(action: {
                        speechManager.stop()
                        if currentIndex < passages.count - 1 { currentIndex += 1 }
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 38))
                            .foregroundStyle(currentIndex < passages.count - 1 ? .indigo : .gray.opacity(0.3))
                    }
                    .disabled(currentIndex == passages.count - 1)
                }
                .padding(.horizontal, 32)

                Spacer()
            }
        }
    }
}
