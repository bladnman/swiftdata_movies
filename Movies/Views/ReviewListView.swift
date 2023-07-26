//
//  ReviewListView.swift
//  Movies
//
//  Created by Matt Maher on 7/25/23.
//

import SwiftData
import SwiftUI

struct ReviewListView: View {
    let movie: Movie

    @Environment(\.modelContext) private var context;

    private func delete(indexSet: IndexSet) {
        indexSet.forEach { index in
            context.delete(movie.reviews[index])
            movie.reviews.remove(at: index)
        }
    }

    var body: some View {
        List {
            ForEach(movie.reviews) { review in
                VStack(alignment: .leading) {
                    Text(review.subject)
                        .font(.headline)
                    Text(review.body)
                        .font(.subheadline)
                }
            }
            .onDelete(perform: delete)
        }
    }
}

#Preview {
    MyPreviewer {
        ReviewListView(movie: sampleSpiderman)
    }
}
