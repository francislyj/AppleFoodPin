//
//  DiscoverView.swift
//  AppleFoodPin
//
//  Created by user on 2023/1/11.
//

import SwiftUI
import CloudKit

struct DiscoverView: View {
    
    @StateObject private var cloudStore: RestaurantCloudStore = RestaurantCloudStore()
    
    @State private var showLoadingIndicator = false
    
    private func getImageURL(restaurant: CKRecord) -> URL? {
        guard let image = restaurant.object(forKey: "image"),
              let imageAsset = image as? CKAsset else {
            return nil
        }

        return imageAsset.fileURL
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                List(cloudStore.restaurants, id: \.recordID) { restaurant in
                    HStack {
                        AsyncImage(url: getImageURL(restaurant: restaurant)){ image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.purple.opacity(0.1)
                        }
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)

                        Text(restaurant.object(forKey: "name") as! String)
                    }
                }
                .listStyle(PlainListStyle())
                .task {
    //                do {
    //                    try await cloudStore.fetchRestaurants()
    //                } catch {
    //                    print(error)
    //                }
                    
//                    cloudStore.fetchRestaurantsWithOperational {
//                        showLoadingIndicator = false
//                    }
                }
                .navigationTitle("Discover")
                .navigationBarTitleDisplayMode(.automatic)
                .onAppear() {
                    showLoadingIndicator = true
                }
                .refreshable {
                    cloudStore.fetchRestaurantsWithOperational {
                        showLoadingIndicator = false
                    }
                }
                
                if showLoadingIndicator {
                    ProgressView()
                }
            }

        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
