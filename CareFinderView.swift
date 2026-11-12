import SwiftUI

struct FacilityDetailView: View {
    let facility: CareFacility

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(facility.name)
                .font(.title2)
                .fontWeight(.bold)
                .fontDesign(.rounded)

            Text(facility.specialty)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.indigo)

            Divider()

            Label(facility.location, systemImage: "mappin.and.ellipse")
                .font(.body)
                .foregroundStyle(.secondary)

            Label(facility.phone, systemImage: "phone.fill")
                .font(.body)
                .foregroundStyle(.secondary)

            Spacer()

            if let url = URL(string: "tel://\(facility.phone)") {
                Link(destination: url) {
                    Label("Call Facility Now", systemImage: "phone.fill")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(.indigo)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }
        }
        .padding(24)
        .presentationDetents([.medium])
    }
}

struct CareFinderView: View {
    @State private var searchText: String = ""
    @State private var selectedFacility: CareFacility? = nil
    private let facilities: [CareFacility] = DataLoader.loadJSON("facilities.json")

    var filteredFacilities: [CareFacility] {
        if searchText.isEmpty {
            return facilities
        } else {
            return facilities.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.specialty.localizedCaseInsensitiveContains(searchText) ||
                $0.location.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredFacilities) { item in
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.name)
                        .font(.headline)
                        .fontDesign(.rounded)

                    Text(item.specialty)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.indigo)

                    Label(item.location, systemImage: "mappin.and.ellipse")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 6)
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedFacility = item
                }
            }
            .navigationTitle("Care Finder")
            .searchable(text: $searchText, prompt: "Search clinics, centers, or areas...")
            .sheet(item: $selectedFacility) { facility in
                FacilityDetailView(facility: facility)
            }
        }
    }
}
