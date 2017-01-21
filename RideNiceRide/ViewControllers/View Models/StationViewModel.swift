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
  fileprivate let appDelegate = UIApplication.shared.delegate as? AppDelegate
  fileprivate let dataStack = (UIApplication.shared.delegate as? AppDelegate)!.dataStack
  
  // MARK: Public Interface
  var stationId: String {
    return station.id ?? ""
  }
  
  var stationName: String {
    return station.stationName ?? ""
  }

  var address: String {
    return "\(station.stAddress1 ?? "") \(station.stAddress2 ?? "")"
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
