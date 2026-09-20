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
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.4.0/OGPlayerCore.xcframework.zip",
            checksum: "02c05e0cf3b72e1beab955cb33a0925265f218190137bab1b682d481c978ca0e"),
        .binaryTarget(name: "OGPlayerUIBinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.4.0/OGPlayerUI.xcframework.zip",
            checksum: "0e1f0ecf50a0979a769581e77342de42b04411768bace21e339d010d333898e0"),
        .binaryTarget(name: "OGPlayerAdsIMABinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.4.0/OGPlayerAdsIMA.xcframework.zip",
            checksum: "dcf819ddb4f110222991a9968a2ff24c5c9e7e71e2a6a5840735224e19106f36"),
        .binaryTarget(name: "OGPlayerAdsIMAtvOSBinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.4.0/OGPlayerAdsIMAtvOS.xcframework.zip",
            checksum: "8bd8e425aafb52ec64c184355a17e5d63f3cf88d08538024f3f04ee29197cea8"),
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
