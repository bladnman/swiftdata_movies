//
//  ActorCellView.swift
//  Movies
//
//  Created by Matt Maher on 7/25/23.
//

import SwiftData
import SwiftUI

struct ActorCellView: View {
    let actor: Actor

    var body: some View {
        VStack(alignment: .leading) {
            Text(actor.name)
            Text(actor.movies.map { $0.title }, format: .list(type: .and))
                .font(.caption)
        }
    }
}

#Preview {
    MyPreviewer {
        ActorCellView(actor: sampleTomHanks)
    }
}
