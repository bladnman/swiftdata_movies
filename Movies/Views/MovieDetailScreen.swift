//
//  MovieDetailScreen.swift
//  Movies
//
//  Created by Matt Maher on 7/25/23.
//

import SwiftData
import SwiftUI

struct MovieDetailScreen: View {
    let movie: Movie

    @State private var title: String = ""
    @State private var year: Int?
    @State private var showReviewScreen: Bool = false

    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", value: $year, format: .number)
            Button("Update") {
                guard let year = year else { return }
                movie.name = title
                movie.year = year
            }
            .buttonStyle(.borderless)

            Section("Reviews") {
                Button(action: {
                    showReviewScreen = true
                }, label: {
                    Image(systemName: "plus")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })

                if movie.reviews.isEmpty {
                    ContentUnavailableView {
                        Text("No reviews")
                    }
                } else {
                    ReviewListView(movie: movie)
                }
            }

            Section("Actors") {
                if movie.actors.isEmpty {
                    ContentUnavailableView {
                        Text("No actors available")
                    }
                } else {
                    List(movie.actors) { actor in
                        ActorCellView(actor: actor)
                    }
                }
            }
        }
        .onAppear {
            title = movie.name
            year = movie.year
        }
        .sheet(isPresented: $showReviewScreen, content: {
            NavigationStack {
                AddReviewScreen(movie: movie)
            }
        })
    }
}

#Preview {
    MyPreviewer {
        NavigationStack {
            MovieDetailScreen(movie: sampleSpiderman)
        }
    }
}
