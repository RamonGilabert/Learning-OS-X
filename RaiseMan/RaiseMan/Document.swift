import Cocoa

class Document: NSDocument, NSWindowDelegate {

    let scrollView = NSScrollView()
    let tableView = NSTableView()
    let addEmployeeButton = NSButton()
    let removeButton = NSButton()
    var documentWindow = NSWindow()

    override init() {
        super.init()
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        let windowController = self.windowControllers[0] as! NSWindowController
        self.documentWindow = windowController.window!
        self.documentWindow.delegate = self
        self.documentWindow.minSize = NSMakeSize(500, 200)

        self.documentWindow.contentView.addSubview(self.scrollView)
        self.documentWindow.contentView.addSubview(self.addEmployeeButton)
        self.documentWindow.contentView.addSubview(self.removeButton)

        let firstColumn = NSTableColumn(identifier: "firstColumn")
        firstColumn.title = "Name"
        firstColumn.width = 150
        let secondColumn = NSTableColumn(identifier: "secondColumn")
        secondColumn.title = "Raise"
        self.tableView.addTableColumn(firstColumn)
        self.tableView.addTableColumn(secondColumn)
        self.scrollView.borderType = NSBorderType.BezelBorder
        self.scrollView.documentView = self.tableView

        self.addEmployeeButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.addEmployeeButton.title = "Add employee"

        self.removeButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.removeButton.title = "Remove"
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
        self.scrollView.frame = NSMakeRect(15, 15, self.documentWindow.contentView.frame.width/1.5, self.documentWindow.contentView.frame.height - 30)
        self.addEmployeeButton.frame = NSMakeRect(self.documentWindow.frame.width/1.5 + 30, self.documentWindow.contentView.frame.height - 42.5, self.documentWindow.contentView.frame.width - (self.documentWindow.contentView.frame.width/1.5) - 45, 35)
        self.removeButton.frame = NSMakeRect(self.documentWindow.frame.width/1.5 + 30, self.documentWindow.contentView.frame.height - 77.5, self.documentWindow.contentView.frame.width - (self.documentWindow.contentView.frame.width/1.5) - 45, 35)
    }
}
