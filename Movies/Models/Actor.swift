//
//  Actor.swift
//  Movies
//
//  Created by Matt Maher on 7/25/23.
//

import Foundation
import SwiftData

@Model
final class Actor {
    var name: String
    var movies: [Movie] = []

    init(name: String) {
        self.name = name
    }
}
