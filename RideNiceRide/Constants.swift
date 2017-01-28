//
//  Constants.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 1/27/17.
//  Copyright © 2017 Jeff Schmitz. All rights reserved.
//
import Foundation

//swiftlint:disable variable_name
//swiftlint:disable type_name
//swiftlint:disable type_body_length
//swiftlint:disable nesting
struct K {

  struct Map {
    static let Latitude          = "MapLatitude"
    static let LatitudeDelta     = "MapLatitudeDelta"
    static let Longitude         = "MapLongitude"
    static let LongitudeDelta    = "MapLongitudeDelta"
  }

  struct HubwayAPI {
    static let hubwayURL = "https://feeds.thehubway.com/stations/stations.json"
    static let hubwayProfileUrlString = "https://secure.thehubway.com/profile/"
  }

  struct GoogleServices {
    static let APIKey = "AIzaSyBCHjbd41ZVXvy3HBu-J1c8rn6d3Or6AFk"
  }
}
//swiftlint:enable nesting
//swiftlint:enable type_body_length
//swiftlint:enable type_name
//swiftlint:enable variable_name
