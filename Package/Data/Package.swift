// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [
        .iOS(.v16)
      ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Data",
            targets: ["Data"]),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Shared"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.2"),
        //.package(url: "https://github.com/couchbase/couchbase-lite-ios.git", from: "3.0.0")
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: ["Domain", "Shared", "Alamofire"]),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"]),
    ]
)

