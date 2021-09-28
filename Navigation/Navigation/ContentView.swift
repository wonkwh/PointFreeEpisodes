//
//  ContentView.swift
//  Navigation
//
//  Created by kwanghyun won on 2021/09/28.
//

import SwiftUI

enum Tab {
  case one
  case inventory
  case three
}

class AppViewModel: ObservableObject {
  @Published var inventoryViewModel: InventoryViewModel
  @Published var selectedTab: Tab
  
  init(
    inventoryViewModel: InventoryViewModel = .init(),
     selectedTab: Tab = .one
  ) {
    self.inventoryViewModel = inventoryViewModel
    self.selectedTab = selectedTab
  }
}

struct ContentView: View {
  @ObservedObject var viewModel: AppViewModel
  
  var body: some View {
    TabView(selection: self.$viewModel.selectedTab ) {
      
      Button("Go to 2nd Tab") {
        self.viewModel.selectedTab = .inventory
      }
      .tabItem { Text("One") }
      .tag(Tab.one)
    
      InventoryView(viewModel: self.viewModel.inventoryViewModel)
        .tabItem { Text("Items") }
        .tag(Tab.inventory)
      
      Text("Three")
        .tabItem { Text("Three") }
        .tag(Tab.three)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
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
