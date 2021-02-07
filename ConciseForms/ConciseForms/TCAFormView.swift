//
//  TCAFormView.swift
//  ConciseForms
//
//  Created by kwanghyun won on 2021/02/07.
//

import SwiftUI
import ComposableArchitecture

struct SettingsState: Equatable {
  var displayName = ""
  var protectMyPost = false
  var sendNotifications = false
}

enum SettingsAction {
  case displayNameChanged(String)
  case protectMyPost(Bool)
  case resetButtonTapped
  case sendNotificationChanged(Bool)
}

struct SettingsEnvironment {}

let settingsReducer =
  Reducer<SettingsState, SettingsAction, SettingsEnvironment> { state, action, environment in
  return .none
}


struct TCAFormView: View {
  let store:Store<SettingsState, SettingsAction>
  
  var body: some View {
    WithViewStore(self.store) { viewStore in
      Form {
        Section(header: Text("Profile")) {
          TextField("Display Name", text: .constant(""))
          Toggle("Protect my Post", isOn: .constant(false))
        }
        Section(header: Text("Communcatin")) {
          Toggle("Send Notification", isOn: .constant(false))
        }
        Button("Reset") {
          viewStore.send(.resetButtonTapped)
        }
      }.navigationTitle("Setting")
    }
  }
}

struct TCAFormView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      TCAFormView(
        store: Store(initialState: SettingsState(),
                     reducer: settingsReducer,
                     environment: SettingsEnvironment())
      )
      
    }
  }
}
