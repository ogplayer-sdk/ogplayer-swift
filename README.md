# OGPlayer — iOS and Apple TV SDK

Native video playback for iOS and tvOS: AVFoundation engine, SwiftUI player UI. HLS (VOD, live,
DVR), FairPlay DRM with rotating tokens, offline downloads with offline DRM,
picture-in-picture, Google IMA & FreeWheel ads, subtitles & audio tracks,
AirPlay, content ratings, watermark slots, themeable chrome. On Apple TV the
same `OGPlayerView` is driven by the Siri Remote.

Release notes: https://ogplayer.tv/docs/reference/changelog/ (also on each GitHub release).

## Install

Xcode → *File → Add Package Dependencies…* →

```
https://github.com/ogplayer-sdk/ogplayer-swift
```

Products: `OGPlayerCore` (engine) · `OGPlayerUI` (SwiftUI player view) ·
`OGPlayerAdsIMA` (Google IMA ads on iOS — pulls the IMA SDK automatically) ·
`OGPlayerAdsIMAtvOS` (the same for tvOS, through Google's tvOS IMA SDK).

Requires iOS 18+ or tvOS 18+ · Swift 5.9+ / Xcode 16+.

```swift
import OGPlayerUI

@StateObject var player = OGPlayer()

var body: some View {
    OGPlayerView(player: player)
        .onAppear {
            if let item = OGMediaItem(urlString: "https://…/master.m3u8") {
                player.load(item)
            }
        }
}
```

Docs: https://ogplayer.tv/docs · Live demo: https://demo.ogplayer.tv

## Apple TV

Add `OGPlayerCore` and `OGPlayerUI` to a tvOS target and the built-in chrome
is the Siri Remote chrome: play/pause centred in the bottom row with the
options beside it, focus shown by size, accelerated seeking from the scrub bar
with the storyboard preview, media keys, an overscan-safe layout. Ads come
from `OGPlayerAdsIMAtvOS`. Guide: https://ogplayer.tv/docs/getting-started/apple-tv/

## FreeWheel

FreeWheel's AdManager SDK is licensed to FreeWheel customers and cannot be
redistributed — so the OGPlayer FreeWheel adapter ships as **source**: see
[`Adapters/FreeWheel/`](Adapters/FreeWheel/) for the file and integration
steps.

## Licensing

The SDK is **free to evaluate** — fully functional, renders an OGPlayer
watermark. Production use requires a license: https://ogplayer.tv/terms/ ·
sales@ogplayer.tv

## Read-only repository

Issues and pull requests are closed — questions and reports are welcome at
hello@ogplayer.tv.
