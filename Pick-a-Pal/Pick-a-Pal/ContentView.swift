//
//  ContentView.swift
//  Pick-a-Pal
//
//  Created by Student1 on 14/09/2026.
//


import SwiftUI


struct ContentView: View {
    @State private var names: [String] = ["Elisha", "Andre", "Jasmine", "Po-Chun"]
    @State private var nameToAdd = ""
    @State private var pickedName = ""
    @State private var shouldRemovePickedName = false


    var body: some View {
        VStack {
            Text(pickedName.isEmpty ? " " : pickedName)


            List {
                ForEach(names, id: \.description) { name in
                    Text(name)
                }
            }


            TextField("Add Name", text: $nameToAdd)
                .autocorrectionDisabled()
                .onSubmit {
                    if !nameToAdd.isEmpty {
                        names.append(nameToAdd)
                        nameToAdd = ""
                    }
                }


            Divider()


            Toggle("Remove when picked", isOn: $shouldRemovePickedName)


            Button("Pick Random Name") {
                if let randomName = names.randomElement() {
                    pickedName = randomName


                    if shouldRemovePickedName {
                        names.removeAll { name in
                            return (name == randomName)
                        }
                    }
                } else {
                    pickedName = ""
                }
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
