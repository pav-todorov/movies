//
//  FavoritesDetailView.swift
//  Favorites
//
//  Created by Pavel on 9.07.22.
//

import SwiftUI
import Shared_Models

// MARK: - Favorites Detail View
struct FavoritesDetailView: View {
    // MARK: Properties
    var movieModel: Movie
    
    var body: some View {
                ScrollView {
                    AsyncImage(url: URL(string: "\(Keys.baseImageURL)\(movieModel.posterPath ?? "")")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 250, height: 280)

                    Text(movieModel.overview ?? "")
                        .padding()
                } //: ScrollView
            .navigationTitle(movieModel.title ?? "")
    }
}

struct FavoritesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
