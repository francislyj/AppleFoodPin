//
//  ReviewView.swift
//  AppleFoodPin
//
//  Created by user on 2023/1/4.
//

import SwiftUI

struct ReviewView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            HStack {
                Spacer()
                
                VStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Spacer()
                }
            }
            
            VStack (alignment: .leading) {
                ForEach(Rating.allCases, id: \.self) { rating in
                    HStack {
                        Image(rating.image)
                        Text(rating.rawValue.capitalized)
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
