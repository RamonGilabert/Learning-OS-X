import Foundation
import CoreData

class Car: NSManagedObject {

    @NSManaged var image: NSData
    @NSManaged var condition: NSNumber
    @NSManaged var model: String
    @NSManaged var price: NSNumber
    @NSManaged var special: NSNumber
    @NSManaged var date: NSDate

}
