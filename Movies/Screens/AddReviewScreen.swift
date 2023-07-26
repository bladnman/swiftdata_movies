//
//  AddReviewScreen.swift
//  Movies
//
//  Created by Matt Maher on 7/25/23.
//

import SwiftData
import SwiftUI

struct AddReviewScreen: View {
    let movie: Movie

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context

    @State private var subject: String = ""
    @State private var description: String = ""

    private var isFormValid: Bool {
        return !subject.isEmptyOrWhiteSpace && !description.isEmptyOrWhiteSpace
    }

    var body: some View {
        Form {
            TextField("Subject", text: $subject)
            TextField("Description", text: $description)
        }
        .navigationTitle("Add Review")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    let review = Review(subject: subject, body: description)
                    review.movie = movie
                    context.insert(review)

                    movie.reviews.append(review)

                    dismiss()
                }
                .disabled(!isFormValid)
            }
        }
    }
}

#Preview {
    MyPreviewer {
        NavigationStack {
            AddReviewScreen(movie: sampleSpiderman)
        }
    }
}
