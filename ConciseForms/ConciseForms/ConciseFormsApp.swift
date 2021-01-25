//
//  ConciseFormsApp.swift
//  ConciseForms
//
//  Created by kwanghyun won on 2021/01/25.
//

import SwiftUI

@main
struct ConciseFormsApp: App {
    var body: some Scene {
        WindowGroup {
          VanillaSwiftUIFoamView(viewModel: SettingsViewModel())
        }
    }
}
