//
//  NavigationApp.swift
//  Navigation
//
//  Created by kwanghyun won on 2021/09/28.
//

import SwiftUI

@main
struct NavigationApp: App {
    var body: some Scene {
        WindowGroup {
          ContentView(
            viewModel: .init(
              inventoryViewModel: .init( inventory: [
                    Item(name: "Keyboard", color: .blue, status: .inStock(quantity: 100)),
                    Item(name: "Charger", color: .yellow, status: .inStock(quantity: 20)),
                    Item(name: "Phone", color: .green, status: .outOfStock(isOnBackOrder: true)),
                    Item(name: "Headphones", color: .green, status: .outOfStock(isOnBackOrder: false)),
                  ]
                ),
              selectedTab: .inventory
            )
          )
        }
    }
}
