// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ECurve",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "ECurve",
            targets: ["ECurve"]),
    ],
    dependencies: [
       .package(url: "https://github.com/crmitchelmore/UInt256.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ECurve",
            dependencies: ["UInt256"]),
        .testTarget(
            name: "ECurveTests",
            dependencies: ["ECurve"]),
    ]
)
