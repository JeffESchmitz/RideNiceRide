//
//  CustomAnnotation.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 1/10/17.
//  Copyright © 2017 Jeff Schmitz. All rights reserved.
//

import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
  
  var coordinate: CLLocationCoordinate2D
  
  var stationId: String?
  var stationName: String?
  var isStationLocked: Bool = false
  var availableBikes: Int = 0
  var availableDocks: Int = 0
  
//  // Title and subtitle for use by selection UI.
  var title: String?
  var subtitle: String?
  
  init(coordinate: CLLocationCoordinate2D) {
    self.coordinate = coordinate
  }
  
}
