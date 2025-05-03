//
//  FavouriteView.swift
//  UnsplashImages
//
//  Created by Divyanshu rai on 13/09/24.
//

import SwiftUI
import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        
            List(favoritesManager.favoritePhotos) { photo in
                AsyncImage(url: URL(string: photo.urls.regular)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 100)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(5)
            }
            .navigationTitle("Favorite Images")
        }
    }



#Preview {
    FavoritesView()
}
