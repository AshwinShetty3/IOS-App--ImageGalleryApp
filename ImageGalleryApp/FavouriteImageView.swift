//
//  FavouriteImageView.swift
//  ImageGalleryApp
//
//  Created by Ashwin Shetty on 15/02/25.
//

import SwiftUI

struct FavouritesImageView: View {
    @Binding var favourites: [Photo]

    var body: some View {
        List {
            ForEach(favourites) { photo in
                NavigationLink(destination: ImageDetailView(photo: photo, favourites: $favourites)) {
                    HStack {
                        AsyncImage(url: URL(string: photo.urls.small)) { Photo in
                            Photo.resizable().scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                        Text(photo.description ?? "Short By Ashwin")
                            .font(.caption)
                        Spacer()
                        Button(action: {
                            // Remove the photo from favourites
                            if let index = favourites.firstIndex(where: { $0.id == photo.id }) {
                                favourites.remove(at: index)
                            }
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .onDelete(perform: deleteFavourite)
        }
        .navigationTitle("Favourites")
        .toolbar {
            EditButton()
        }
    }

//swipe-to-delete
    private func deleteFavourite(at offsets: IndexSet) {
        favourites.remove(atOffsets: offsets)
    }
}
