// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AssistantKit",
    platforms: [
        .iOS(.v9),
    ],
    products: [
        .library(
            name: "AssistantKit",
            targets: ["AssistantKit"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AssistantKit",
            dependencies: [],
            path: "AssistantKit",
            sources: [
                "Classes",
            ]
        ),
    ]
)
