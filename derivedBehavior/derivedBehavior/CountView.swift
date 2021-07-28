//
//  CountView.swift
//  CountView
//
//  Created by kwanghyun won on 2021/07/28.
//

import SwiftUI
import ComposableArchitecture

// MARK: - CountScene

struct CountState: Equatable {
  var count = 0
  var favorites: Set<Int> = []
}

enum CountAction {
  case incrementButtonTapped
  case decrementButtonTapped
  case saveButtonTapped
  case removeButtonTapped
}

struct CountEnvironment {
}

let countReducer = Reducer<CountState, CountAction, CountEnvironment> { state, action, _ in
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
  }
}

struct TCACountView: View {
  let store: Store<CountState, CountAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      VStack {
        HStack {
          Button("-") { viewStore.send(.decrementButtonTapped) }
          Text("\(viewStore.state.count)")
          Button("+") { viewStore.send(.incrementButtonTapped) }
        }
        
        if viewStore.favorites.contains(viewStore.count) {
          Button("Remove") { viewStore.send(.removeButtonTapped) }
        } else {
          Button("Save") { viewStore.send(.saveButtonTapped) }
        }
      }
    }
  }
}
