import Cocoa

class Document: NSPersistentDocument {

    override init() {
        super.init()
    }

    init(window: NSWindow?) {
        super.init()
        let windowController = NSWindowController()
        self.addWindowController(windowController)
        (self.windowControllers.first as! NSWindowController).window = window
        window?.backgroundColor = NSColor.redColor()
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }
}
