//
//  ContentView.swift
//  ImageGalleryApp
//
//  Created by Ashwin Shetty on 15/02/25.
//

import SwiftUI

struct ImageContentView: View {
    @State private var photos: [Photo] = []
    @State private var searchText = ""
    @State private var favourites: [Photo] = []
    @State private var isLandscape = UIDevice.current.orientation.isLandscape

    var filteredPhotos: [Photo] {
        if searchText.isEmpty {
            return photos
        } else {
            return photos.filter { $0.description?.lowercased().contains(searchText.lowercased()) ?? false }
        }
    }

    var body: some View {
        NavigationView {
            
            ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: isLandscape ? 20 : 10), count: isLandscape ? 5 : 3), spacing: isLandscape ? 20 : 10) {
                            ForEach(filteredPhotos) { photo in
                                NavigationLink(destination: ImageDetailView(photo: photo, favourites: $favourites)) {
                                    AsyncImage(url: URL(string: photo.urls.small)) { image in
                                        image.resizable().scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: isLandscape ? 120 : 120, height: isLandscape ? 150 : 160)
                                    .cornerRadius(8)
                                }
                            }
                        }
                        .padding()
            }
            .navigationTitle("Image Gallery")
            .toolbar {
                NavigationLink(destination: FavouritesImageView(favourites: $favourites)) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
        .onAppear {
            ImageAPI.shared.fetchPhotos { fetchedPhotos in
                if let fetchedPhotos = fetchedPhotos {
                    photos = fetchedPhotos
                }
            }
        }

    }
}

