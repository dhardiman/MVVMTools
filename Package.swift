// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MVVM",
    products: [
      .library(name: "MVVM", targets: ["MVVM"])
    ],
    dependencies: [
        .package(url: "https://github.com/DeclarativeHub/Bond", .upToNextMajor(from: "7.5.0")),        
    ],
    targets: [
      .target(name: "MVVM", dependencies: []),
      .testTarget(name: "MVVMTests", dependencies: ["MVVM"])
    ],
    swiftLanguageVersions: [.v5]
)
