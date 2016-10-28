# RideNiceRide
RideNiceRide is the best way to enjoy Minneapolis/St.Paul's bike sharing system on iOS



## Getting Started

Run the following command in root directory to populate CocoaPods.
```bash
pod install
```
Now you can open `RideNiceRide.xcworkspace` and Run the `RideNiceRide` target onto your simulator or iOS device.

## Code style

This project will follow the [GitHub Swift Styleguide](https://github.com/github/swift-style-guide) in every way possible.

In order to enforce this, the project will also have a [Swiftlint](https://github.com/realm/SwiftLint) build phase to run the linter everytime the app is built.


## Project Structure

The project follows this folder structure:

```
SwipeIt
├── AppDelegate.swift
├── Models
│   ├── RideNiceRide.xcmodel
├── Views
│   ├── TableViewCell
├── ViewControllers
│   ├── SlideMenu
│   ├── PullUpView
├── Storyboards
├── API
├── Enums
├── Extensions
├── Networking
└── Resources
    ├── Localizable.strings
    └── Info.plist
```


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
- [Fastlane](https://github.com/fastlane/fastlane): The easiest way to automate building and releasing your iOS and Android apps

~~### Environment variables

~~To make sure Fabric and iTunes can deploy, make sure you have them set to something similar to the following environment variables. **The values are only examples!**.

~~**Note:** For ENV variables to work in Xcode you to set `$ defaults write com.apple.dt.Xcode UseSanitizedBuildSystemEnvironment -bool NO` and launch Xcode from the terminal. [Apple Developer Forums](https://forums.developer.apple.com/thread/8451)

~~#### Signing

~~- `SWIPEIT_SIGNING_IDENTITY_DIST`: iPhone Distribution: Company Name (ID)
- `SWIPEIT_CERTIFICATE_KEY`: The Certificate key used in [Match](https://github.com/fastlane/fastlane/tree/master/match)
- `SWIPEIT_CERTIFICATE_USER`: The username for the git being where Match is saving the Certificates.
- `SWIPEIT_CERTIFICATE_TOKEN`: The access token for the git being where Match is saving the Certificates.
- `SWIPEIT_CERTIFICATE_GIT`: The address or the git being where Match is saving the Certificates. (e.g. https://gitlab.com/username/Certificates)~~

~~#### Fabric deployment

~~- `SWIPEIT_FABRIC_CLIENT_ID`: API Key from [Fabric Organization](https://www.fabric.io/settings/organizations)
~~- `SWIPEIT_FABRIC_SECRET`: Build Secret from [Fabric Organization](https://www.fabric.io/settings/organizations)

~~#### iTunes deployment

~~- `SWIPEIT_TEAM_ID`: Team ID from [iTunes Membership](https://developer.apple.com/account/#/membership)
- `SWIPEIT_ITUNES_TEAM_ID`: Team ID from [iTunes Connect](https://itunesconnect.apple.com/). (`$ pilot list` to check the number)
- `SWIPEIT_TEAM_NAME`: Your Company Name
- `SWIPEIT_APPLE_ID`: Your Apple ID (e.g. john@apple.com)
- `SWIPEIT_ITUNES_PASSWORD`: The password for your Apple ID~~

~~#### Misc~~

~~- `SWIPEIT_SLACK_URL`: https://hooks.slack.com/services/...~~

### Deployment

Done manually through [Fastlane](https://github.com/JeffESchmitz/RideNiceRide/blob/master/fastlane/README.md):

#### Deployment to Fabric

```bash
bundle exec fastlane fabric
```

### Deployment to iTunes Connect

```bash
bundle exec fastlane itc
```
