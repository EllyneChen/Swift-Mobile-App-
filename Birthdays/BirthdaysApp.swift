//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by Student1 on 22/09/2026.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
