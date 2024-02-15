//
//  HomeView.swift
//  Crypto
//
//  Created by Ziya Zaidov on 25.12.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewViewModel
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            Color.colorTheme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                header
                HomeStatisticsView(showPortfolio:  $showPortfolio)
                SearchBarView(searchText: $vm.searchtextField)
                
                HStack {
                    Text("Coin")
                    Spacer()
                    if showPortfolio {
                        Text("Holdings")
                    }
                    Text("Price")
                        .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
                }
                .font(.caption)
                .foregroundColor(Color.colorTheme.secondaryTextColor)
                .padding(.horizontal)
                
                if !showPortfolio {
                    List {
                        ForEach(vm.allCoins) { coin in
                            CoinRowView(coin: coin, showHoldingColumn: false)
                        }
                    }
                    .listStyle(.plain)
                    .transition(.move(edge: .leading))
                }
            
                if showPortfolio {
                    List {
                        ForEach(vm.portfolioCoins
                        ) { coin in
                            CoinRowView(coin: coin, showHoldingColumn: true)
                        }
                    }
                    .listStyle(.plain)
                    .transition(.move(edge: .trailing))

                }
//                .padding(.horizontal)
                Spacer(minLength: 0)
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
        .environmentObject(dev.homeVieModel)
    }
}

extension HomeView {
    private var header: some View {
        HStack {
            CustomButton(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background(
                    CustomButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text( showPortfolio ? "Portfolio" : "Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.colorTheme.accentColor)
            Spacer()
            CustomButton(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
    }
}
