//
//  FavoriteStation.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 1/1/17.
//  Copyright © 2017 Jeff Schmitz. All rights reserved.
//

import Foundation
import CoreData

extension FavoriteStation {

    convenience init(stationName: String = "Unknown",
                     address1: String = "",
                     address2: String = "",
                     altitude: String = "",
                     availableBikes: String = "0",
                     availableDocks: String = "0",
                     city: String = "",
                     id: String = "",
                     landMark: String = "",
                     lastCommunicationTime: String = "",
                     latitude: String = "",
                     location: String = "",
                     longitude: String = "",
                     postalCode: String = "",
                     statusKey: String = "",
                     statusValue: String = "",
                     testStation: Bool = false,
                     totalDocks: String,
                     context: NSManagedObjectContext) {

        //An EntityDescription is an object that has access to all
        //the information you provided in the Entity part of the model
        //you need it to create an instance of this class.
        if let entity = NSEntityDescription.entity(forEntityName: "FavoriteStation", in: context) {
            self.init(entity: entity, insertInto: context)
            self.stationName            = stationName
            self.stAddress1             = address1
            self.stAddress2             = address2
            self.altitude               = altitude
            self.availableBikes         = availableBikes
            self.availableDocks         = availableDocks
            self.city                   = city
            self.id                     = id
            self.landMark               = landMark
            self.lastCommunicationTime  = lastCommunicationTime
            self.latitude               = latitude
            self.location               = location
            self.longitude              = longitude
            self.postalCode             = postalCode
            self.statusKey              = statusKey
            self.statusValue            = statusValue
            self.testStation            = testStation
            self.totalDocks             = totalDocks
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
