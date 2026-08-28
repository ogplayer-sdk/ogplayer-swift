// swift-tools-version:5.9
// PUBLIC distribution manifest for the OGPlayer iOS SDK — binary XCFrameworks
// only, no source. Lives in the public repo; zips are GitHub Release assets.
// v1.0.3 and https://github.com/ogplayer-sdk/ogplayer-swift/releases/download get filled by the release script.
import PackageDescription

let package = Package(
    name: "OGPlayer",
    platforms: [.iOS("18.0")],
    products: [
        .library(name: "OGPlayerCore", targets: ["OGPlayerCore"]),
        .library(name: "OGPlayerUI", targets: ["OGPlayerUIWrapper"]),
        .library(name: "OGPlayerAdsIMA", targets: ["OGPlayerAdsIMAWrapper"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/googleads/swift-package-manager-google-interactive-media-ads-ios.git",
            from: "3.18.4"
        ),
    ],
    targets: [
        .binaryTarget(name: "OGPlayerCore",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.0.3/OGPlayerCore.xcframework.zip",
            checksum: "2864a54627a931bd2c0e93a2a7c5d53cb775c06ca0bc04ab11239cd3a1ef120c"),
        .binaryTarget(name: "OGPlayerUIBinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.0.3/OGPlayerUI.xcframework.zip",
            checksum: "edce1b37abfdef93fc89c0ef17375475955034e73eeb10ca58249d3c6f22f877"),
        .binaryTarget(name: "OGPlayerAdsIMABinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.0.3/OGPlayerAdsIMA.xcframework.zip",
            checksum: "524d51a3bbf440a091af28d2b36e31b83bce1d748d94f4b1466a3a632bdedeac"),
        // Wrappers carry the inter-framework and third-party dependencies
        // (binaryTarget itself cannot declare dependencies).
        .target(name: "OGPlayerUIWrapper",
            dependencies: ["OGPlayerUIBinary", "OGPlayerCore"],
            path: "Wrappers/OGPlayerUI"),
        .target(name: "OGPlayerAdsIMAWrapper",
            dependencies: [
                "OGPlayerAdsIMABinary", "OGPlayerCore",
                .product(name: "GoogleInteractiveMediaAds",
                         package: "swift-package-manager-google-interactive-media-ads-ios"),
            ],
            path: "Wrappers/OGPlayerAdsIMA"),
    ]
)
