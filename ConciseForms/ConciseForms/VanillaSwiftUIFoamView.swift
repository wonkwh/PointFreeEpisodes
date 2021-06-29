//
//  ContentView.swift
//  ConciseForms
//
//  Created by kwanghyun won on 2021/01/25.
//

import SwiftUI
import UserNotifications

class SettingsViewModel: ObservableObject {
  @Published var digest = Digest.off
  @Published var displayName = "kwang" {
    didSet { // name validation을 추가
      guard displayName.count > 16 else {
        return
      }
      self.displayName = String(self.displayName.prefix(16))
    }
  }
  
  @Published var protectMyPosts = false
  @Published var sendNotifications = false {
    didSet {
      guard self.sendNotifications else {
        return
      }
      
      UNUserNotificationCenter.current().getNotificationSettings { setting in
        guard setting.authorizationStatus != .denied else {
          // TODO: - *alert
          self.sendNotifications = false
          return
        }
      }
      
      UNUserNotificationCenter.current().requestAuthorization(options: .alert) { granted, error in
        if !granted || error != nil {
          DispatchQueue.main.async {
            self.sendNotifications = false

          }
        }
      }
    }
  }
  
  func reset() {
    self.digest = .off
    self.displayName = ""
    self.protectMyPosts = false
    self.sendNotifications = false
  }
}

struct VanillaSwiftUIFoamView: View {
  @ObservedObject var viewModel: SettingsViewModel
  
    var body: some View {
      Form {
        Section(header: Text("Profile")) {
          TextField("Display name", text: $viewModel.displayName)
          Toggle("Protect my posts", isOn: $viewModel.protectMyPosts)
        }
        
        Section(header: Text("Communication")) {
          Toggle("Send notification", isOn: $viewModel.sendNotifications)
          
          if self.viewModel.sendNotifications {
            Picker("Top posts digest", selection: $viewModel.digest) {
              ForEach(Digest.allCases, id: \.self) { digest in //Digest.AllCased와 혼동하지 말자.
                Text(digest.rawValue)
              }
            }
          }
        }
        Button("Reset") {
          self.viewModel.reset()
        }
      }.navigationTitle("Setting")
    }
}

enum Digest: String, CaseIterable {
  case daily
  case weekly
  case off
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        VanillaSwiftUIFoamView(viewModel: SettingsViewModel())
      }
    }
}
