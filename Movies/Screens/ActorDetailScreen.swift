//
//  ActorDetailScreen.swift
//  Movies
//
//  Created by Matt Maher on 7/25/23.
//

import SwiftData
import SwiftUI

struct ActorDetailScreen: View {
    @Environment(\.modelContext) private var context
    var actor: Actor
    @State private var selectedMovies: Set<Movie> = []

    var body: some View {
        VStack {
            MovieSelectionView(selectedMovies: $selectedMovies)
                .onAppear {
                    selectedMovies = Set(actor.movies)
                }
        }
        .onChange(of: selectedMovies) { _, _ in
            actor.movies = Array(selectedMovies)
            context.insert(actor)
        }
        .navigationTitle(actor.name)
    }
}

#Preview {
    MyPreviewer {
        NavigationStack {
            ActorDetailScreen(actor: sampleTomHanks)
        }
    }
}
