// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HackerNewsAPI",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v4),
        .tvOS(.v10)
    ],
    products: [
        .library(
            name: "HackerNewsAPI",
            targets: ["HackerNewsAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/FiveSheepCo/AsyncNetworking.git", .branch("main")),
        .package(url: "https://github.com/scinfu/SwiftSoup", .branch("master"))
    ],
    targets: [
        .target(
            name: "HackerNewsAPI",
            dependencies: ["SwiftSoup", "AsyncNetworking"]),
        .testTarget(
            name: "HackerNewsAPITests",
            dependencies: ["HackerNewsAPI"]),
    ]
)
