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
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.5.0/OGPlayerCore.xcframework.zip",
            checksum: "6c07550896b5eba106df6dbf3320cdca695f882d5b3c75b5868260e6db7b9690"),
        .binaryTarget(name: "OGPlayerUIBinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.5.0/OGPlayerUI.xcframework.zip",
            checksum: "516aa321255f413a66269b74329ee6b6b0d83a72a944394d6b3619739e09ad17"),
        .binaryTarget(name: "OGPlayerAdsIMABinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.5.0/OGPlayerAdsIMA.xcframework.zip",
            checksum: "db95e874cd99e118cb1c8f3b6fc05543f55ce3402e33a97a81b9153d8e06b0f0"),
        .binaryTarget(name: "OGPlayerAdsIMAtvOSBinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.5.0/OGPlayerAdsIMAtvOS.xcframework.zip",
            checksum: "f775c76112b7a523786d1ab16933d898afa272cd0c2de52ff2dd42acd8817ddd"),
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
