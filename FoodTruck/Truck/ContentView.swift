//
//  ContentView.swift
//  FoodTruck
//
//  Created by Adrián Silva on 15/6/24.
//

import SwiftUI

enum Navigation: Hashable {
    case donuts
}

struct ContentView: View {
    // MARK: - Model
    @State var model = FoodTruckModel()
    @State private var navigation: [Navigation] = []
    
    // MARK: - Body

    var body: some View {
        NavigationStack(path: $navigation) {
            ScrollView(.vertical) {
                VStack(spacing: 16) {
                    TruckHeader()
                    
                    Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                        TruckDonutsCard(
                            donuts: Array(model.donuts.values),
                            groupText: "Donuts"
                        )
                        .onTapGesture {
                            navigation.append(.donuts)
                            model.donutsCardTapped()
                        }
                        
                        if !model.favouriteDonuts.isEmpty {
                            TruckDonutsCard(
                                donuts: Array(model.favouriteDonuts.values), 
                                groupText: "Favourites"
                            )
                        }
                    }
                    .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .padding([.horizontal, .bottom], 16)
                    .frame(maxWidth: 1200)
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        model.settingsButtonTapped()
                    } label: {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 34, height: 34)
                            .bold()
                    }
                    .frame(width: 44, height: 44)
                    .padding(.trailing)
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Navigation.self) { navigation in
                switch navigation {
                    case .donuts:
                        DonutGallery(model: model)
                }
            }
            .sheet(isPresented: $model.isSettingsPresented) {
                SettingsView(model: model)
            }
            .analyticsScreen(name: "truck_screen")
        }
    }
}

#Preview {
    ContentView()
}
