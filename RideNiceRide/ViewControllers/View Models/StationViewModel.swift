//
//  StationViewModel.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 1/4/17.
//  Copyright © 2017 Jeff Schmitz. All rights reserved.
//
import UIKit
import Cent
import Dollar

struct StationViewModel {

  // MARK: Properties
  let station: Station

  // MARK: -
  fileprivate let appDelegate = UIApplication.shared.delegate as? AppDelegate
  fileprivate let dataStack = (UIApplication.shared.delegate as? AppDelegate)!.dataStack

  // MARK: Public Interface
  var stationId: String {
    return station.id ?? ""
  }

  var stationName: String {
    if !(station.stationName?.contains("-"))! {
      return station.stationName?.strip() ?? ""
    } else {
      return (station.stationName?.split(delimiter: "-").first()?.strip())!
    }
  }

  var address: String {
    let addressSandwich = "\(station.stAddress1 ?? "") \(station.stAddress2 ?? "")"
    if !addressSandwich.contains("-") {
      return addressSandwich.strip()
    } else {
      return (addressSandwich.split(delimiter: "-").last()?.strip())!
    }
  }

  var availableBikes: String {
    return station.availableBikes ?? ""
  }

  var availableDocks: String {
    return station.availableDocks ?? ""
  }

  var isStationAFavorite: Bool {
    guard !self.stationId.isEmpty else {
      return false
    }
    let predicate = NSPredicate(format: "id = %@", self.stationId)
    let resultCount = HubwayAPI.fetchCountFor(entityName: "FavoriteStation", predicate: predicate, in: dataStack.mainContext)
    return (resultCount > 0)
  }
}
