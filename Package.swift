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
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.6.1/OGPlayerCore.xcframework.zip",
            checksum: "73e1a894d54929fd5013182edbc961cf0840b7c794a43972ae92231493e69ef3"),
        .binaryTarget(name: "OGPlayerUIBinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.6.1/OGPlayerUI.xcframework.zip",
            checksum: "7cee078e8db4d0db313933c5667840f1d385393c07b9cb561dc4f3287ca2e2ff"),
        .binaryTarget(name: "OGPlayerAdsIMABinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.6.1/OGPlayerAdsIMA.xcframework.zip",
            checksum: "f036263f2cb09336a893e38c6ed9526244379bf5423a55aa37b0d1947e6bcfb3"),
        .binaryTarget(name: "OGPlayerAdsIMAtvOSBinary",
            url: "https://github.com/ogplayer-sdk/ogplayer-swift/releases/download/v1.6.1/OGPlayerAdsIMAtvOS.xcframework.zip",
            checksum: "71309ab52b09df8c286ca7b276d498041eff1c16c966c802827683a86a5f8278"),
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
