//
//  ContentView.swift
//  Navigation
//
//  Created by kwanghyun won on 2021/09/28.
//

import SwiftUI

enum Tab {
  case one
  case two
  case three
}

class AppViewModel: ObservableObject {
  @Published var selectedTab: Tab
  
  init(selectedTab: Tab = .one) {
    self.selectedTab = selectedTab
  }
}

struct ContentView: View {
//  @State var selection = 1
  @ObservedObject var viewModel: AppViewModel
  
  var body: some View {
    TabView(selection: self.$viewModel.selectedTab ) {
      
      Button("Go to 2nd Tab") {
        self.viewModel.selectedTab = .two
      }
      .tabItem { Text("One") }
      .tag(Tab.one)
    
      Text("Two")
        .tabItem { Text("Two") }
        .tag(Tab.two)
      
      Text("Three")
        .tabItem { Text("Three") }
        .tag(Tab.three)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(viewModel: .init(selectedTab: .two))
  }
}
