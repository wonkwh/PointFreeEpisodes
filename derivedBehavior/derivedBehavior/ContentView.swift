//
//  ContentView.swift
//  derivedBehavior
//
//  Created by kwanghyun won on 2021/06/11.
//

import SwiftUI
import Combine
class AppViewModel: ObservableObject {
  let counter: CounterViewModel
  let profile: ProfileViewModel
  var cancelBag: Set<AnyCancellable> = []
  
  init(
    counter: CounterViewModel = .init(),
    profile: ProfileViewModel = .init()
  ) {
    self.counter = counter
    self.profile = profile
    
    self.counter.objectWillChange
      .sink { [weak self] in //weak self 추가해줘야 함
        self?.objectWillChange.send()
      }.store(in: &self.cancelBag)
    
    self.profile.objectWillChange
      .sink { [weak self] in
        self?.objectWillChange.send()
      }.store(in: &self.cancelBag)
    
    //profile tab update를 위해
    var counterIsUpdating = false
    var profileIsUpdating = false

    self.counter.$favorites
      .sink { [weak self] in
        guard !counterIsUpdating else { return }
        profileIsUpdating = true
        defer { profileIsUpdating = false }
        self?.profile.favorites = $0
      }
      .store(in: &self.cancelBag)

    self.profile.$favorites
      .sink { [weak self] in
        guard !profileIsUpdating else { return }
        counterIsUpdating = true
        defer { counterIsUpdating = false }
        self?.counter.favorites = $0
      }
      .store(in: &self.cancelBag)
    
    
//    self.counter.$favorites
//      .removeDuplicates()
//      .assign(to: &self.profile.$favorites)
//
//    self.profile.$favorites
//      .removeDuplicates()
//      .assign(to: &self.counter.$favorites)
  }
}


struct ContentView: View {
  @ObservedObject var viewModel: AppViewModel
  
  var body: some View {
      TabView {
        CountView(viewModel: viewModel.counter)
          .tabItem { Text("Count \(self.viewModel.counter.count)")  }
        ProfileView(viewModel: viewModel.profile)
          .tabItem { Text("Profile \(self.viewModel.profile.favorites.count)")  }
      }
    }
}

class CounterViewModel: ObservableObject {
  @Published var count = 0
  @Published var favorites: Set<Int> = []
}

struct CountView: View {
  @ObservedObject var viewModel: CounterViewModel
  
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
      
      if self.viewModel.favorites.contains(self.viewModel.count) {
        Button("Remove") {
          self.viewModel.favorites.remove(self.viewModel.count)
        }
      } else {
        Button("Save") {
          self.viewModel.favorites.insert(self.viewModel.count)
        }
      }
    }
  }
}

class ProfileViewModel: ObservableObject {
  @Published var count = 0
  @Published var favorites: Set<Int> = []
}

struct ProfileView: View {
  @ObservedObject var viewModel: ProfileViewModel
  
  var body: some View {
    List {
      ForEach(self.viewModel.favorites.sorted(), id: \.self) { number in
        HStack{
          Text("\(number)")
          Spacer()
          Button("Removed") {
            self.viewModel.favorites.remove(number)
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
