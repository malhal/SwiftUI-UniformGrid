// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "SwiftUI-UniformGrid",
    platforms: [.iOS(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8)],
    products: [
        .library(
            name: "UniformGrid",
            targets: ["UniformGrid"]
        ),
    ],
    targets: [
        .target(
            name: "UniformGrid",
            dependencies: []
        ),
        .testTarget(
            name: "UniformGridTests",
            dependencies: ["UniformGrid"]
        ),
    ]
)
