//
//  ContentView.swift
//  AppleFoodPin
//
//  Created by user on 2022/12/21.
//

import SwiftUI

struct RestaurantListView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        entity: Restaurant.entity(),
        sortDescriptors: [])
    var restaurants: FetchedResults<Restaurant>
    
    @State private var showNewRestaurant = false
    
    @State private var searchText = ""
    
    @State private var showWalkthrough = false
    
    @AppStorage("hasViewedWalkthrough") var hasViewedWalkthrough: Bool = false
    
    private func prepareNotification() {
        // Make sure the restaurant array is not empty
        if restaurants.count <= 0 {
            return
        }

        // Pick a restaurant randomly
        let randomNum = Int.random(in: 0..<restaurants.count)
        let suggestedRestaurant = restaurants[randomNum]

        // Create the user notification
        let content = UNMutableNotificationContent()
        content.title = "Restaurant Recommendation"
        content.subtitle = "Try new food today"
        content.body = "I recommend you to check out \(suggestedRestaurant.name). The restaurant is one of your favorites. It is located at \(suggestedRestaurant.location). Would you like to give it a try?"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "foodpin.restaurantSuggestion", content: content, trigger: trigger)

        // Schedule the notification
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
    private func deleteRecord(indexSet: IndexSet) {
        
        for index in indexSet {
            let itemToDelete = restaurants[index]
            context.delete(itemToDelete)
                
        }
        
        DispatchQueue.main.async {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
        
        
    }
    
    var body: some View {
        NavigationView {
            List {
                if restaurants.count == 0 {
                    Image("emptydata")
                        .resizable()
                        .scaledToFit()
                } else {
                    ForEach(restaurants.indices, id: \.self) { index in
                        ZStack(alignment: .leading) {
                            NavigationLink(destination: RestaurantDetailView(restaurant: restaurants[index])) {
    //                            BasicTextImageRow(restaurant: $restaurants[index])
                                EmptyView()
                            }
                            .opacity(0)
                            
                            
                            BasicTextImageRow(restaurant: restaurants[index])
                        }
                    }
                    .onDelete(perform: deleteRecord)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            
            .navigationTitle("FoodPin")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                Button {
                    self.showNewRestaurant = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
        }
        .onAppear() {
            showWalkthrough = hasViewedWalkthrough ? false : true
        }
        .sheet(isPresented: $showNewRestaurant) {
            NewRestaurantView()
        }
        .accentColor(.green)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search restaurants ...") {
            Text("Thai").searchCompletion("Thai")
            Text("Cafe").searchCompletion("aaa")
        }
        .onChange(of: searchText) { searchText in
            let predicate = searchText.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "name CONTAINS[c] %@", searchText)
            
            restaurants.nsPredicate = predicate
        }
        .sheet(isPresented: $showWalkthrough) {
            TutorialView()
        }
        .onOpenURL(perform: { url in
            switch url.path {
            case "NewRestaurant":
                showNewRestaurant = true
            default:
                return
            }
            
        })
        .task {
            print("restaurant task begin prepareNotification")
            prepareNotification()
        }
    }
}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
        RestaurantListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.dark)
        
        BasicTextImageRow(restaurant: (PersistenceController.testData?.first)!)
            .previewLayout(.sizeThatFits)
        
        FullImageRow(imageName: "cafedeadend", name: "cafedeadend", type: "aa", location: "Shang hai", isFavourite: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}

struct BasicTextImageRow: View {
    
    // MARK: - Binding
    
    @ObservedObject var restaurant: Restaurant
    
    // MARK: - State variables
    @State private var showOptions = false
    @State private var showError = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            
            if let imageData = restaurant.image {
                Image(uiImage: UIImage(data: imageData) ?? UIImage())
                    .resizable()
                    .frame(width: 120, height: 118)
                    .cornerRadius(20)
            }
                
            
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.system(.title2, design: .rounded))
                
                Text(restaurant.type)
                    .font(.system(.body, design: .rounded))
                
                Text(restaurant.type)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            
            if (restaurant.isFavorite){
                Spacer()
                
                Image(systemName: "heart.fill")
                    .foregroundColor(.indigo)
            }
        }
        .listRowSeparator(.hidden)
        .contextMenu {
            Button(action: {
                self.showError.toggle()
            }){
                HStack {
                    Text("Reserve a table")
                    Image(systemName: "phone")
                }
            }
            
            Button {
                restaurant.isFavorite.toggle()
            } label: {
                HStack {
                    Text(restaurant.isFavorite ? "Remove from favourites" : "Make a favourite")
                    Image(systemName: "heart")
                }
            }
            
            Button {
                showOptions.toggle()
            } label: {
                HStack {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .sheet(isPresented: $showOptions) {
            let defaultText = "Just checking in at \(restaurant.name)"
            
            if let imageData = restaurant.image, let imageToShare = UIImage(data: imageData) {
                ActivityView(activityItems: [defaultText, imageToShare])
            } else {
                ActivityView(activityItems: [defaultText])
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false, content: {
            Button {
                restaurant.isFavorite.toggle()
            } label: {
                Image(systemName: "heart")
            }
            .tint(.green)

            Button {
                showOptions.toggle()
            
            }label: {
                Image(systemName: "square.and.arrow.up")
            }
            .tint(.orange)
    })
//        .onTapGesture {
//            showOptions.toggle()
//        }
//        .actionSheet(isPresented: $showOptions) {
//            ActionSheet(title: Text("What do you want to do?"), message: nil, buttons: [
//                .default(Text("Reserve a table")) {
//                    showError.toggle()
//                },
//                .default(Text(restaurant.isFavorite ? "Remove from favourites" : "Make a favourite")) {
//                    restaurant.isFavorite.toggle()
//                },
//                .cancel()
//            ])
//        }
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
