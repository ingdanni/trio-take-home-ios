//
//  MessageView.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 14/1/22.
//

import SwiftUI

struct MessageView: View {
    var content: String
    
    var body: some View {
        Text(content)
            .foregroundColor(Color.customBlack)
            .font(Font.montserratRegular(size: 16))
            .padding(.vertical, 32)
    }
}
