//
//  SettingsView.swift
//  FoodTruck
//
//  Created by Adrián Silva on 17/6/24.
//

import SwiftUI

struct SettingsView: View {
    @Bindable var model: FoodTruckModel

    var body: some View {
        VStack {
            Form {
                Section {
                    HStack(spacing: 12) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44, height: 44)
                            .foregroundStyle(Color.accentColor)
                        
                        VStack(alignment: .leading) {
                            Text("John Doe")
                                .font(.headline)
                            Text("john.doe@example.com")
                                .font(.subheadline)
                        }
                    }
                } header: {
                    Text("User Profile")
                }
                
                Section {
                    HStack(spacing: 12) {
                        Image(systemName: "creditcard.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44, height: 44)
                            .foregroundStyle(Color.accentColor)
                        
                        Toggle(
                            isOn: $model.isPremiumUser, 
                            label: {
                                VStack(alignment: .leading) {
                                    Text("Subscription Status")
                                        .font(.headline)
                                    Text("Premium")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.accentColor)
                                }
                            }
                        )
                        .tint(Color.accentColor)
                    }
                } header: {
                    Text("Subscription")
                }
                
                Section {
                    HStack(spacing: 12) {
                        Image(systemName: "person.badge.key")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44, height: 44)
                            .foregroundStyle(Color.accentColor)
                        
                        VStack(alignment: .leading) {
                            Text("User ID")
                                .font(.headline)
                            Text(model.userID)
                                .font(.subheadline)
                        }
                    }
                } header: {
                    Text("User Properties")
                }
                
                HStack {
                    Text("App Version")
                        .font(.headline)
                    Spacer()
                    Text(model.appVersionNumber)
                }
            }
            .analyticsScreen(name: "settings_view")
        }
    }
}

#Preview {
    SettingsView(model: FoodTruckModel())
}
