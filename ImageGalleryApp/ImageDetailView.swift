//
//  ImageDetailView.swift
//  ImageGalleryApp
//
//  Created by Ashwin Shetty on 15/02/25.
//

import SwiftUI

struct ImageDetailView: View {
    let photo: Photo
    @Binding var favourites: [Photo]

    var isFavourite: Bool {
        favourites.contains(where: { $0.id == photo.id })
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
// Display the full image on click
                AsyncImage(url: URL(string: photo.urls.full)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 550)

//Displaying Desc
                if let description = photo.description {
                    Text(description)
                        .font(.body)
                        .padding(.horizontal)
                } else {
                    Text("This Photo is taken from unsplash.com")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }

// Displaying name of a person
                Text("By: \(photo.user.name)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.horizontal)

                Spacer()

                // Like and Share buttons
                HStack {
                    Button(action: {
                        if isFavourite {
                            if let index = favourites.firstIndex(where: { $0.id == photo.id }) {
                                favourites.remove(at: index)
                            }
                        } else {
                            favourites.append(photo)
                        }
                    }) {
                        Image(systemName: isFavourite ? "heart.fill" : "heart")
                            .foregroundColor(isFavourite ? .red : .gray)
                    }
                    ShareLink(item: photo.urls.full) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle("Photo Detail")
    }
}
