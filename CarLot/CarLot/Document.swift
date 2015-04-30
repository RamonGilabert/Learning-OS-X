import Cocoa

class Document: NSPersistentDocument {

    let tableView = NSTableView()
    let addButton = NSButton()
    let removeButton = NSButton()
    let datePicker = NSDatePicker()
    let imageViewCar = NSImageView()
    var documentWindow = NSWindow()

    override init() {
        super.init()
    }

    init(window: NSWindow?) {
        super.init()
        self.addWindowController(NSWindowController())

        (self.windowControllers.first as! NSWindowController).window = window
        self.documentWindow = window!

        
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }
}
