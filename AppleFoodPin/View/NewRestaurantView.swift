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
        TextField("Fill in the restaurant name", text: $restaurantName)
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .padding(.horizontal)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(.systemGray5), lineWidth: 1)
            )
            .padding(.vertical, 10)
    }
}

struct NewRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        NewRestaurantView()
    }
}
