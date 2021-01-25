//
//  ContentView.swift
//  ConciseForms
//
//  Created by kwanghyun won on 2021/01/25.
//

import SwiftUI


class SettingsViewModel: ObservableObject {
  @Published var digest = Digest.off
  @Published var displayName = "kwang"
  @Published var protectMyPosts = false
  @Published var sendNotifications = false
  
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
//            Text("daily").tag(Digest.daily)
//            Text("weekly").tag(Digest.weekly)
//            Text("off").tag(Digest.off)
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
