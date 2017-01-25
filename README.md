# RideNiceRide
RideNiceRide is the best way to enjoy Boston's Hubway bike sharing system on iOS. Inspired and based upon the fantastic Android application, [Moyeu](https://github.com/garuma/Moyeu) developed by [Jérémie Laval](https://github.com/garuma?tab=overview&from=2016-12-01&to=2016-12-31&utf8=✓).



## Getting Started

Run the following command in root directory to populate CocoaPods.
```bash
pod install
```
Now you can open `RideNiceRide.xcworkspace` and Run the `RideNiceRide` target onto your simulator or iOS device.


## Credits

Icons:

- <a href="http://thenounproject.com/noun/map/#icon-No5260" target="_blank">Map</a> designed by <a href="http://thenounproject.com/jonathan" target="_blank">Jonathan Higley</a> from The Noun Project
- <a href="http://thenounproject.com/noun/bicycle/#icon-No3535" target="_blank">Bicycle</a> designed by <a href="http://thenounproject.com/ugur.akdemir" target="_blank">Ugur Akdemir</a> from The Noun Project

Images:

- <a href="https://flic.kr/p/q386Lu" target="_blank">Hubway</a> by Tony Webster (CC BY)

Data provided by Hubway at [http://thehubway.com/data/stations/bikeStations.json](http://thehubway.com/data/stations/bikeStations.json)

## Code style

This project will follow the [GitHub Swift Styleguide](https://github.com/github/swift-style-guide) in every way possible.

In order to enforce this, the project will also have a [Swiftlint](https://github.com/realm/SwiftLint) build phase to run the linter everytime the app is built.

## Dependencies

### Model

- [Sync](https://github.com/SyncDB/Sync): Modern Swift JSON synchronization to Core Data
- [DATAStack](https://github.com/SyncDB/DATAStack): 100% Swift Simple Boilerplate Free Core Data Stack
- [DATASource](https://github.com/SyncDB/DATASource): Core Data's NSFetchedResultsController wrapper for UITableView and UICollectionView
- [SYNCPropertyMapper](https://github.com/SyncDB/SYNCPropertyMapper): Map your Core Data properties with ease

### Networking

- [Alamofire](https://github.com/Alamofire/Alamofire): HTTP networking library written in Swift

### UI

- [ISHPullUp](https://github.com/iosphere/ISHPullUp): Vertical split view controller with pull up gesture as seen in the iOS 10 Maps app
- [SlideMenuControllerSwift](https://github.com/dekatotoro/SlideMenuControllerSwift): iOS Slide Menu View based on Google+, iQON, Feedly, Ameba iOS app. It is written in pure swift
- [GoogleMaps](https://developers.google.com/maps/documentation/ios-sdk/): Enrich your app with interactive maps and immersive street view panoramas
- [GooglePlaces](https://developers.google.com/places/ios-api/): Add up-to-date information about millions of locations to your iOS App
- [PKHUD](https://github.com/pkluz/PKHUD): A Swift based reimplementation of the Apple HUD (Volume, Ringer, Rotation,…)

### Utilities

- [Sugar](https://github.com/hyperoslo/Sugar): ☕️ Something sweet that goes great with your Cocoa
- [Cent](https://github.com/ankurp/Cent): Library that extends certain Swift object types using the extension feature and gives its two cents to Swift language
- [Dollar](https://github.com/ankurp/Dollar): A functional tool-belt for Swift Language similar to Lo-Dash or Underscore.js in Javascript
- [Device](https://github.com/Ekhoo/Device): Light weight tool for detecting the current device and screen size written in swift
- [Willow](https://github.com/Nike-Inc/Willow): Willo is a powerful, yet lightweight logging library written in Swift
- [AsyncSwift](https://github.com/duemunk/Async): Syntactic sugar in Swift for asynchronous dispatches in Grand Central Dispatch

### Environment

- [SwiftLint](https://github.com/realm/SwiftLint): A tool to enforce Swift style and conventions.
- [SwiftGen](https://github.com/AliSoftware/SwiftGen): A collection of Swift tools to generate Swift code (enums for your assets, storyboards, Localizable.strings, …)
- [Fabric](https://docs.fabric.io/apple/fabric/overview.html): Fabric is a mobile platform with modular kits you can mix and match to build the best apps
- [Crashlytics](https://fabric.io/kits/ios/crashlytics/install): The most powerful, yet lightest weight crash reporting solution
