//
//  MovieListScreen.swift
//  Movies
//
//  Created by Matt Maher on 7/25/23.
//

import SwiftData
import SwiftUI

enum Sheets: Identifiable {
    case addMovie
    case addActor
    case showFilter

    var id: Int {
        hashValue
    }
}

struct MovieListScreen: View {
    @Environment(\.modelContext) private var context

    @Query(sort: \.title, order: .forward) private var movies: [Movie]
    @Query(sort: \.name, order: .forward) private var actors: [Actor]

    @State private var actorName: String = ""
    @State private var activeSheet: Sheets?

    @State private var filterOption: FilterOption = .none

    private func saveActor() {
        let actor = Actor(name: actorName)
        context.insert(actor)
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text("Movies")
                    .font(.largeTitle)
                Spacer()
                Button("Filter") {
                    activeSheet = .showFilter
                }
            }

            MovieListView(filterOption: filterOption)

            Text("Actors")
                .font(.largeTitle)
            ActorListView(actors: actors)
        }
        .padding()
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button("Add Actor") {
                    activeSheet = .addActor
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Movie") {
                    activeSheet = .addMovie
                }
            }
        })
        .sheet(item: $activeSheet, content: { activeSheet in
            switch activeSheet {
            case .addMovie:
                NavigationStack {
                    AddMovieScreen()
                }
            case .addActor:
                Text("Add Actor")
                    .font(.largeTitle)
                    .presentationDetents([.fraction(0.25)])
                TextField("Actor name", text: $actorName)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                Button("Save") {
                    saveActor()
                    self.activeSheet = nil
                }
            case .showFilter:
                FilterSelectionScreen(filterOption: $filterOption)
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
