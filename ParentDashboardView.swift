import SwiftUI

struct ParentDashboardView: View {
    let onExitToKidSpace: () -> Void

    var body: some View {
        TabView {
            ParentGuidanceView(onExitToKidSpace: onExitToKidSpace)
                .tabItem {
                    Label("Guidance", systemImage: "book.pages.fill")
                }

            CareFinderView()
                .tabItem {
                    Label("Care Finder", systemImage: "cross.case.fill")
                }

            SafetyProtectionView()
                .tabItem {
                    Label("Safety & 116", systemImage: "shield.checkered")
                }
        }
        .tint(.indigo)
    }
}
