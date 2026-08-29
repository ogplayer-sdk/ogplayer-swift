// swift-tools-version:5.9
// PUBLIC distribution manifest for the OGPlayer iOS SDK — binary XCFrameworks
// only, no source. Lives in the public repo; zips are GitHub Release assets.
// v1.0.4 and https://github.com/ogplayer-sdk/ogplayer-swift/releases/download get filled by the release script.
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
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.0.4/OGPlayerCore.xcframework.zip",
            checksum: "491f4a0e4cd534be5f45f8b9157cdcb114abe94cb8c9c1a1077611fccf83a97b"),
        .binaryTarget(name: "OGPlayerUIBinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.0.4/OGPlayerUI.xcframework.zip",
            checksum: "eee7a4577ad6c4a447ab30ac5cb0c6370732621c0b8063197589149ac3124e42"),
        .binaryTarget(name: "OGPlayerAdsIMABinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.0.4/OGPlayerAdsIMA.xcframework.zip",
            checksum: "144ae05587c94c19be98842291f621fdb450aeceb1ba4cc6de4b53841e435d59"),
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
