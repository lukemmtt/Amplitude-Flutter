// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "amplitude_flutter",
    platforms: [
        .iOS("13.0"),
        .macOS("10.15")
    ],
    products: [
        .library(name: "amplitude-flutter", targets: ["amplitude_flutter"])
    ],
    dependencies: [
        .package(url: "https://github.com/amplitude/Amplitude-Swift.git", exact: "1.17.3")
    ],
    targets: [
        .target(
            name: "amplitude_flutter",
            dependencies: [
                .product(name: "AmplitudeSwift", package: "Amplitude-Swift")
            ]
        )
    ]
)
