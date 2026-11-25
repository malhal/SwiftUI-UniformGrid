// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SwiftUI-UniformGrid",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .visionOS(.v1)],
    products: [
        .library(
            name: "UniformGrid",
            targets: ["UniformGrid"]
        ),
    ],
    targets: [
        .target(
            name: "UniformGrid"
        ),
        .testTarget(
            name: "UniformGridTests",
            dependencies: ["UniformGrid"]
        ),
    ]
)
