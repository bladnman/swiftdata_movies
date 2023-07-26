//
//  MyPreviewer.swift
//  Movies
//
//  Created by Matt Maher on 7/25/23.
//

import SwiftData
import SwiftUI

struct MyPreviewer<Content: View>: View {
    let content: Content
    let modelContainer: ModelContainer

    init(
        modelContainer: ModelContainer = previewContainer,
        @ViewBuilder content: () -> Content
    ) {
        self.modelContainer = modelContainer
        self.content = content()
    }

    var body: some View {
        content
            .modelContainer(self.modelContainer)
    }
}

var sampleReviews: [Review] = MainActor.assumeIsolated {
    [
        Review(subject: "I love Tom Hanks", body: "Funniest guy on the planet"),
        Review(subject: "Movie was long", body: "What is wrong in Hollywood these days?"),
        Review(subject: "Theater sucked", body: "The guy next to me would not stop eating!"),
    ]
}

var sampleSpiderman: Movie = MainActor.assumeIsolated {
    var tempActor = Actor(name: "Toby Mcguire")
    tempActor.movies = [Movie(title: "Spiderman", year: 2023)]

    var movie = Movie(title: "Spiderman", year: 2023)
    movie.reviews = sampleReviews
    movie.actors = [
        tempActor,
    ]
    return movie
}

var sampleBatman: Movie = MainActor.assumeIsolated {
    var movie = Movie(title: "Batman", year: 1954)
    movie.actors = [
        Actor(name: "Jeb"),
        Actor(name: "Treat"),
        Actor(name: "Sims"),
    ]
    return movie
}

var sampleTomHanks: Actor = MainActor.assumeIsolated {
    var actor = Actor(name: "Tom Hanks")
    actor.movies = [sampleBatman, sampleSpiderman]
    return actor
}

var sampleSallyFields: Actor = MainActor.assumeIsolated {
    var actor = Actor(name: "Sally Fields")
    actor.movies = [sampleSpiderman]
    return actor
}

var sampleMovieList: [Movie] = MainActor.assumeIsolated {
    var movies: [Movie] = [
        sampleSpiderman,
        sampleBatman,
        Movie(title: "Superman", year: 2019),
        Movie(title: "Up", year: 2007),
    ]
    return movies
}

var sampleActorList: [Actor] = MainActor.assumeIsolated {
    var actors: [Actor] = [
        sampleTomHanks,
        sampleSallyFields,
        Actor(name: "Tom Cruise"),
        Actor(name: "Bugs Bunny"),
    ]
    return actors
}

// @MainActor
let previewContainer: ModelContainer = MainActor.assumeIsolated {
    // create the container used
    let container = getPreviewContainer()

    // add in any default data
    for movie in sampleMovieList {
        container.mainContext.insert(object: movie)
    }

    return container
}

func getPreviewContainer() -> ModelContainer {
    do {
        // create the container used
        let container = try ModelContainer(
            for: [Movie.self, Review.self, Actor.self],
            ModelConfiguration(inMemory: true)
        )
        return container
    } catch {
        fatalError("Failed to create container")
    }
}
