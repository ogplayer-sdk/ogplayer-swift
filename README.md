# OGPlayer — iOS SDK

Native video playback for iOS: AVFoundation engine, SwiftUI player UI, one HLS (VOD, live,
DVR), FairPlay DRM with rotating tokens, offline downloads with offline DRM,
picture-in-picture, Google IMA & FreeWheel ads, subtitles & audio tracks,
AirPlay, content ratings, watermark slots, themeable chrome.

## Install

Xcode → *File → Add Package Dependencies…* →

```
https://github.com/ogplayer-sdk/ogplayer-swift
```

Products: `OGPlayerCore` (engine) · `OGPlayerUI` (SwiftUI player view) ·
`OGPlayerAdsIMA` (Google IMA ads — pulls the IMA SDK automatically).

Requires iOS 18+ · Swift 5.9+ / Xcode 16+.

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
