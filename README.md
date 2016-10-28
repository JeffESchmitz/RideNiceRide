# RideNiceRide
RideNiceRide is the best way to enjoy Minneapolis/St.Paul's bike sharing system on iOS



## Getting Started

Run the following command in the root directory of the repository to populate the dependent CocoaPods needed to build and run.
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
├── App
│   └── AppDelegate
├── Enums
├── Extensions
├── Externals
├── Globals
├── Helpers
├── Models
├── Networking
├── Protocols
├── Resources
│   ├── LaunchScreen.storyboard
│   ├── Localizable.strings
│   └── Info.plist
├── Structs
├── ViewControllers
│   ├── Onboarding
│   │     └── Onboarding.storyboard
│   └── Main
│         └── Main.storyboard
├── ViewModels
└── Views
```


## Dependencies

### Model

- [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper): Simple JSON Object mapping written in Swift
- [DateTools](https://github.com/MatthewYork/DateTools): Dates and times made easy in Objective-C

### Functional Reactive Programming

- [RxSwift](https://github.com/ReactiveX/RxSwift): Reactive Programming in Swift
- [NSObject+Rx](https://github.com/RxSwiftCommunity/NSObject-Rx): Handy RxSwift extensions on NSObject, including rx_disposeBag
- [Cell+Rx](https://github.com/ivanbruel/Cell-Rx): Handy RxSwift extensions on UITableViewCell and UICollectionViewCell, including rx_reusableDisposeBag
- [RxOptional](https://github.com/RxSwiftCommunity/RxOptional): RxSwift extensions for Swift optionals and "Occupiable" types
- [RxDataSources](https://github.com/RxSwiftCommunity/RxDataSources): Table and Collection View Data Sources for RxSwift
- [RxTimer](https://github.com/ivanbruel/RxTimer): RxTimer adds RxSwift Timer bindings.
- [RxResult](https://github.com/ivanbruel/RxResult): Result bindings for RxSwift.
- [RxColor](https://github.com/ivanbruel/RxColor): RxSwift bindings for common UIColor setters

### Networking

- [Moya](https://github.com/Moya/Moya): Network abstraction layer written in Swift
- [Moya-ObjectMapper](https://github.com/ivanbruel/Moya-ObjectMapper): ObjectMapper bindings for Moya and RxSwift
- [Result](https://github.com/antitypical/Result): This is a Swift µframework providing Result
- [RxAlamofire](https://github.com/RxSwiftCommunity/RxAlamofire): RxSwift wrapper around the elegant HTTP networking in Swift Alamofire
- [Kingfisher](https://github.com/onevcat/Kingfisher): A lightweight and pure Swift implemented library for downloading and caching image from the web.

### UI

- [GPUImage2](https://github.com/BradLarson/GPUImage2): GPUImage 2 is a BSD-licensed Swift framework for GPU-accelerated video and image processing.
- [ZLSwipeableViewSwift](https://github.com/zhxnlai/ZLSwipeableViewSwift): A simple view for building card like interface inspired by Tinder and Potluck.
- [TTTAttributedLabel](https://github.com/TTTAttributedLabel/TTTAttributedLabel): A drop-in replacement for UILabel that supports attributes, data detectors, links, and more
- [MarkdownKit](https://github.com/ivanbruel/MarkdownKit): A simple and customizable Markdown Parser for Swift

### Utilities

- [KeychainSwift](https://github.com/marketplacer/keychain-swift): Helper functions for saving text in Keychain securely for iOS, OS X, tvOS and watchOS
- [Kanna](https://github.com/tid-kijyun/Kanna): Kanna is an XML/HTML parser for macOS / iOS / tvOS.
- [Device](https://github.com/Ekhoo/Device): Light weight tool for detecting the current device and screen size written in swift
- [AsyncSwift](https://github.com/duemunk/Async): Syntactic sugar in Swift for asynchronous dispatches in Grand Central Dispatch
- [SnapKit](https://github.com/SnapKit/SnapKit): SnapKit is a DSL to make Auto Layout easy on both iOS and OS X

### Environment

- [SwiftLint](https://github.com/realm/SwiftLint): A tool to enforce Swift style and conventions.
- [SwiftGen](https://github.com/AliSoftware/SwiftGen): A collection of Swift tools to generate Swift code (enums for your assets, storyboards, Localizable.strings, …)
- [Fabric](https://docs.fabric.io/apple/fabric/overview.html): Fabric is a mobile platform with modular kits you can mix and match to build the best apps
- [Crashlytics](https://fabric.io/kits/ios/crashlytics/install): The most powerful, yet lightest weight crash reporting solution
- [Synx](https://github.com/venmo/synx): A command-line tool that reorganizes your Xcode project folder to match your Xcode groups
- [Fastlane](https://github.com/fastlane/fastlane): The easiest way to automate building and releasing your iOS and Android apps

### Environment variables

To make sure Fabric and iTunes can deploy, make sure you have them set to something similar to the following environment variables. **The values are only examples!**.

**Note:** For ENV variables to work in Xcode you to set `$ defaults write com.apple.dt.Xcode UseSanitizedBuildSystemEnvironment -bool NO` and launch Xcode from the terminal. [Apple Developer Forums](https://forums.developer.apple.com/thread/8451)

#### Signing

- `SWIPEIT_SIGNING_IDENTITY_DIST`: iPhone Distribution: Company Name (ID)
- `SWIPEIT_CERTIFICATE_KEY`: The Certificate key used in [Match](https://github.com/fastlane/fastlane/tree/master/match)
- `SWIPEIT_CERTIFICATE_USER`: The username for the git being where Match is saving the Certificates.
- `SWIPEIT_CERTIFICATE_TOKEN`: The access token for the git being where Match is saving the Certificates.
- `SWIPEIT_CERTIFICATE_GIT`: The address or the git being where Match is saving the Certificates. (e.g. https://gitlab.com/username/Certificates)

#### Fabric deployment

- `SWIPEIT_FABRIC_CLIENT_ID`: API Key from [Fabric Organization](https://www.fabric.io/settings/organizations)
- `SWIPEIT_FABRIC_SECRET`: Build Secret from [Fabric Organization](https://www.fabric.io/settings/organizations)

-#### iTunes deployment-

- `SWIPEIT_TEAM_ID`: Team ID from [iTunes Membership](https://developer.apple.com/account/#/membership)
- `SWIPEIT_ITUNES_TEAM_ID`: Team ID from [iTunes Connect](https://itunesconnect.apple.com/). (`$ pilot list` to check the number)
- `SWIPEIT_TEAM_NAME`: Your Company Name
- `SWIPEIT_APPLE_ID`: Your Apple ID (e.g. john@apple.com)
- `SWIPEIT_ITUNES_PASSWORD`: The password for your Apple ID

#### Misc

- `SWIPEIT_SLACK_URL`: https://hooks.slack.com/services/...

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
