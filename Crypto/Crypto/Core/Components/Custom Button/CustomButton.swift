//
//  CustomButton.swift
//  Crypto
//
//  Created by Ziya Zaidov on 25.12.2023.
//

import SwiftUI

struct CustomButton: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName )
            .font(.headline)
            .foregroundColor(Color.colorTheme.accentColor)
            .frame(width: 50, height: 50)
            .background(
            Circle()
                .foregroundColor(Color.colorTheme.backgroundColor)
            )
            .shadow(color: Color.colorTheme.accentColor.opacity(0.25), radius: 10)
            .padding()
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CustomButton(iconName: "info")
                .previewLayout(.sizeThatFits)
            
            CustomButton(iconName: "plus")
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        }
    }
}
