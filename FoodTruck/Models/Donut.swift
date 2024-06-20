/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The donut model object.
*/

import UniformTypeIdentifiers
import SwiftUI

struct Donut: Identifiable, Hashable {
    var id: Int
    var name: String
    
    var dough: Dough
    var glaze: Glaze?
    var topping: Topping?
    
    init(id: Int, name: String, dough: Donut.Dough, glaze: Donut.Glaze? = nil, topping: Donut.Topping? = nil) {
        self.id = id
        self.name = name
        self.dough = dough
        self.glaze = glaze
        self.topping = topping
    }
    
    var ingredients: [any Ingredient] {
        var result: [any Ingredient] = []
        result.append(dough)
        if let glaze = glaze {
            result.append(glaze)
        }
        if let topping = topping {
            result.append(topping)
        }
        return result
    }

    var flavors: FlavorProfile {
        ingredients
            .map(\.flavors)
            .reduce(into: FlavorProfile()) { partialResult, next in
                partialResult.formUnion(with: next)
            }
    }
    
    func matches(searchText: String) -> Bool {
        if searchText.isEmpty {
            return true
        }
        
        if name.localizedCaseInsensitiveContains(searchText) {
            return true
        }
        
        return ingredients.contains { ingredient in
            ingredient.name.localizedCaseInsensitiveContains(searchText)
        }
    }
}

extension Donut {
    static let classic = Donut(
        id: 0,
        name: String(localized: "The Classic", comment: "A donut-flavor name."),
        dough: .plain,
        glaze: .chocolate,
        topping: .sprinkles
    )
    
    static let blueberryFrosted = Donut(
        id: 1,
        name: String(localized: "Blueberry Frosted", comment: "A donut-flavor name."),
        dough: .blueberry,
        glaze: .blueberry,
        topping: .sugarLattice
    )
    
    static let strawberryDrizzle = Donut(
        id: 2,
        name: String(localized: "Strawberry Drizzle", comment: "A donut-flavor name."),
        dough: .strawberry,
        glaze: .strawberry,
        topping: .sugarDrizzle
    )
    
    static let cosmos = Donut(
        id: 3,
        name: String(localized: "Cosmos", comment: "A donut-flavor name."),
        dough: .chocolate,
        glaze: .chocolate,
        topping: .starSprinkles
    )
    
    static let strawberrySprinkles = Donut(
        id: 4,
        name: String(localized: "Strawberry Sprinkles", comment: "A donut-flavor name."),
        dough: .plain,
        glaze: .strawberry,
        topping: .starSprinkles
    )
    
    static let lemonChocolate = Donut(
        id: 5,
        name: String(localized: "Lemon Chocolate", comment: "A donut-flavor name."),
        dough: .plain,
        glaze: .chocolate,
        topping: .lemonLines
    )
    
    static let rainbow = Donut(
        id: 6,
        name: String(localized: "Rainbow", comment: "A donut-flavor name."),
        dough: .plain,
        glaze: .rainbow
    )
    
    static let picnicBasket = Donut(
        id: 7,
        name: String(localized: "Picnic Basket", comment: "A donut-flavor name."),
        dough: .chocolate,
        glaze: .strawberry,
        topping: .blueberryLattice
    )
    
    static let figureSkater = Donut(
        id: 8,
        name: String(localized: "Figure Skater", comment: "A donut-flavor name."),
        dough: .plain,
        glaze: .blueberry,
        topping: .sugarDrizzle
    )
    
    static let powderedChocolate = Donut(
        id: 9,
        name: String(localized: "Powdered Chocolate", comment: "A donut-flavor name."),
        dough: .chocolate,
        topping: .powderedSugar
    )
    
    static let powderedStrawberry = Donut(
        id: 10,
        name: String(localized: "Powdered Strawberry", comment: "A donut-flavor name."),
        dough: .strawberry,
        topping: .powderedSugar
    )
    
    static let custard = Donut(
        id: 11,
        name: String(localized: "Custard", comment: "A donut-flavor name."),
        dough: .lemonade,
        glaze: .spicy,
        topping: .lemonLines
    )
    
    static let superLemon = Donut(
        id: 12,
        name: String(localized: "Super Lemon", comment: "A donut-flavor name."),
        dough: .lemonade,
        glaze: .lemon,
        topping: .sprinkles
    )
    
    static let fireZest = Donut(
        id: 13,
        name: String(localized: "Fire Zest", comment: "A donut-flavor name."),
        dough: .lemonade,
        glaze: .spicy,
        topping: .spicySauceDrizzle
    )
    
    static let blackRaspberry = Donut(
        id: 14,
        name: String(localized: "Black Raspberry", comment: "A donut-flavor name."),
        dough: .plain,
        glaze: .chocolate,
        topping: .blueberryDrizzle
    )
    
    static let daytime = Donut(
        id: 15,
        name: String(localized: "Daytime", comment: "A donut-flavor name."),
        dough: .lemonade,
        glaze: .rainbow
    )
    
    static let nighttime = Donut(
        id: 16,
        name: String(localized: "Nighttime", comment: "A donut-flavor name."),
        dough: .chocolate,
        glaze: .chocolate,
        topping: .chocolateDrizzle
    )

    static let all = [
        classic, blueberryFrosted, strawberryDrizzle, cosmos, strawberrySprinkles, lemonChocolate, rainbow, picnicBasket, figureSkater,
        powderedChocolate, powderedStrawberry, custard, superLemon, fireZest, blackRaspberry, daytime, nighttime
    ]
    
    static var preview: Donut { .classic }
}

extension UTType {
    static let donut = UTType(exportedAs: "com.example.apple-samplecode.donut")
}
