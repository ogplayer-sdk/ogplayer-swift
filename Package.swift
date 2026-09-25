// swift-tools-version:5.9
// PUBLIC distribution manifest for the OGPlayer iOS SDK — binary XCFrameworks
// only, no source. Lives in the public repo; zips are GitHub Release assets.
import PackageDescription

let package = Package(
    name: "OGPlayer",
    platforms: [.iOS("18.0"), .tvOS("18.0")],
    products: [
        .library(name: "OGPlayerCore", targets: ["OGPlayerCore"]),
        .library(name: "OGPlayerUI", targets: ["OGPlayerUIWrapper"]),
        .library(name: "OGPlayerAdsIMA", targets: ["OGPlayerAdsIMAWrapper"]),
        .library(name: "OGPlayerAdsIMAtvOS", targets: ["OGPlayerAdsIMAtvOSWrapper"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/googleads/swift-package-manager-google-interactive-media-ads-ios.git",
            from: "3.18.4"
        ),
        .package(
            url: "https://github.com/googleads/swift-package-manager-google-interactive-media-ads-tvos.git",
            from: "4.17.0"
        ),
    ],
    targets: [
        .binaryTarget(name: "OGPlayerCore",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.4.1/OGPlayerCore.xcframework.zip",
            checksum: "a6ac13faf5a5ae4162cc95ca14a5acfcd366a65fa09a265c12d090f8ffdc9f69"),
        .binaryTarget(name: "OGPlayerUIBinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.4.1/OGPlayerUI.xcframework.zip",
            checksum: "5768ae10f10090b55b7a46845b9ad23ac74b65fa4ded93a635fcdaa319207d20"),
        .binaryTarget(name: "OGPlayerAdsIMABinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.4.1/OGPlayerAdsIMA.xcframework.zip",
            checksum: "da892b2b16c2551a18b034262db27e4b0ae7ea23db28cd246793431e0e9e925c"),
        .binaryTarget(name: "OGPlayerAdsIMAtvOSBinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.4.1/OGPlayerAdsIMAtvOS.xcframework.zip",
            checksum: "df495c4e48da13d62e3b4c62e67841a5abc8d5aaffcf85422ade0ad4dbbb1d15"),
        // Wrappers carry the inter-framework and third-party dependencies
        // (binaryTarget itself cannot declare dependencies).
        .target(name: "OGPlayerUIWrapper",
            dependencies: ["OGPlayerUIBinary", "OGPlayerCore"],
            path: "Wrappers/OGPlayerUI"),
        .target(name: "OGPlayerAdsIMAWrapper",
            dependencies: [
                "OGPlayerAdsIMABinary", "OGPlayerCore",
                .product(name: "GoogleInteractiveMediaAds",
                         package: "swift-package-manager-google-interactive-media-ads-ios",
                         condition: .when(platforms: [.iOS])),
            ],
            path: "Wrappers/OGPlayerAdsIMA"),
        .target(name: "OGPlayerAdsIMAtvOSWrapper",
            dependencies: [
                "OGPlayerAdsIMAtvOSBinary", "OGPlayerCore",
                .product(name: "GoogleInteractiveMediaAdsTvOS",
                         package: "swift-package-manager-google-interactive-media-ads-tvos",
                         condition: .when(platforms: [.tvOS])),
            ],
            path: "Wrappers/OGPlayerAdsIMAtvOS"),
    ]
)
