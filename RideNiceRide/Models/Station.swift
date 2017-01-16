//
//  Station.swift
//  RideNiceRide
//
//  Created by Jeff Schmitz on 11/20/16.
//  Copyright © 2016 Jeff Schmitz. All rights reserved.
//

import Foundation
import CoreData

extension Station {

    convenience init(name: String = "Unknown",
                     address: String = "none",
                     bikes: String = "0",
                     docks: String = "0",
                     context: NSManagedObjectContext) {

        //An EntityDescription is an object that has access to all
        //the information you provided in the Entity part of the model
        //you need it to create an instance of this class.
        if let entity = NSEntityDescription.entity(forEntityName: "Station", in: context) {
            self.init(entity: entity, insertInto: context)
            self.stationName = name
            self.stAddress1 = address
            self.availableBikes = bikes
            self.totalDocks = docks
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
