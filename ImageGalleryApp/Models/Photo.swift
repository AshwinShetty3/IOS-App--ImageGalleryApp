//
//  Photo.swift
//  ImageGalleryApp
//
//  Created by Ashwin Shetty on 15/02/25.
//

import Foundation

struct Photo: Codable, Identifiable {
    let id: String
    let urls: PhotoURLs
    let description: String?
    let altDescription: String?
    let user: User
    let likes: Int

    struct PhotoURLs: Codable {
        let small: String
        let full: String
    }

    struct User: Codable {
        let name: String
    }
}

