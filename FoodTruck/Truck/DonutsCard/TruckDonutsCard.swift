//
//  TruckDonutsCard.swift
//  FoodTruck
//
//  Created by Adrián Silva on 17/6/24.
//

import SwiftUI

struct TruckDonutsCard: View {
    var donuts: [Donut]
    var groupText: String

    var body: some View {
        VStack {
            GroupBox(
                label: Label {
                    Text(groupText)
                } icon: {
                    Image.donutSymbol
                }
                .foregroundStyle(Color.accentColor)
            ) {
                DonutLatticeLayout {
                    ForEach(donuts.prefix(14)) { donut in
                        DonutView(donut: donut)
                    }
                }
                .frame(minHeight: 60, maxHeight: .infinity)
            }
        }
        .padding(10)
        .background()
    }
}

#Preview {
    TruckDonutsCard(
        donuts: Donut.all, 
        groupText: "Donut"
    )
}
