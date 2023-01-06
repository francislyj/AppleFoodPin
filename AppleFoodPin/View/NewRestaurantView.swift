//
//  NewRestaurantView.swift
//  AppleFoodPin
//
//  Created by user on 2023/1/5.
//

import SwiftUI

struct NewRestaurantView: View {
    
    @State var restaurantName = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading) {
                    FormTextField(label: "Name", placeholder: "Fill in the restaurant name", value: $restaurantName)
                    
                    FormTextField(label: "TYPE", placeholder: "Fill in the restaurant type", value: .constant(""))
                    
                    FormTextField(label: "ADDRESS", placeholder: "Fill in the restaurant address", value: .constant(""))
                    
                    FormTextField(label: "PHONE", placeholder: "Fill in the restaurant phone", value: .constant(""))
                    
                    FormTextView(label: "DESCRIPTION", value: .constant(""), height: 100)
                }
                .padding()
            }
            .navigationTitle("New Restaurant")
        }
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
