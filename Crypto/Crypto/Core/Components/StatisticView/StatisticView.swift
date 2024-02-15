//
//  StatisticView.swift
//  Crypto
//
//  Created by Ziya Zaidov on 28.12.2023.
//

import SwiftUI

struct StatisticView: View {
    
    let statistic: Statistic
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(statistic.title)
                .font(.headline)
                .foregroundColor(Color.colorTheme.secondaryTextColor)
            
            Text(statistic.value)
                .font(.headline)
                .foregroundColor(Color.colorTheme.accentColor)
            
            HStack (spacing: 4){
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (statistic.percentage ?? 0) >= 0 ? 0 : 180))
                Text(statistic.percentage?.asPercentToString() ?? "")
                    .font(.caption)
                .fontWeight(.bold)
            }
            .foregroundColor((statistic.percentage ?? 0) >= 0 ? Color.colorTheme.greenColor : Color.colorTheme.redColor)
            .opacity(statistic.percentage == nil ? 0.0 : 1.0)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(statistic: dev.stat)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            StatisticView(statistic: dev.stat2)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            StatisticView(statistic: dev.stat3)
                .previewLayout(.sizeThatFits)
        }
    }
}
