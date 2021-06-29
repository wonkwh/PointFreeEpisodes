//
//  ContentView.swift
//  derivedBehavior
//
//  Created by kwanghyun won on 2021/06/11.
//

import SwiftUI

class AppViewModel: ObservableObject {
  @Published var count = 0
  @Published var favorited: Set<Int> = []
}

struct ContentView: View {
  @ObservedObject var viewModel: AppViewModel
    var body: some View {
      TabView {
        CountView(viewModel: viewModel)
          .tabItem { Text("Profile \(self.viewModel.count)")  }
        ProfileView(viewModel: viewModel)
          .tabItem { Text("Profile \(self.viewModel.favorited.count)")  }
      }
    }
}

struct CountView: View {
  @ObservedObject var viewModel: AppViewModel
  
  var body: some View {
    VStack {
      HStack {
        Button("-") {
          self.viewModel.count -= 1
        }
        Text("\(self.viewModel.count)")
        Button("+") {
          self.viewModel.count += 1
        }
      }
      
      if self.viewModel.favorited.contains(self.viewModel.count) {
        Button("Remove") {
          self.viewModel.favorited.remove(self.viewModel.count)
        }
      } else {
        Button("Save") {
          self.viewModel.favorited.insert(self.viewModel.count)
        }
      }
    }
  }
}

struct ProfileView: View {
  @ObservedObject var viewModel: AppViewModel
  
  var body: some View {
    List {
      ForEach(self.viewModel.favorited.sorted(), id: \.self) { number in
        HStack{
          Text("\(number)")
          Spacer()
          Button("Removed") {
            self.viewModel.favorited.remove(number)
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView(viewModel: .init())
    }
}
