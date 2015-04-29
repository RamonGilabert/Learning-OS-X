import Cocoa

class Employee: NSObject, NSCoding {

    var name: String? = "New employee"
    var raise: NSNumber? = 0.05

    func encodeWithCoder(aCoder: NSCoder) {
        if let name = self.name {
            aCoder.encodeObject(name, forKey: "name")
        }

        aCoder.encodeFloat(self.raise!.floatValue, forKey: "raise")
    }

    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.raise = aDecoder.decodeFloatForKey("raise")
        super.init()
    }

    override init() {
        super.init()
    }
}
