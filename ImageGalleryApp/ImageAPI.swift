//
//  ImageAPI.swift
//  ImageGalleryApp
//
//  Created by Ashwin Shetty on 15/02/25.
//

import Foundation

class ImageAPI {
    static let shared = ImageAPI()
    private let accessKey = "vD5LvOxjMjDI6ARcnXW8ocUcp0BwIab5eGv_wWGaJ_Y"

    private init() {}

    // Update the fetchPhotos method to include error handling
    func fetchPhotos(completion: @escaping (Result<[Photo], APIError>) -> Void) {
        let urlString = "https://api.unsplash.com/photos/?client_id=\(accessKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching photos: \(error)")
                completion(.failure(.noData))
                return
            }

            if let data = data {
                do {
                    let photos = try JSONDecoder().decode([Photo].self, from: data)
                    completion(.success(photos))
                } catch {
                    print("Error decoding photos: \(error)")
                    completion(.failure(.noData))
                }
            } else {
                completion(.failure(.noData))
            }
        }.resume()
    }
}

// Define the APIError enum
enum APIError: Error {
    case invalidURL
    case noData
}

// photo likes count
func fetchAndPrintPhotos() {
    ImageAPI.shared.fetchPhotos { result in
        switch result {
        case .success(let photos):
            for photo in photos {
                print("Name: \(photo.user.name), Likes: \(photo.likes)")
            }
        case .failure(let error):
            print("Error: \(error)")
        }
    }
}
