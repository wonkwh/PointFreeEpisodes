//
//  NavigationApp.swift
//  Navigation
//
//  Created by kwanghyun won on 2021/09/28.
//

import SwiftUI

@main
struct NavigationApp: App {
    var body: some Scene {
        WindowGroup {
          ContentView(viewModel: .init())
        }
    }
}
