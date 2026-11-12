import SwiftUI

struct WelcomeLandingView: View {
    let onEnterApp: () -> Void

    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.97, blue: 0.99)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.indigo.opacity(0.12))
                        .frame(width: 110, height: 110)

                    Image(systemName: "book.pages.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(.indigo)
                }

                VStack(spacing: 8) {
                    Text("Hope Special Care")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundStyle(Color(red: 0.15, green: 0.20, blue: 0.30))

                    Text("Learning made comfortable, clear, and safe")
                        .font(.subheadline)
                        .fontDesign(.rounded)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }

                Spacer()

                Button(action: onEnterApp) {
                    Text("Get Started")
                        .font(.headline)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(.indigo)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .indigo.opacity(0.3), radius: 8, y: 4)
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 36)
            }
        }
    }
}

struct ModeSwitchView: View {
    @State private var hasStarted: Bool = false
    @State private var isParentMode: Bool = false
    @State private var showGateAlert: Bool = false
    @State private var gateAnswer: String = ""
    
    // Simple, low-literacy friendly numbers (e.g., 2 to 5)
    @State private var num1: Int = Int.random(in: 2...4)
    @State private var num2: Int = Int.random(in: 2...5)

    var correctAnswer: String {
        String(num1 + num2)
    }

    func generateNewChallenge() {
        num1 = Int.random(in: 2...4)
        num2 = Int.random(in: 2...5)
        gateAnswer = ""
    }

    var body: some View {
        if !hasStarted {
            WelcomeLandingView {
                hasStarted = true
            }
        } else if isParentMode {
            ParentDashboardView(onExitToKidSpace: {
                isParentMode = false
            })
        } else {
            KidReaderView(onOpenParentPortal: {
                generateNewChallenge()
                showGateAlert = true
            })
            .alert("Caregiver Verification", isPresented: $showGateAlert) {
                TextField("Answer", text: $gateAnswer)
                    .keyboardType(.numberPad)
                Button("Cancel", role: .cancel) {
                    gateAnswer = ""
                }
                Button("Enter") {
                    if gateAnswer.trimmingCharacters(in: .whitespaces) == correctAnswer {
                        gateAnswer = ""
                        isParentMode = true
                    } else {
                        gateAnswer = ""
                    }
                }
            } message: {
                Text("Please solve to unlock Caregiver Portal:\nWhat is \(num1) + \(num2)?")
            }
        }
    }
}
