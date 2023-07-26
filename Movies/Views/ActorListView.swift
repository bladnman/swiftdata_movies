//
//  ActorListView.swift
//  Movies
//
//  Created by Matt Maher on 7/25/23.
//

import SwiftUI

struct ActorListView: View {
    let actors: [Actor]

    var body: some View {
        List(actors) { actor in
            NavigationLink(value: actor) {
                ActorCellView(actor: actor)
            }
            .navigationDestination(for: Actor.self) { actor in
                ActorDetailScreen(actor: actor)
            }
        }
    }
}

#Preview {
    MyPreviewer {
        ActorListView(actors: sampleActorList)
    }
}
