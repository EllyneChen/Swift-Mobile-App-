//
//  ContentView.swift
//  FriendsFavoriteMovies
//
//  Created by Student1 on 28/09/2026.
//


import SwiftUI
import SwiftData



struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Friends", systemImage: "person.and.person") {
                FriendList()
            }


            Tab("Movies", systemImage: "film.stack") {
                MovieList()
            }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
