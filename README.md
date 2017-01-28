# RideNiceRide
![AppIcon](https://github.com/JeffESchmitz/RideNiceRide/blob/master/RideNiceRide/Resources/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5%402x.png)

### [Udacity iOS Developer Nanodegree](https://www.udacity.com/course/ios-developer-nanodegree--nd003) Capstone Project
In this capstone project, students will create an app of their own design that showcases our iOS development skills.

### App Description:
RideNiceRide is the best way to enjoy Boston's Hubway bike sharing system on iOS. View up-to-date bike and station availability, store favorite stations and view your Hubway account details.  
*Inspired and based upon the fantastic Android application, [Moyeu](https://github.com/garuma/Moyeu) developed by [Jérémie Laval](https://github.com/garuma?tab=overview&from=2016-12-01&to=2016-12-31&utf8=✓).*

#### Screenshots:  
![1-StartUp](https://github.com/JeffESchmitz/RideNiceRide/blob/master/Artwork/screenshots/1-RideNiceRide-Startup-iPhone7.png) ![2-Mapview-Station](https://github.com/JeffESchmitz/RideNiceRide/blob/master/Artwork/screenshots/2-RideNiceRide-MapView-Station-iPhone7.png) ![Panorama](https://github.com/JeffESchmitz/RideNiceRide/blob/master/Artwork/screenshots/3-RideNiceRide-Panorama-iPhone7.png)
![SlideMenu](https://github.com/JeffESchmitz/RideNiceRide/blob/master/Artwork/screenshots/4-RideNiceRide-SlideMenu-iPhone7.png) ![Favorites](https://github.com/JeffESchmitz/RideNiceRide/blob/master/Artwork/screenshots/5-RideNiceRide-Favorites-iPhone7.png) ![RentalHistory](https://github.com/JeffESchmitz/RideNiceRide/blob/master/Artwork/screenshots/6-RideNiceRide-RentalHistory-iPhone7.png)

## Usage
- On startup, the application will center the map on Boston, MA. and plot up-to-date bicycle station information as Pin's on the map.
- On app startup, the user will be presented a map of the Boston Hubway bicycle sharing system map of current availability of bicycles for rent.
- Pins on the map represent stations containing bicycles.
- Each pin displays the number of bicycles available and are color-coded to quickly determine general bicycle availability.

Color | Description
--- | ---
Blue | Station Locked
Red | No bikes
Orange | 1 to 4 bikes
Light Green | 5 to 9 bikes
Green | 10 to 16 bikes

- Tapping a pin on the map will slide up a menu at the bottom of the screen displaying the name of the station and the active bikes available for rent as well as the total number of bikes the docking station can hold.
- Sliding the bottom menu up will display a panoramic view of the surrounding area.
- This panorama view allows the user to visualize what the bike station should appear like and allow them to quickly pinpoint the station if they choose to seek out and rent a bicycle.
- Clicking on a star while a map pin has been activated will store that map location into a favorite. 
- Tapping on the upper left-hand slide menu (hamburger menu) will open a menu to select navigation options.
 - Map
 - Favorites
 - Rental Account History
- Favorites is a view allowing the user to view a list of all of stored favorite stations.
- While on the Favorites view, users can remove a favorite by swiping left on the specified row.
- Also, tapping on a specific Favorite map view will launch the iOS Map application allowing the user to map directions and see what businesses are around their chosen station.
- Rental History is a view that will open up a new screen allowing the user to enter their HubWay credentials and access their HubWay account details. 

### App Specifications

#### User Interface
* More than one view controller
  * [x] *This application features a number of different view controllers and views. It contains a views for each main content area (Map, Favorites, Rental History) along with a SlideMenu (a.k.a Hamburger Menu) as well as a special PullUp view that allows the user's interaction to stay focused on the Map view when selecting/de-selecting favorite stations.*
* A table or collection view
  * [x] *Favorites list is a table view.*
* Navigation and modal presentation
  * [x] *This app provides navigation via the left-hand slide menu (Hamburger menu).*
* Image assets in 1x, 2x, and 3x formats. Or in vector format.
  * [x] *All image assets are in 1x, 2x, and 3x formats.*

#### Networking
* Choose an API and integrate downloaded data into the app
  * [x] *I access the public API of [Hubway System Data](https://www.thehubway.com/system-data) JSON feed at URL: https://feeds.thehubway.com/stations/stations.json.*
* Give users feedback around network activity, displaying activity indicators and/or progress bars when appropriate, and an alert in case of connection failures
  * [x] *A HUD (Heads Up Display) is shown to the user when retrieving network data as well as this HUD displays network error information when unable to connect or invalid JSON other network-related errors.*
* Encapsulate networking code in a class to reduce detail in View Controllers
  * [x] *Code that access the network is contained inside class file HubwayAPI.swift.*
  * [x] *Code to detect changes of network availability is contained inside class file ReachabilityManager.swift.*

#### Persistance
* Include an object graph that can be persisted in Core Data
  * [x] *I persist both Station and FavoriteStation objects via Core Data.*
* Manage the Core Data Stack outside of your view controllers, either in the App Delegate or in a separate Core Data Stack manager class
  * [x] *All 'Data Access' currently is encapsulated within the HubwayAPI class. This was a intended decision as the Networking and Data access code footprint is small, I wanted to keep it close together. In future iterations, I am planning on splitting the Data Access code outside of the Networking (API-related) code for better separation of concerns.*
* Aside from your primary app state, you should find some additional state that can be stored outside of Core Data, either in NSUserDefaults, or in the documents directory using an NSKeyedArchiver
  * [x] *I am using NSUserDefaults to store last viewed region coordinates of the Map View.*

#### README
* Describe the intended user experience
  * [x] *Done.*
* Include all specific actions and/or commands necessary for the reviewer to compile, run, and access any aspect of the project
  * [x] *Done.* 
  
## Credits
Artwork:

- [Mass-bike](https://pbs.twimg.com/profile_banners/90715747/1483463516/1500x500) from [MassBike.org](http://www.massbike.org)
- [Noun_536.svg - Bicycle](https://thenounproject.com/term/bicycle/536/) from [Public Domain](https://creativecommons.org/publicdomain/zero/1.0/)
- [Star_on.svg, Star_off.svg](https://github.com/jamesmontemagno/BikeNow) from [James Montemagno's](https://github.com/jamesmontemagno) [BikeNow](https://github.com/jamesmontemagno/BikeNow) GitHub repository.
- [Map Pin images](https://www.shutterstock.com/image-vector/25-simple-mapping-pins-icon-web-66302356?src=download_history) designed by [Vector Illustration](https://www.shutterstock.com/g/vector+illustration#)
- [Bicycle](http://thenounproject.com/noun/bicycle/#icon-No3535) designed by [Ugur Akdemir](http://thenounproject.com/ugur.akdemir) from The Noun Project
- [Hubway](https://flic.kr/p/q386Lu) by Tony Webster (CC BY)

Data provided by [Hubway](https://www.thehubway.com) at [http://thehubway.com/data/stations/bikeStations.json](http://thehubway.com/data/stations/bikeStations.json)

## Technical Details
### Getting Started

Xcode 8+, iOS 9/0+ Swift 3+ is required in order open, build and run the application in a simulator or on a device.

Before opening the workspace, navigate to the directory where the RideNiceRide.xcodeproj is located and run the following command to populate the required CocoaPods.
```bash
pod install
```
Now you can open `RideNiceRide.xcworkspace` and Run the `RideNiceRide` target onto your simulator or iOS device.

### Code style

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

### Tools used during creation

- [Xcode](https://developer.apple.com/xcode/)
- [SourceTree](https://www.sourcetreeapp.com)
- [The Noun Project](https://thenounproject.com)
- [Gimp ](https://www.gimp.org)
- [Asset Catalog Creator](http://www.bridgetech.io)
- [Aspect Ratio Calculator](http://andrew.hedges.name/experiments/aspect_ratio)
- [BeyondCompare](http://www.scootersoftware.com)
- [SQLPro for SQLite](https://www.sqlitepro.com)
- [Postman](https://www.getpostman.com)
- [StackOverflow](www.stackoverflow.com)
- [Xamarin Studio Community Edition](https://www.xamarin.com)
- [GitHub Desktop](https://desktop.github.com)
- [Microsoft OneNote](https://www.onenote.com/download)
