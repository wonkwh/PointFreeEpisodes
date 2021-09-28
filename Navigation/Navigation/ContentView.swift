//
//  ContentView.swift
//  Navigation
//
//  Created by kwanghyun won on 2021/09/28.
//

import SwiftUI

struct ContentView: View {
  @State var selection = 1
  
  var body: some View {
    TabView(selection: self.$selection ) {
      
      Button("Go to 2nd Tab") {
        self.selection = 2
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
    ContentView(selection: 3)
  }
}
