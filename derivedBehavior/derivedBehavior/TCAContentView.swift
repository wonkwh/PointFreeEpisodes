//
//  TCAContentView.swift
//  derivedBehavior
//
//  Created by kwanghyun won on 2021/06/11.
//

import ComposableArchitecture
import SwiftUI

struct AppState: Equatable {
  var count = 0
  var favorites: Set<Int> = []
}

enum AppAction {
  case incrementButtonTapped
  case decrementButtonTapped
  case saveButtonTapped
  case removeButtonTapped
  case profileRemoveButtonTapped(Int)
}

struct AppEnvironment { }

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, _ in
  switch action {
  case .incrementButtonTapped:
    state.count += 1
    return .none
  case .decrementButtonTapped:
    state.count -= 1
    return .none
  case .saveButtonTapped:
    state.favorites.insert(state.count)
    return .none
  case .removeButtonTapped:
    state.favorites.remove(state.count)
    return .none
  case .profileRemoveButtonTapped( let number ):
    state.favorites.remove(number)
    return .none
  }
}

struct TCAContentView: View {
  let store: Store<AppState, AppAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      TabView {
        TCACountView(store: self.store)
          .tabItem {
            Text("Count\(viewStore.count)")
          }
        TCAProfileView(store: self.store)
          .tabItem {
            Text("Profile \(viewStore.favorites.count)")
          }
      }
    }
  }
}

struct TCACountView: View {
  let store: Store<AppState, AppAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack {
        HStack {
          Button("-") {
            viewStore.send(.decrementButtonTapped)
          }
          Text("\(viewStore.state.count)")
          Button("+") {
            viewStore.send(.incrementButtonTapped)
          }
        }
        
        if viewStore.favorites.contains(viewStore.count) {
          Button("Remove") {
            viewStore.send(.removeButtonTapped)
          }
        } else {
          Button("Save") {
            viewStore.send(.saveButtonTapped)
          }
        }
      }
    }
  }
}

struct TCAProfileView: View {
  let store: Store<AppState, AppAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      List {
        ForEach(viewStore.favorites.sorted(), id:\.self) { number in
          HStack{
            Text("\(number)")
            Spacer()
            Button("Removed") {
              viewStore.send(.profileRemoveButtonTapped(number))
            }
          }
        }
      }
    }
  }
}

struct TCAContentView_Previews: PreviewProvider {
    static var previews: some View {
        TCAContentView(
          store: Store(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment()
          )
        )
    }
}
