import SwiftUI

struct ParentGuidanceView: View {
    let onExitToKidSpace: () -> Void

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button(action: onExitToKidSpace) {
                        Label("Switch back to Kid Space", systemImage: "arrow.left.circle.fill")
                            .font(.headline)
                            .fontDesign(.rounded)
                            .foregroundStyle(.indigo)
                    }
                    .padding(.vertical, 4)
                }

                Section(header: Text("Kenyan Curriculum & Accommodations")) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Understanding Mild Dyslexia")
                            .font(.headline)
                        Text("Dyslexia is an auditory-visual processing variation. It is unrelated to intellectual ability and benefits significantly from clear, untimed reading routines.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("CBC Classroom Accommodations")
                            .font(.headline)
                        Text("Parents can advocate for oral evaluations, extra time on continuous assessments, and pastel reading overlays under CBC guidelines.")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }

                Section(header: Text("Home Support Principles")) {
                    Text("• Use soft, indirect lighting and avoid harsh white sheets.")
                    Text("• Keep reading sessions under 15 minutes to prevent visual fatigue.")
                    Text("• Pair written text with speech synthesis to build word association.")
                }
                .font(.footnote)
            }
            .navigationTitle("Caregiver Guide")
        }
    }
}
