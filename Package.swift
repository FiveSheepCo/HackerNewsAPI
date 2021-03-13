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
        .package(url: "https://github.com/Quintschaf/SchafKit.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "HackerNewsAPI",
            dependencies: ["SchafKit"]),
        .testTarget(
            name: "HackerNewsAPITests",
            dependencies: ["HackerNewsAPI"]),
    ]
)
