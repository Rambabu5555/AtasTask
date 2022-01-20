//
//  Locations+CoreDataClass.swift
//  
//
//  Created by Ram on 20/01/22.
//
//

import Foundation
import CoreData

@objc(Locations)
public class Locations: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Locations> {
        return NSFetchRequest<Locations>(entityName: "Locations")
    }

    @NSManaged public var lattitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    
}
