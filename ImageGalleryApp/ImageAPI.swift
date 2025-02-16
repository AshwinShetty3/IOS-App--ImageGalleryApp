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

    func fetchPhotos(completion: @escaping ([Photo]?) -> Void) {
        let urlString = "https://api.unsplash.com/photos/?client_id=\(accessKey)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching photos: \(error)")
                completion(nil)
                return
            }

            if let data = data {
                do {
                    let photos = try JSONDecoder().decode([Photo].self, from: data)
                    completion(photos)
                } catch {
                    print("Error decoding photos: \(error)")
                    completion(nil)
                }
            }
        }.resume()
    }
}


enum APIError: Error {
    case invalidURL
    case noData
}
