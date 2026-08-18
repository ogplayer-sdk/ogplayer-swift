// swift-tools-version:5.9
// OGPlayer iOS SDK — public distribution package (binary XCFrameworks).
// Docs: https://ogplayer.tv/docs · License: https://ogplayer.tv/terms
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
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v0.12.0/OGPlayerCore.xcframework.zip",
            checksum: "21aabdf25e22ba683dbfd42e89bd8b0603d67d067670fbca967107a465d8ec39"),
        .binaryTarget(name: "OGPlayerUIBinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v0.12.0/OGPlayerUI.xcframework.zip",
            checksum: "f052a77bb9d158ea8ac4fff972df9192fce4d64805a7d2a80eac91ccd87f7bbd"),
        .binaryTarget(name: "OGPlayerAdsIMABinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v0.12.0/OGPlayerAdsIMA.xcframework.zip",
            checksum: "d55f4a35be2754a58746c1f3c22814f3e564066936d651ce993040c462b007b5"),
        // Wrappers carry inter-framework and third-party dependencies
        // (a binaryTarget cannot declare its own).
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
