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
    
    convenience init(name: String = "Unknown",
                     address: String = "none",
                     bikes: String = "0",
                     docks: String = "0",
                     context: NSManagedObjectContext) {
        
        //An EntityDescription is an object that has access to all
        //the information you provided in the Entity part of the model
        //you need it to create an instance of this class.
        let foo = String.className(FavoriteStation.self)
        print("foo: \(foo)")
        let bar = String(describing: FavoriteStation.self)
        print("bar: \(bar)")
//        let foobar = FavoriteStation.typeName
//        print("foobar: \(foobar)")
        if let entity = NSEntityDescription.entity(forEntityName: String(describing: FavoriteStation.self), in: context) {
            self.init(entity: entity, insertInto: context)
            self.stationName = name
            self.stAddress1 = address
            self.availableBikes = bikes
            self.totalDocks = docks
        } else {
            fatalError("Unable to find Entity '\(bar)' name!")
        }
    }
}
