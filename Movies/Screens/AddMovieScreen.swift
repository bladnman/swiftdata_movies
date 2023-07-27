//
//  AddMovieScreen.swift
//  Movies
//
//  Created by Mohammad Azam on 6/6/23.
//

import SwiftData
import SwiftUI

struct AddMovieScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var name: String = ""
    @State private var year: Int?
    
    @State private var selectedActors: Set<Actor> = Set()
    
    private var isFormValid: Bool {
        !name.isEmptyOrWhiteSpace && year != nil && !selectedActors.isEmpty
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $name)
            TextField("Year", value: $year, format: .number)
            
            Section("Select Actors") {
                ActorSelectionView(selectedActors: $selectedActors)
            }
        }
        .navigationTitle("Add Movie")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    guard let year = year else { return }
                    
                    let movie = Movie(name: name, year: year)
                    movie.actors = Array(selectedActors)

                    selectedActors.forEach { actor in
                        actor.movies.append(movie)
                        context.insert(actor)
                    }
                    
                    context.insert(movie)
                    
                    do {
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    dismiss()
                    
                }.disabled(!isFormValid)
            }
        }
    }
}

#Preview {
    MyPreviewer {
        NavigationStack {
            AddMovieScreen()
        }
    }
}
