//
//  ViewModel.swift
//  UnsplashImages
//
//  Created by Divyanshu rai on 13/09/24.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var photos = [Photos]()
    
    func fetchImages() {
        let accessKey = "CH2tApwaB5AvxKt3b1Yj1zVOmm0kWXWqBA05eAPMec0"
        let baseUrl = "https://api.unsplash.com/photos"
        let urlString = "\(baseUrl)?client_id=\(accessKey)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching images: \(error)")
                return
            }
            
            guard let data = data else {
                print("Invalid data")
                return
            }
            
            do {
                let images = try JSONDecoder().decode([Photos].self, from: data)
                DispatchQueue.main.async {
                    self?.photos = images
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }
        task.resume()
    }
}

class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()
    
    @Published var favoritePhotos: [Photos] = []
    
    private init() {}
    
    func add(photo: Photos) {
        if !favoritePhotos.contains(where: { $0.id == photo.id }) {
            favoritePhotos.append(photo)
        }
    }
    
    func remove(photo: Photos) {
        favoritePhotos.removeAll { $0.id == photo.id }
    }
    
    func isFavorite(photo: Photos) -> Bool {
        favoritePhotos.contains(where: { $0.id == photo.id })
    }
}
import Foundation


func formatISODate(_ isoDateString: String, toFormat: String) -> String? {
    let isoFormatter = ISO8601DateFormatter()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = toFormat
    
 
    guard let date = isoFormatter.date(from: isoDateString) else {
        print("Date conversion failed for string: \(isoDateString)")
        return nil
    }
    
  
    return dateFormatter.string(from: date)
}
