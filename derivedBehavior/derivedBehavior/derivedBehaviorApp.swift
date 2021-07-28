//
//  derivedBehaviorApp.swift
//  derivedBehavior
//
//  Created by kwanghyun won on 2021/06/11.
//

import SwiftUI
import ComposableArchitecture

@main
struct derivedBehaviorApp: App {
  var body: some Scene {
    WindowGroup {
      //          ContentView(viewModel: .init())
      TCAContentView(
        store: Store(
          initialState: AppState(),
          reducer: appReducer,
          environment: AppEnvironment()
        )
      )
    }
  }
}
