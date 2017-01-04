//
//  StationViewModel.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 1/4/17.
//  Copyright © 2017 Jeff Schmitz. All rights reserved.
//

import UIKit

struct StationViewModel {
  
  // MARK: Properties
  let station: Station
  
  // MARK: -
  
  // MARK: Publice Interface
  var stationName: String {
    return station.stationName ?? ""
  }
  
  var address: String {
    //    return station.stAddress1 + " " + station.stAddress2
    return "\(station.stAddress1 ?? "") \(station.stAddress2 ?? "")"
  }
  
  var availableBikes: String {
    return station.availableBikes ?? ""
  }
  
  var availableDocks: String {
    return station.availableDocks ?? ""
  }
}
