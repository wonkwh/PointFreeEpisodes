//
//  ContentView.swift
//  Navigation
//
//  Created by kwanghyun won on 2021/09/28.
//

import SwiftUI
class AppViewModel: ObservableObject {
  @Published var selectedTab: Int
  
  init(selectedTab: Int = 1) {
    self.selectedTab = selectedTab
  }
}

struct ContentView: View {
//  @State var selection = 1
  @ObservedObject var viewModel: AppViewModel
  
  var body: some View {
    TabView(selection: self.$viewModel.selectedTab ) {
      
      Button("Go to 2nd Tab") {
        self.viewModel.selectedTab = 2
      }
      .tabItem { Text("One") }
      .tag(1)
    
      Text("Two")
        .tabItem { Text("Two") }
        .tag(2)
      
      Text("Three")
        .tabItem { Text("Three") }
        .tag(3)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(viewModel: .init())
  }
}
