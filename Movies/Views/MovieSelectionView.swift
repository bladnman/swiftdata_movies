//
//  MovieSelectionView.swift
//  Movies
//
//  Created by Matt Maher on 7/25/23.
//

import SwiftData
import SwiftUI

struct MovieSelectionView: View {
    @Query(sort: \.title, order: .forward) private var movies: [Movie]
    @Binding var selectedMovies: Set<Movie>

    var body: some View {
        List(movies) { movie in
            HStack {
                Image(systemName: selectedMovies.contains(movie) ? "checkmark.square" : "square")
                    .onTapGesture {
                        if !selectedMovies.contains(movie) {
                            selectedMovies.insert(movie)
                        } else {
                            selectedMovies.remove(movie)
                        }
                    }
                Text(movie.title)
            }
        }
    }
}

struct _MovieSelectionViewWrapper: View {
    @State private var selectedMovies: Set<Movie> = Set()
    var body: some View {
        MovieSelectionView(selectedMovies: $selectedMovies)
    }
}

#Preview {
    MyPreviewer {
        _MovieSelectionViewWrapper()
    }
}
