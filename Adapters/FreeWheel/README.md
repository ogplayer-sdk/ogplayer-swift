# FreeWheel adapter for OGplayer (iOS)

`FWAdsProvider.swift` implements OGplayer's `AdsProvider` SPI on top of
FreeWheel's AdManager SDK — the iOS counterpart of the Android
`ogplayer-ads-freewheel` module.

## Why source, not a package product

FreeWheel's `AdManager.framework` is licensed to FreeWheel customers and
cannot be redistributed with OGplayer. Swift Package Manager has no
`compileOnly` (unlike Gradle, which lets the Android module compile against
FreeWheel without shipping it), so a published package target importing
`AdManager` would fail to build for anyone without the framework. The
adapter therefore ships as a source file you add to your app, next to your
licensed framework.

## Integration

1. Obtain `AdManager.framework` from your FreeWheel account (MRM support
   portal or your FreeWheel account manager).
2. Add the framework to your app target — link + embed. Device builds only:
   FreeWheel ships no simulator slice, so gate it to `[sdk=iphoneos*]`.
3. Copy `FWAdsProvider.swift` into your app target. It is gated on
   `#if canImport(AdManager)`, so simulator builds compile it out
   automatically.
4. Wire it up:

```swift
player.adsProvider = FWAdsProvider()
let item = OGMediaItem(
    urlString: contentURL,
    adBreaks: FreewheelConfig(
        serverURL: "https://<your-network>.v.fwmrm.net/ad/p/1",
        networkId: /* your network id */,
        profile: "<networkId>:<your_profile>",
        siteSectionId: "<your site section>",
        videoAssetId: "<your MRM asset id>",
        videoDurationMs: /* exact asset duration */,
        globalParameters: [/* your consent / identity key-values */]))
```

`FreewheelConfig` itself lives in OGPlayerCore (pure data, no FreeWheel
dependency) and mirrors the Android builder field-for-field. The SDK owns
the full ad chrome (yellow bar, countdown, pod position, learn-more);
FreeWheel renders only the ad media into the player's ad container.

A working integration is in the demos app (`FreewheelDemo.swift`), which
compiles this same file.
