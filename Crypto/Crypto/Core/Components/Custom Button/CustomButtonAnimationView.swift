//
//  CustomButtonAnimationView.swift
//  Crypto
//
//  Created by Ziya Zaidov on 25.12.2023.
//

import SwiftUI

struct CustomButtonAnimationView: View {
    
    @Binding  var animate: Bool
    
    var body: some View {

        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none)
            
    }
}

struct CustomButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonAnimationView(animate: .constant(false))
            .frame(width: 100, height: 100)
    }
}
