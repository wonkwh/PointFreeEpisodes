//
//  ContentView.swift
//  derivedBehavior
//
//  Created by kwanghyun won on 2021/06/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      TabView {
        CountView()
          .tabItem { Text("Counter") }
        ProfileView()
          .tabItem { Text("Profile") }
      }
    }
}

struct CountView: View {
  var body: some View {
    VStack {
      HStack {
        Button("-") {
          
        }
        Text("0")
        Button("+") {
          
        }
      }
      
      Button("Save") {
        
      }
    }
  }
}

struct ProfileView: View {
  var body: some View {
    List {
      ForEach(1...10, id: \.self) { number in
        HStack{
          Text("\(number)")
          Spacer()
          Button("Removed") {
            
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
