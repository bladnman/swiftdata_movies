//
//  FilterScreen.swift
//  Movies
//
//  Created by Matt Maher on 7/26/23.
//

import SwiftData
import SwiftUI

enum FilterOption {
    case title(String)
    case reviewsCount(Int)
    case actorsCount(Int)
    case none
}

struct FilterSelectionScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var movieTitle: String = ""
    @State private var numberOfReviews: Int?
    @State private var numberOfActors: Int?
    @Binding var filterOption: FilterOption

    var body: some View {
        Form {
            Section("Filter by title") {
                TextField("Movie title", text: $movieTitle)
                Button("Search") {
                    filterOption = .title(movieTitle)
                    dismiss()
                }
            }
            Section("Filter by number of reviews") {
                TextField("Number of reviews", value: $numberOfReviews, format: .number)
                Button("Search") {
                    filterOption = .reviewsCount(numberOfReviews ?? 1)
                    dismiss()
                }
            }
            Section("Filter by number of actors") {
                TextField("Number of actors", value: $numberOfActors, format: .number)
                Button("Search") {
                    filterOption = .actorsCount(numberOfActors ?? 1)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    MyPreviewer {
        FilterSelectionScreen(filterOption: .constant(.title("Batman")))
    }
}
