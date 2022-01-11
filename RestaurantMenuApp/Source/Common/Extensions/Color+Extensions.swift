//
//  Color+Extensions.swift
//  RestaurantMenuApp
//
//  Created by Danny Narvaez on 11/1/22.
//

import SwiftUI

extension Color {
    
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
    
    static let customWhite = Color(0xFFFFFF)
    static let customGray = Color(0x777777)
    static let customBlack = Color(0x171616)
    static let customLightGray = Color(0xEEEEEE)
    static let customLightGray2 = Color(0xD8D8D8)
}

#if DEBUG
struct ColorExtensions_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack {
            Rectangle()
                .fill(Color.customBlack)
            Rectangle()
                .fill(Color.customGray)
            
            Rectangle()
                .fill(Color.customWhite)
            
            Rectangle()
                .fill(Color.customLightGray)
            
            Rectangle()
                .fill(Color.customLightGray2)
        }
    }
}
#endif
