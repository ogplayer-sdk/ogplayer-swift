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
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.6.0/OGPlayerCore.xcframework.zip",
            checksum: "960447826da05d25be8c47b7844a2ec4a8522ad322b44d77b4b043d484a86cf0"),
        .binaryTarget(name: "OGPlayerUIBinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.6.0/OGPlayerUI.xcframework.zip",
            checksum: "f32cb4d2b10a3c56cb8c8a3017a809ac71de00582da0d15c5f05b742d9c6bab3"),
        .binaryTarget(name: "OGPlayerAdsIMABinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.6.0/OGPlayerAdsIMA.xcframework.zip",
            checksum: "b09c9fa0668c6b0b4c5036adb383dceb3580004210c668a752389ebe73eeedb3"),
        .binaryTarget(name: "OGPlayerAdsIMAtvOSBinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.6.0/OGPlayerAdsIMAtvOS.xcframework.zip",
            checksum: "14165dd5828559625960fd6680e178e03c7456ff933dd9ae79df653f64760280"),
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
