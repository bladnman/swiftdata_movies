//
//  MoviesApp.swift
//  Movies
//
//  Created by Mohammad Azam on 6/6/23.
//

import SwiftData
import SwiftUI

@main
struct MoviesApp: App {
    let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(for: Movie.self, migrationPlan: MoviesMigrationPlan.self, ModelConfiguration(for: Movie.self))
        } catch {
            fatalError("Could not initialize the container")
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MovieListScreen()
            }
        }.modelContainer(container)
    }
}
