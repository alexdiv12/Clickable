//
//  DetailView.swift
//  UnsplashImages
//
//  Created by Divyanshu rai on 13/09/24.
//

import SwiftUI

import SwiftUI

struct DetailView: View {
    var photo: Photos
   
    // State variable to track favorite status
    @State private var isFavorited: Bool = false
    @State private var isFavorites = false // State to show favorites view

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: photo.urls.regular)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 360, height: 350)
                    .padding(.top,10)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .frame(height: 150)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))

            Text("Information about Images")
                .font(.title)
                .padding(.top, 10)
Spacer()
            VStack(spacing: 10) {
                Grid {
                    GridRow {
                        Text("Photo Id")
                            .font(.headline)
                            .padding(.leading,-10)
                        Spacer()
                        Text("\(photo.id)")
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                    }
                    GridRow {
                        Text("Description")
                            .font(.headline)
                            .padding(.leading,-10)
                        Spacer()
                        Text(photo.description?.isEmpty == false ? photo.description! : "Not available")
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                    }
                    GridRow {
                        Text("More Info")
                            .font(.headline)
                        Spacer()
                        Text(photo.alt_description?.isEmpty == false ? photo.alt_description! : "Not available")
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                    }
                    GridRow {
                        Text("Creation Info")
                            .font(.headline)
                        Spacer()
                        Text(formatISODate(photo.created_at, toFormat: "dd/MM/yyyy HH:mm:ss") ?? "Not available")
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                    }
                    GridRow {
                        Text("Updation Info")
                            .font(.headline)
                        Spacer()
                        Text(formatISODate(photo.updated_at, toFormat: "dd/MM/yyyy HH:mm:ss") ?? "Not available")
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(.trailing, 10)
                .padding(.horizontal, 40)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            
            // Favorite Button
            Button(action: {
                isFavorited.toggle() 
                fetchFavourite()
            }) {
                Image(systemName: isFavorited ? "heart.fill" : "heart")
                    .font(.system(size: 30))
                    .foregroundColor(isFavorited ? .red : .gray)
                    .padding()
            }
        }
        .padding(.horizontal, 20)
        .navigationTitle("Images")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isFavorites.toggle()
                    fetchFavourite()
                }) {
                    Image(systemName: isFavorites ? "heart.fill" : "heart") //
                        .font(.system(size: 24))
                }
            }
        }
        
    }

    private func fetchFavourite() {
        if isFavorited {
            FavoritesManager.shared.add(photo: photo)
        } else {
            FavoritesManager.shared.remove(photo: photo)
        }
    }
}

#Preview {
    DetailView(photo: Photos.mock)
}
