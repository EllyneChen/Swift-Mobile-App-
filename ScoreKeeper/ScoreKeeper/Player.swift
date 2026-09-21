//
//  Player.swift
//  ScoreKeeper
//
//  Created by Student1 on 21/09/2026.
//

import Foundation

struct Player: Identifiable {
    let id = UUID()
    var name: String
    var score: Int
}
