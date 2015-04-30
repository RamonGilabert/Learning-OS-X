import Cocoa

class Document: NSPersistentDocument {

    var documentWindow = NSWindow()

    override init() {
        super.init()
    }

    init(window: NSWindow?) {
        super.init()
        let windowController = NSWindowController()
        self.addWindowController(windowController)
        (self.windowControllers.first as! NSWindowController).window = window
        self.documentWindow = window!
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }
}
