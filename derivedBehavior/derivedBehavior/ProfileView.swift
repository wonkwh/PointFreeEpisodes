//
//  ProfileView.swift
//  ProfileView
//
//  Created by kwanghyun won on 2021/07/28.
//

import SwiftUI
import ComposableArchitecture

struct ProfileState: Equatable {
  var favorites: Set<Int> = []
}

enum ProfileAction {
  case profileRemoveButtonTapped(Int)
}

struct ProfileEnvironment {
}

let profileReducer = Reducer<ProfileState, ProfileAction, ProfileEnvironment> { state, action, _ in
  switch action {
  case let .profileRemoveButtonTapped(number):
    state.favorites.remove(number)
    return .none
  }
}

struct TCAProfileView: View {
  let store: Store<ProfileState, ProfileAction>
  
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

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
