// swift-tools-version:5.9
// PUBLIC distribution manifest for the OGPlayer iOS SDK — binary XCFrameworks
// only, no source. Lives in the public repo; zips are GitHub Release assets.
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
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.2.1/OGPlayerCore.xcframework.zip",
            checksum: "8a4a05fc4c22a9ff58732bb76a18609a591b9cf3e55f5494fb8fabb7db8fa66f"),
        .binaryTarget(name: "OGPlayerUIBinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.2.1/OGPlayerUI.xcframework.zip",
            checksum: "426144e6b22c1abe1ab2a54d688957f69e324adfcc74e8c1af78fb23c4a152c3"),
        .binaryTarget(name: "OGPlayerAdsIMABinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.2.1/OGPlayerAdsIMA.xcframework.zip",
            checksum: "ac20a8a49ab77f57a1517ff66b3504ffc2e8023589e06c1d63ec331b2c520f52"),
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
