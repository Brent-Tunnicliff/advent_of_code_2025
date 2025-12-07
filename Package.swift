// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "AdventOfCode",
    platforms: [.macOS(.v26)],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-algorithms.git",
            .upToNextMajor(from: "1.2.0")
        ),
        .package(
            url: "https://github.com/apple/swift-collections.git",
            .upToNextMajor(from: "1.1.4")
        ),
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            .upToNextMajor(from: "1.5.0")
        ),
        .package(
            url: "https://github.com/Brent-Tunnicliff/swift-format-plugin",
            .upToNextMajor(from: "2.0.0")
        ),
        .package(
            url: "https://github.com/davecom/SwiftPriorityQueue",
            .upToNextMajor(from: "1.4.0")
        ),
        .package(
            url: "https://github.com/Brent-Tunnicliff/advent_of_code_helper",
            .upToNextMajor(from: "0.1.0")
        )
    ],
    targets: [
        .executableTarget(
            name: "AdventOfCode",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "SwiftPriorityQueue", package: "SwiftPriorityQueue"),
                .product(name: "AOCHelper", package: "advent_of_code_helper"),
            ],
            resources: [.copy("Data")]
        ),
        .testTarget(
            name: "AdventOfCodeTests",
            dependencies: ["AdventOfCode"]
        )
    ]
)

// MARK: - Common target settings

// Sets values that are common for every target.
for target in package.targets {

    // MARK: Plugins

    let plugins = target.plugins ?? []
    target.plugins = plugins + [
        .plugin(name: "LintBuildPlugin", package: "swift-format-plugin")
    ]

    // MARK: Swift compliler settings

    let swiftSettings = target.swiftSettings ?? []
    target.swiftSettings = swiftSettings + [
        .strictMemorySafety(),

        // Feature flags

        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
    ]
}
