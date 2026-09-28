//
//  Movie.swift
//  FriendsFavoriteMovies
//
//  Created by Student1 on 28/09/2026.
//
import Foundation
import SwiftData

@Model

class Movie {
    var title: String
    var releaseDate: Date
    
    init(title: String, releaseDate: Date) {
        self.title = title
        self.releaseDate = releaseDate
    }
    
    static let sampleData = [
        Movie(title: "The Mentalist",
              releaseDate: Date(timeIntervalSinceReferenceDate: -402_000_000)),
        Movie(title: "Spiderman",
                  releaseDate: Date(timeIntervalSinceReferenceDate: -20_000_000)),
            Movie(title: "Wicked",
                  releaseDate: Date(timeIntervalSinceReferenceDate: 300_000_000)),
            Movie(title: "Reckless Train Ride 2",
                  releaseDate: Date(timeIntervalSinceReferenceDate: 120_000_000)),
            Movie(title: "The Last Venture",
                  releaseDate: Date(timeIntervalSinceReferenceDate: 550_000_000)),
            Movie(title: "Glamorous Neighbor",
                  releaseDate: Date(timeIntervalSinceReferenceDate: -1_700_000_000)),    ]
}
