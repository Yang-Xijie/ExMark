// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExMark",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ExMark",
            targets: ["ExMark"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Yang-Xijie/XCLog", .branch("main")),
    ],
    targets: [
        .target(
            name: "ExMark",
            dependencies: ["XCLog"]),
        .testTarget(
            name: "ExMarkTests",
            dependencies: ["ExMark"]),
    ]
)
