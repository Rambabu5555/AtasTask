

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    // MARK: - properties
    static let shared = CoreDataManager()
    private init() {}
    typealias CompletionHandler = (_ success:Bool) -> Void
    typealias CompletionLocationsHandler = (_ locations: [Locations]) -> Void

    // MARK: - Utilities
    func saveLocation(name: String, lat: Double, long: Double, completionHandler: CompletionHandler) {
        let context = CoreDataStack.shared.getMainContext()
        let entity = NSEntityDescription.entity(forEntityName: "Locations", in: context)
        let favData = NSManagedObject(entity: entity!, insertInto: context)
        favData.setValue(name, forKey: "name")
        favData.setValue(lat, forKey: "lattitude")
        favData.setValue(long, forKey: "longitude")
        do {
            try context.save()
            completionHandler(true)
        } catch {
            #if DEBUG
            print("Failed saving")
            #endif
            completionHandler(false)
        }
    }
    func deleteSavedLocation(name: String) {
        let context = CoreDataStack.shared.getMainContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Locations")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                context.delete(object)
            }
        }
    }
    func fetchAllBookmarkedLocations(completionHandler: CompletionLocationsHandler) {
        let context = CoreDataStack.shared.getMainContext()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Locations.self)) as NSFetchRequest
        fetchReq.returnsObjectsAsFaults = false
        do {
            if let objects = try context.fetch(fetchReq) as? [Locations] {
                completionHandler(objects)
            }
        } catch {
            #if DEBUG
            print(error)
            #endif
            completionHandler([])
        }
    }
    func isLocationBookmarked(name: String) -> Bool {
        let context = CoreDataStack.shared.getMainContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Locations")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)

        var results: [NSManagedObject] = []
        do {
            results = try context.fetch(fetchRequest)
        }
        catch {
            #if DEBUG
            print("error executing fetch request: \(error)")
            #endif
        }
        return results.count > 0
    }
   
}
