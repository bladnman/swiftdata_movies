//
//  ovieListView.swift
//  Movies
//
//  Created by Matt Maher on 7/25/23.
//

import SwiftData
import SwiftUI

struct MovieListView: View {
    @Environment(\.modelContext) private var context;
    let movies: [Movie]

    private func deleteMovie(indexSet: IndexSet) {
        indexSet.forEach { index in
            let movie = movies[index]
            context.delete(movie)
        }
    }

    var body: some View {
        List {
            ForEach(movies) { movie in
                NavigationLink(value: movie) {
                    HStack {
                        Text(movie.title)
                        Spacer()
                        Text(movie.year.description)
                    }
                }
            }.onDelete(perform: deleteMovie)
        }
        .navigationDestination(for: Movie.self) { movie in
            MovieDetailScreen(movie: movie)
        }
    }
}

#Preview {
    MyPreviewer {
        MovieListView(movies: sampleMovieList)
    }
}
