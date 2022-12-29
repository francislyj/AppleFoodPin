//
//  RestaurantDetailView.swift
//  AppleFoodPin
//
//  Created by user on 2022/12/28.
//

import SwiftUI

struct RestaurantDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var restaurant: Restaurant
    
    
    var body: some View {
//        ZStack (alignment: .top) {
//            Image(restaurant.image)
//                .resizable()
//                .scaledToFill()
//                .frame(minWidth: 0, maxWidth: .infinity)
//                .ignoresSafeArea()
//
//            Color.black
//                .frame(height: 100)
//                .opacity(0.8)
//                .cornerRadius(20)
//                .padding()
//                .overlay {
//                    VStack {
//                        Text(restaurant.name)
//                        Text(restaurant.type)
//                        Text(restaurant.location)
//                    }
//                    .font(.system(.headline, design: .rounded))
//                    .foregroundColor(.white)
//                }
//
//        }
        ScrollView {
            VStack {
                Image(restaurant.image)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 445)
                    .overlay {
                        VStack {
                            Image(systemName: restaurant.isFavorite ? "heart.fill" : "heart")
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
                                .padding()
                                .font(.system(size: 30))
                                .foregroundColor(.indigo)
                                .padding(.top, 40)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(restaurant.name)
                                    .font(.custom("Nunito-Regular", size: 35, relativeTo: .largeTitle))
                                    .bold()
                                
                                Text(restaurant.type)
                                    .font(.system(.headline, design: .rounded))
                                    .padding(.all, 5)
                                    .background(.black)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
                            .foregroundColor(.white)
                            .padding()
                        }
                    }
                
                Text(restaurant.description)
                    .padding()
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("ADDRESS")
                            .font(.system(.headline, design: .rounded))
                        Text(restaurant.location)
    
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        Text("PHONE")
                            .font(.system(.headline, design: .rounded))
                        Text(restaurant.phone)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
                
                
            }
            
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("\(Image(systemName: "chevron.left"))")
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RestaurantDetailView(restaurant: Restaurant(name: "Royal Oak", type: "British", location: "2 Regency Street London SW1P 4BZ United Kingdom", phone: "343-988834", description: "Specialise in great pub food. Established in 1872, we have local and world lagers, craft beer and a selection of wine and spirits for people to enjoy. Don't forget to try our range of Young's Ales and Fish and Chips.", image: "royaloak", isFavorite: true))
        }.accentColor(.white)
    }
}
