//
//  MovieListScreen.swift
//  Movies
//
//  Created by Matt Maher on 7/25/23.
//

import SwiftData
import SwiftUI

struct MovieListScreen: View {
    @Environment(\.modelContext) private var context

    @Query(sort: \.title, order: .forward) private var movies: [Movie]
    @Query(sort: \.name, order: .forward) private var actors: [Actor]

    @State private var isAddMoviePresented: Bool = false
    @State private var isAddActorPresented: Bool = false
    @State private var actorName: String = ""

    private func saveActor() {
        let actor = Actor(name: actorName)
        context.insert(actor)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Movies")
                .font(.largeTitle)
            MovieListView(movies: movies)

            Text("Actors")
                .font(.largeTitle)
            ActorListView(actors: actors)
        }
        .padding()
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button("Add Actor") {
                    isAddActorPresented = true
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Movie") {
                    isAddMoviePresented = true
                }
            }
        })
        .sheet(isPresented: $isAddMoviePresented, content: {
            NavigationStack {
                AddMovieScreen()
            }
        })
        .sheet(isPresented: $isAddActorPresented, content: {
            Text("Add Actor")
                .font(.largeTitle)
                .presentationDetents([.fraction(0.25)])
            TextField("Actor name", text: $actorName)
                .textFieldStyle(.roundedBorder)
                .padding()

            Button("Save") {
                isAddActorPresented = false
                saveActor()
            }
        })
    }
}

#Preview {
    MyPreviewer {
        NavigationStack {
            MovieListScreen()
        }
    }
}
