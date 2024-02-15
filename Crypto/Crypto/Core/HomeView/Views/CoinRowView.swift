//
//  CoinRowView.swift
//  Crypto
//
//  Created by Ziya Zaidov on 25.12.2023.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: Coin
    let showHoldingColumn: Bool
    
    var body: some View {

        HStack {
            Text("\(coin.ranking)")
                .font(.caption)
                .foregroundColor(Color.colorTheme.secondaryTextColor)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading,5)
                .foregroundColor(Color.colorTheme.accentColor)
            Spacer()
            if showHoldingColumn {
                VStack (alignment: .trailing) {
                    Text(coin.currentHoldingValue.asCurrencyWithDecimals())
                    Text((coin.currentHoldings ?? 0).asNumberToString())
                }
                .foregroundColor(Color.colorTheme.accentColor)
            }
            
            VStack (alignment: .trailing) {
                Text("\(coin.currentPrice.asCurrencyWithDecimalsSecondary())")
                    .bold()
                    .foregroundColor(Color.colorTheme.accentColor)
                Text(coin.priceChangePercentage24H?.asPercentToString() ?? "")
                    .foregroundColor(
                        (coin.priceChangePercentage24H ?? 0 ) >= 0 ?
                        Color.colorTheme.greenColor : Color.colorTheme.redColor
                    )
            }
            .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
        }
        .font(.headline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingColumn: true)
    }
}
