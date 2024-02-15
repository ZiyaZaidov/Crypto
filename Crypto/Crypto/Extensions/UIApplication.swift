//
//  UIApplication.swift
//  Crypto
//
//  Created by Ziya Zaidov on 28.12.2023.
//

import Foundation
import SwiftUI


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
