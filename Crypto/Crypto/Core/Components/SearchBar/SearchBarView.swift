//
//  SearchBarView.swift
//  Crypto
//
//  Created by Ziya Zaidov on 28.12.2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
          Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? Color.colorTheme.secondaryTextColor : Color.colorTheme.accentColor
                )
            
            TextField("Search by name or symbol", text: $searchText)
                .disableAutocorrection(true)
                .foregroundColor(Color.colorTheme.accentColor)
                .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding(10)
                    .offset(x: 10)
                    .foregroundColor(Color.colorTheme.accentColor)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchText = ""
                    }
                ,alignment: .trailing)
        }
        .padding()
        .font(.headline)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.colorTheme.backgroundColor)
                .shadow(color: Color.colorTheme.accentColor.opacity(0.20), radius: 10)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
