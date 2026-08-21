// swift-tools-version:5.9
// PUBLIC distribution manifest for the OGPlayer iOS SDK — binary XCFrameworks
// only, no source. Lives in the public repo; zips are GitHub Release assets.
// v0.13.0 and https://github.com/ogplayer-sdk/ogplayer-swift/releases/download get filled by the release script.
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
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v0.13.0/OGPlayerCore.xcframework.zip",
            checksum: "1dca7ed996d88d5f3b749e6590b4b39f47aef7b50aa43a538497848503eff063"),
        .binaryTarget(name: "OGPlayerUIBinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v0.13.0/OGPlayerUI.xcframework.zip",
            checksum: "d06ef7fc59c8f0ad2cddcaa1f04cf3f45ec23dc1650f52be38ddd827eb0f9e0d"),
        .binaryTarget(name: "OGPlayerAdsIMABinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v0.13.0/OGPlayerAdsIMA.xcframework.zip",
            checksum: "6a3eecf4889cf21acf2543dd3d6f1e053ca274fc5f85c1570b921372e3202440"),
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
