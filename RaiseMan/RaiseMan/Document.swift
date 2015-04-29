import Cocoa

class Document: NSDocument, NSWindowDelegate {

    let tableView = NSTableView()
    var documentWindow = NSWindow()

    override init() {
        super.init()
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        let windowController = self.windowControllers[0] as! NSWindowController
        self.documentWindow = windowController.window!
        self.documentWindow.delegate = self

        self.documentWindow.contentView.addSubview(self.tableView)

    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override var windowNibName: String? {
        return "Document"
    }

    override func dataOfType(typeName: String, error outError: NSErrorPointer) -> NSData? {
        return nil
    }

    override func readFromData(data: NSData, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
        return false
    }

    // MARK: NSWindow delegate methods

    func windowDidResize(notification: NSNotification) {
        self.tableView.frame = NSMakeRect(15, 15, self.documentWindow.contentView.frame.width/1.5, self.documentWindow.contentView.frame.height - 30)
    }
}
