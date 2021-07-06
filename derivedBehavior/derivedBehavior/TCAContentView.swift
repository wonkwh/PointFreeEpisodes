//
//  TCAContentView.swift
//  derivedBehavior
//
//  Created by kwanghyun won on 2021/06/11.
//

import ComposableArchitecture
import SwiftUI

struct AppState {
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


struct TCAContentView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TCAContentView_Previews: PreviewProvider {
    static var previews: some View {
        TCAContentView()
    }
}
