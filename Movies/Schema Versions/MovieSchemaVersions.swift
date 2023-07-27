//
//  MovieSchemaVersions.swift
//  Movies
//
//  Created by Matt Maher on 7/27/23.
//

import Foundation
import SwiftData

enum MoviesSchemaV1: VersionedSchema {
    static var versionIdentifier: String = "Initial version"
    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }

    @Model
    final class Movie {
        var title: String = ""
        var year: Int = 0

        var reviewsCount: Int {
            reviews.count
        }

        var actorsCount: Int {
            actors.count
        }

        @Relationship(.cascade, inverse: \Review.movie)
        var reviews: [Review] = []

        @Relationship(.nullify, inverse: \Actor.movies)
        var actors: [Actor] = []

        init(title: String, year: Int) {
            self.title = title
            self.year = year
        }
    }
}

enum MoviesSchemaV2: VersionedSchema {
    static var versionIdentifier: String = "Adding unique constraint to movie name."
    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }

    @Model
    final class Movie {
        @Attribute(.unique) var title: String = ""
        var year: Int = 0

        var reviewsCount: Int {
            reviews.count
        }

        var actorsCount: Int {
            actors.count
        }

        @Relationship(.cascade, inverse: \Review.movie)
        var reviews: [Review] = []

        @Relationship(.nullify, inverse: \Actor.movies)
        var actors: [Actor] = []

        init(title: String, year: Int) {
            self.title = title
            self.year = year
        }
    }
}

enum MoviesSchemaV3: VersionedSchema {
    static var versionIdentifier: String = "Changing title of movie property to name"
    static var models: [any PersistentModel.Type] {
        [Movie.self]
    }

    @Model
    final class Movie {
        @Attribute(.unique, originalName: "title") var name: String = ""
        var year: Int = 0

        var reviewsCount: Int {
            reviews.count
        }

        var actorsCount: Int {
            actors.count
        }

        @Relationship(.cascade, inverse: \Review.movie)
        var reviews: [Review] = []

        @Relationship(.nullify, inverse: \Actor.movies)
        var actors: [Actor] = []

        init(name: String, year: Int) {
            self.name = name
            self.year = year
        }
    }
}
