//
//  NewRestaurantView.swift
//  AppleFoodPin
//
//  Created by user on 2023/1/5.
//

import SwiftUI

struct NewRestaurantView: View {
    
    enum PhotoSource: Identifiable {
        case photoLibrary
        case camera
        var id: Int {
            hashValue
        }
    }
    
    
    @Environment(\.managedObjectContext) var context
    
    @State private var photoSource: PhotoSource?
    
//    @State var restaurantName = ""
//    @State private var restaurantImage = UIImage(named: "newphoto")!
    @State private var showPhotoOptions = false
    
    @ObservedObject private var restaurantFormViewModel: RestaurantFormViewModel
    
    @Environment(\.dismiss) var dismiss
    
    private func save() {
        let restaurant = Restaurant(context: context)
        
        restaurant.name = restaurantFormViewModel.name
        restaurant.type = restaurantFormViewModel.type
        restaurant.location = restaurantFormViewModel.location
        restaurant.phone = restaurantFormViewModel.phone
        restaurant.image = restaurantFormViewModel.image.pngData()!
        restaurant.summary = restaurantFormViewModel.description
        restaurant.isFavorite = false
        
        do {
            try context.save()
        } catch {
            print("Failed to save the record ...")
            print(error.localizedDescription)
        }
        
        let cloudStore = RestaurantCloudStore()
        cloudStore.saveRecordToCloud(restaurant: restaurant)
    }
    
    init() {
        let viewModel = RestaurantFormViewModel()
        viewModel.image = UIImage(named: "newphoto")!
        restaurantFormViewModel = viewModel
    }
    
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading) {
                    
                    Image(uiImage: restaurantFormViewModel.image)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 200)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.bottom)
                        .onTapGesture {
                            self.showPhotoOptions.toggle()
                        }
                    
                    FormTextField(label: "Name", placeholder: "Fill in the restaurant name", value: $restaurantFormViewModel.name)
                    
                    FormTextField(label: "TYPE", placeholder: "Fill in the restaurant type", value: $restaurantFormViewModel.type)
                    
                    FormTextField(label: "ADDRESS", placeholder: "Fill in the restaurant address", value: $restaurantFormViewModel.location)
                    
                    FormTextField(label: "PHONE", placeholder: "Fill in the restaurant phone", value: $restaurantFormViewModel.phone)
                    
                    FormTextView(label: "DESCRIPTION", value: $restaurantFormViewModel.description, height: 100)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button {
                        save()
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(Color("NavigationBarTitle"))
                    }
                }
            }
            .navigationTitle("New Restaurant")
        }
        .actionSheet(isPresented: $showPhotoOptions) {
            ActionSheet(title: Text("Choose your photo source"), message: nil, buttons: [
                .default(Text("Camera")) {
                    self.photoSource = .camera
                },
                .default(Text("Photo Library")) {
                    self.photoSource = .photoLibrary
                },
                .cancel()
            ])
        }
        .fullScreenCover(item: $photoSource) { source in
            switch source {
            case .photoLibrary: ImagePicker(sourceType: .photoLibrary, selectedImage: $restaurantFormViewModel.image).ignoresSafeArea()
            case .camera: ImagePicker(sourceType: .camera, selectedImage: $restaurantFormViewModel.image).ignoresSafeArea()
            }
            
        }
        .accentColor(.primary)
    }
        
}

struct NewRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        NewRestaurantView()
        
        FormTextField(label: "Name", placeholder: "Fill in the restaurant name", value: .constant(""))
            .previewLayout(.fixed(width: 300, height: 200))
        
        FormTextView(label: "Description", value: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}


struct FormTextField: View {
    let label: String
    var placeholder: String = ""
    
    @Binding var value: String
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(label.uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.red)
            
            TextField(placeholder, text: $value)
                .font(.system(.body, design: .rounded))
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                )
            .padding(.vertical, 10)
        }
    }
}

struct FormTextView: View {
    
    let label: String
    
    @Binding var value: String
    
    var height: CGFloat = 200
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(label.uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.blue)
            
            
            TextEditor(text: $value)
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                }
                .padding(.top, 10)
        }
    }
}



