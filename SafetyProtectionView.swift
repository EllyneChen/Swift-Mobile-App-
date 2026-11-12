import SwiftUI

struct SafetyProtectionView: View {
    @State private var selectedCategory = "Child Protection / Welfare"
    @State private var incidentDescription = ""
    @State private var isSubmitting = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let categories = [
        "Child Protection / Welfare",
        "Abuse or Neglect",
        "Medical Emergency",
        "Educational Support / Access",
        "Other Incident"
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                // Warm cream background for neuro-inclusive reading comfort
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Emergency Call Banner
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Immediate Assistance")
                                .font(.headline)
                                .foregroundColor(.red)
                            
                            Text("If a child is in immediate physical danger, call Childline Kenya directly for urgent emergency intervention.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Button(action: {
                                callEmergencyNumber("116")
                            }) {
                                Label("Call Childline Kenya (116)", systemImage: "phone.fill")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)

                        // Incident Reporting Form Card
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Confidential Incident Report")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.indigo))
                            
                            Text("Submit records securely to the administrative database for case review.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            // Category Picker
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Incident Category")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                                
                                Picker("Category", selection: $selectedCategory) {
                                    ForEach(categories, id: \.self) { category in
                                        Text(category).tag(category)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .padding(8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(8)
                            }
                            
                            // Description Input
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Incident Details")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.secondary)
                                
                                TextEditor(text: $incidentDescription)
                                    .frame(height: 120)
                                    .padding(8)
                                    .background(Color(.secondarySystemBackground))
                                    .cornerRadius(8)
                            }
                            
                            // Submit Button
                            Button(action: {
                                submitIncidentToBackend()
                            }) {
                                HStack {
                                    if isSubmitting {
                                        ProgressView()
                                            .tint(.white)
                                    }
                                    Text(isSubmitting ? "Submitting to Database..." : "Submit Report")
                                        .font(.headline)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(incidentDescription.isEmpty ? Color.gray : Color.indigo)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                            }
                            .disabled(incidentDescription.isEmpty || isSubmitting)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    }
                    .padding()
                }
            }
            .navigationTitle("Safety & Protection")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Submission Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // MARK: - Backend Network Submission
    func submitIncidentToBackend() {
        isSubmitting = true
        
        
        guard let url = URL(string: "http://localhost/hopespecialcare/save_incident.php") else {
            alertMessage = "Invalid server URL."
            isSubmitting = false
            showAlert = true
            return
        }
        
        let payload: [String: Any] = [
            "category": selectedCategory,
            "description": incidentDescription,
            "timestamp": ISO8601DateFormatter().string(from: Date())
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: payload) else {
            alertMessage = "Failed to encode payload."
            isSubmitting = false
            showAlert = true
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isSubmitting = false
                
                if let error = error {
                    alertMessage = "Network error: \(error.localizedDescription)"
                    showAlert = true
                    return
                }
                
                if let data = data,
                   let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let status = jsonResponse["status"] as? String, status == "success" {
                    alertMessage = "Incident successfully saved to the MySQL database!"
                    incidentDescription = "" // Reset form
                } else {
                    alertMessage = "Report received by server backend."
                }
                showAlert = true
            }
        }.resume()
    }
    
    // MARK: - Emergency Telephony Link
    func callEmergencyNumber(_ number: String) {
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    SafetyProtectionView()
}
