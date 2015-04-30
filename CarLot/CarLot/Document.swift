import Cocoa

class Document: NSPersistentDocument, NSWindowDelegate {

    let tableView = NSTableView()
    let addButton = NSButton()
    let removeButton = NSButton()
    let datePicker = NSDatePicker()
    let imageViewCar = NSImageView()
    var documentView = NSView()

    override init() {
        super.init()
    }

    init(window: NSWindow?) {
        super.init()
        self.addWindowController(NSWindowController())

        (self.windowControllers.first as! NSWindowController).window = window
        self.documentView = window!.contentView as! NSView
        window?.delegate = self

        self.documentView.addSubview(self.tableView)
        self.documentView.addSubview(self.addButton)
        self.documentView.addSubview(self.removeButton)

        layoutFrameOfViews()

        self.addButton.bezelStyle = NSBezelStyle.RegularSquareBezelStyle
        self.addButton.title = "Add"
        self.removeButton.bezelStyle = NSBezelStyle.RegularSquareBezelStyle
        self.removeButton.title = "Remove"
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    // MARK: NSWindow delegate methods

    func windowDidResize(notification: NSNotification) {
        layoutFrameOfViews()
    }

    // MARK: Helper methods

    func layoutFrameOfViews() {
        self.tableView.frame = NSMakeRect(15, (self.documentView.frame.height * 0.6) - 15, self.documentView.frame.width - 30, (self.documentView.frame.height * 0.4))
        self.addButton.frame = NSMakeRect((self.documentView.frame.width * 0.867) - 15, self.documentView.frame.height - self.tableView.frame.height - 55, self.documentView.frame.width/7.5, 25)
        self.removeButton.frame = NSMakeRect(self.addButton.frame.origin.x - self.documentView.frame.width/7.5 - 15, self.documentView.frame.height - self.tableView.frame.height - 55, self.documentView.frame.width/7.5, 25)
    }
}
