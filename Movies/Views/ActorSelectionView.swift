//
//  ActorSelectionView.swift
//  Movies
//
//  Created by Matt Maher on 7/25/23.
//

import SwiftData
import SwiftUI

struct ActorSelectionView: View {
    @Query(sort: \.name, order: .forward) private var actors: [Actor]
    @Binding var selectedActors: Set<Actor>

    var body: some View {
        List(actors) { actor in
            HStack {
                Image(systemName: selectedActors.contains(actor) ? "checkmark.square" : "square")
                    .onTapGesture {
                        if !selectedActors.contains(actor) {
                            selectedActors.insert(actor)
                        } else {
                            selectedActors.remove(actor)
                        }
                    }
                Text(actor.name)
            }
        }
    }
}

struct _ActorSelectionViewWrapper: View {
    @State private var selectedActors: Set<Actor> = Set()
    var body: some View {
        ActorSelectionView(selectedActors: $selectedActors)
    }
}

#Preview {
    MyPreviewer {
        _ActorSelectionViewWrapper()
    }
}
