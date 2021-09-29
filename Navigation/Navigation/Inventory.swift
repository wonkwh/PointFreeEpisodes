//
//  Inventory.swift
//  Navigation
//
//  Created by kwanghyun won on 2021/09/28.
//

import SwiftUI

struct Item: Equatable, Identifiable {
  let id = UUID()
  var name: String
  var color: Color?
  var status: Status

  enum Status: Equatable {
    case inStock(quantity: Int)
    case outOfStock(isOnBackOrder: Bool)

    var isInStock: Bool {
      guard case .inStock = self else { return false }
      return true
    }
  }

  struct Color: Equatable, Hashable {
    var name: String
    var red: Double = 0
    var green: Double = 0
    var blue: Double = 0

    static var defaults: [Self] = [
      .red,
      .green,
      .blue,
      .black,
      .yellow,
      .white,
    ]

    static let red = Self(name: "Red", red: 1)
    static let green = Self(name: "Green", green: 1)
    static let blue = Self(name: "Blue", blue: 1)
    static let black = Self(name: "Black")
    static let yellow = Self(name: "Yellow", red: 1, green: 1)
    static let white = Self(name: "White", red: 1, green: 1, blue: 1)

    var swiftUIColor: SwiftUI.Color {
      .init(red: self.red, green: self.green, blue: self.blue)
    }
  }
}

class InventoryViewModel: ObservableObject {
  @Published var inventory: [Item]
  
  init(inventory: [Item] = []) {
    self.inventory = inventory
  }
  
  func delete(item: Item) {
    withAnimation {
      self.inventory.removeAll(where: {
        $0.id == item.id
      })
    }
  }
}

struct InventoryView: View {
  @ObservedObject var viewModel: InventoryViewModel
  @State var itemToDelete: Item?
  
  var body: some View {
    List {
      ForEach(self.viewModel.inventory) { item in
        HStack {
          VStack(alignment: .leading) {
            Text(item.name)

            switch item.status {
            case let .inStock(quantity):
              Text("In stock: \(quantity)")
            case let .outOfStock(isOnBackOrder):
              Text("Out of stock" + (isOnBackOrder ? ": on back order" : ""))
            }
          }

          Spacer()

          if let color = item.color {
            Rectangle()
              .frame(width: 30, height: 30)
              .foregroundColor(color.swiftUIColor)
              .border(Color.black, width: 1)
          }

          Button(action: {
            self.itemToDelete = item
          }) {
            Image(systemName: "trash.fill")
          }
          .padding(.leading)
        }
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(item.status.isInStock ? nil : Color.gray)
      }
      .alert(item: self.$itemToDelete) { item in
        Alert(
          title: Text(item.name),
          message: Text("Are you sure you want to delete this item?"),
          primaryButton: .destructive(Text("delete")) {
            self.viewModel.delete(item: item)
          },
          secondaryButton: .cancel()
        )
      }
    }
  }
}

struct InventoryView_Previews: PreviewProvider {
  static var previews: some View {
    InventoryView(
      viewModel: .init(
        inventory: [
          Item(name: "Keyboard", color: .blue, status: .inStock(quantity: 100)),
          Item(name: "Charger", color: .yellow, status: .inStock(quantity: 20)),
          Item(name: "Phone", color: .green, status: .outOfStock(isOnBackOrder: true)),
          Item(name: "Headphones", color: .green, status: .outOfStock(isOnBackOrder: false)),
        ]
      )
    )
  }
}
