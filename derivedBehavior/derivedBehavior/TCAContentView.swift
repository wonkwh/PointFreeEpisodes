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
  
  var countState: CountState {
    get {
      .init(count: self.count, favorites: self.favorites)
    }
    
    set {
      self.count = newValue.count
      self.favorites = newValue.favorites
    }
  }
  
  var profileState: ProfileState {
    get {
      .init(favorites: favorites)
    }
    set {
      self.favorites = newValue.favorites
    }
  }
}

enum AppAction {
  case countAction(CountAction)
  case profileAction(ProfileAction)
}

struct AppEnvironment { }

let appReducer = Reducer.combine(
  countReducer.pullback(
    state: \AppState.countState,
    action: /AppAction.countAction,
    environment: { (_: AppEnvironment) in CountEnvironment()
  }),
  profileReducer.pullback(
    state: \AppState.profileState,
    action: /AppAction.profileAction,
    environment: { (_: AppEnvironment) in ProfileEnvironment()
  })
)

struct TCAContentView: View {
  let store: Store<AppState, AppAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      TabView {
        TCACountView(store: self.store.scope(state: \.countState, action: AppAction.countAction))
          .tabItem {
            Text("Count\(viewStore.count)")
          }
        TCAProfileView(store: self.store.scope(state: \.profileState, action: AppAction.profileAction))
          .tabItem {
            Text("Profile \(viewStore.favorites.count)")
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
