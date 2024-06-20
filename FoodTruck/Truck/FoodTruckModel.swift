//
//  FoodTruckModel.swift
//  FoodTruck
//
//  Created by Adrián Silva on 17/6/24.
//

import SwiftUI
import FirebaseAnalytics
import FirebaseAnalyticsSwift
import FirebaseCrashlytics
import FirebaseCrashlyticsSwift

@Observable
final class FoodTruckModel {
    var donuts: [Int: Donut]
    var favouriteDonuts: [Int: Donut] = [:]
    var isPremiumUser = false {
        didSet {
            handlePremiumAnalytics()
        }
    }
    let userID = "my_user_id"
    var isSettingsPresented = false
    var searchText = ""
    var filteredDonuts: [Donut] {
        Array(
            donuts
                .filter { $0.value.matches(searchText: searchText) }
                .values
        )
        .sorted(by: { $0.id < $1.id })
    }
    
    var appVersionNumber: String {
        Bundle.main
            .infoDictionary?["CFBundleShortVersionString"] as? String ?? "canary_wolf"
    }
    
    init(
        donuts: [Donut] = Donut.all, 
        favouriteDonuts: [Int : Donut] = [:]
    ) {
        self.donuts = Dictionary(
            uniqueKeysWithValues: donuts.map { ($0.id, $0) }
        )
        self.favouriteDonuts = favouriteDonuts
        configureFirebase()
    }
    
    func isFavourite(donut: Donut) -> Bool {
//        let firstFavouriteDonut = favouriteDonuts.values.first!
        if let _ = favouriteDonuts[donut.id] {
            return true
        }
        return false
    }
    
    func toggleFavourite(donut: Donut) {
        Analytics.logEvent(
            "donut_toggle_favorite", 
            parameters: [
                "donut_id": donut.id,
                "donut_name": donut.name,
                "is_favorite": (!isFavourite(donut: donut)).description
            ]
        )
        
        guard let something = donuts.values.first else {
            Crashlytics.crashlytics().log("Expected to find first donut but didn't find any")
            return
        }
        if isFavourite(donut: donut) {
            favouriteDonuts.removeValue(forKey: donut.id)
//            assertionFailure("")
            Crashlytics.crashlytics().log("Expected to find a favourite donut")
            return
        }
        favouriteDonuts[donut.id] = donut
        Crashlytics.crashlytics().log("Expected to add a favourite donut")
    }
    
    func settingsButtonTapped() {
        isSettingsPresented = true
    }
    
    func donutsCardTapped() {
        Analytics.logEvent(
            "donut_card_tapped", 
            parameters: [
                "favourite_donuts_count": favouriteDonuts.values.count,
                "donuts_count": donuts.values.count
            ]
        )
    }
    
    func handlePremiumAnalytics() {
        Analytics.logEvent(
            "premium_toggle", 
            parameters: [
                "toggle_value": isPremiumUser.description
            ]
        )
        Analytics.setUserProperty(isPremiumUser.description, forName: "is_premium")
    }
    
    func configureFirebase() {
        Analytics.setUserID(userID)
        Analytics.setUserProperty(isPremiumUser.description, forName: "is_premium")
        Crashlytics.crashlytics().setUserID(userID)
    }
}
