// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Inventory",
  platforms: [.iOS(.v14)],
  products: [
    .library( name: "Models", targets: ["Models"]),
    .library( name: "SwiftUIHelpers", targets: ["SwiftUIHelpers"]),
    .library( name: "ParsingHelpers", targets: ["ParsingHelpers"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-case-paths", from: "0.8.0"),
    .package(url: "https://github.com/pointfreeco/swift-parsing", from: "0.4.0"),
  ],
  targets: [
    .target(name: "Models"),
    .target(
      name: "SwiftUIHelpers",
      dependencies: [.product(name: "CasePaths", package: "swift-case-paths") ]
    ),
    .target(
      name: "ParsingHelpers",
      dependencies: [.product(name: "Parsing", package: "swift-parsing") ]
    )
  ]
)
