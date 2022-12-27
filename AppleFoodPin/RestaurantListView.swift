//
//  ContentView.swift
//  AppleFoodPin
//
//  Created by user on 2022/12/21.
//

import SwiftUI

struct RestaurantListView: View {
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]

    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    @State var restaurantIsFavourites = Array(repeating: false, count: 21)
    
    var body: some View {
        List(restaurantNames.indices, id: \.self){ index in
            BasicTextImageRow(imageName: restaurantImages[index], name: restaurantNames[index], type: restaurantTypes[index], location: restaurantLocations[index], isFavourite: $restaurantIsFavourites[index])
        }
        .listStyle(.plain)
    }
}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
        
        RestaurantListView()
            .preferredColorScheme(.dark)
        
        BasicTextImageRow(imageName: "cafedeadend", name: "cafedeadend", type: "aa", location: "Shang hai", isFavourite: .constant(true))
            .previewLayout(.sizeThatFits)
        
        FullImageRow(imageName: "cafedeadend", name: "cafedeadend", type: "aa", location: "Shang hai", isFavourite: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}

struct BasicTextImageRow: View {
    var imageName: String
    var name: String
    var type: String
    var location: String
    
    @Binding var isFavourite: Bool
    
    @State private var showOptions = false
    @State private var showError = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(imageName)
                .resizable()
                .frame(width: 120, height: 118)
                .cornerRadius(20)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.system(.title2, design: .rounded))
                
                Text(type)
                    .font(.system(.body, design: .rounded))
                
                Text(location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            
            if (isFavourite){
                Spacer()
                
                Image(systemName: "heart.fill")
                    .foregroundColor(.green)
            }
        }
        .listRowSeparator(.hidden)
        .onTapGesture {
            showOptions.toggle()
        }
        .actionSheet(isPresented: $showOptions) {
            ActionSheet(title: Text("What do you want to do?"), message: nil, buttons: [
                .default(Text("Reserve a table")) {
                    showError.toggle()
                },
                .default(Text(isFavourite ? "Remove from favourites": "Make a favourite")){
                    isFavourite.toggle()
                },
                .cancel()
            ])
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Not yet avaliable"), message: Text("Sorry, this feature is not avaliable yet, please retry later."), primaryButton: .default(Text("Ok")), secondaryButton: .cancel())
        }
    }
}

struct FullImageRow: View {
    
    var imageName: String
    var name: String
    var type: String
    var location: String
    
    @Binding var isFavourite: Bool
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .cornerRadius(20)
            
            HStack(alignment: .top, spacing: 10) {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(.title2, design: .rounded))
                    
                    Text(type)
                        .font(.system(.body, design: .rounded))
                    
                    Text(location)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                if(isFavourite){
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.yellow)
                }
            }
        }
        .listRowSeparator(.hidden)
    }
}
