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
    @Query private var movies: [Movie]

    let filterOption: FilterOption

    init(filterOption: FilterOption = .none) {
        self.filterOption = filterOption
        switch self.filterOption {
        case .title(let movieTitle):
            // dynamic predicate
            _movies = Query(filter: #Predicate {
//                $0.title.localizedLowercase.contains(movieTitle.localizedLowercase)
                $0.title.contains(movieTitle)
            })
        case .reviewsCount(let numberOfReviews):
            // dynamic predicate
            _movies = Query(filter: #Predicate { $0.reviews.count >= numberOfReviews })
        case .actorsCount(let numberOfActors):
            // dynamic predicate
            _movies = Query(filter: #Predicate { $0.actors.count >= numberOfActors })
        case .none:
            _movies = Query()
        }
    }

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
                        VStack(alignment: .leading) {
                            Text(movie.title)
                            Text("\(movie.reviewsCount) reviews")
                                .font(.caption)
                            Text("\(movie.actorsCount) actors")
                                .font(.caption)
                        }
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
        MovieListView(filterOption: .none)
    }
}
