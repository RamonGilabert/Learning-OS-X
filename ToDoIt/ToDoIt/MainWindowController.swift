import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate, NSTableViewDelegate, NSTableViewDataSource {

    let scrollView = NSScrollView()
    let tableView = NSTableView()
    let textFieldToDo = NSTextField()
    let addButton = NSButton()
    let arrayWithTasks = NSMutableArray()

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window!.title = "Just doing it"
        self.window!.backgroundColor = NSColor(calibratedHue:0.87, saturation:0.44, brightness:0.97, alpha:1)
        self.window!.delegate = self

        self.window!.contentView.addSubview(self.textFieldToDo)
        self.window!.contentView.addSubview(self.scrollView)
        self.window!.contentView.addSubview(self.addButton)

        self.textFieldToDo.placeholderString = "Enter your task here, then tap the add button..."

        let firstColumn = NSTableColumn(identifier: "firstColumn")
        firstColumn.title = "Tasks"
        self.tableView.addTableColumn(firstColumn)
        self.scrollView.borderType = NSBorderType.BezelBorder
        self.scrollView.documentView = self.tableView

        self.tableView.setDelegate(self)
        self.tableView.setDataSource(self)

        self.addButton.bezelStyle = NSBezelStyle.RegularSquareBezelStyle
        self.addButton.title = "Add"
        self.addButton.target = self
        self.addButton.action = "onAddButtonPressed"
    }

    // MARK: Action handlers

    func onAddButtonPressed() {
        self.arrayWithTasks.addObject(self.textFieldToDo.stringValue)
        self.tableView.reloadData()
    }

    // MARK: NSTableView delegate methods

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.arrayWithTasks.count
    }

    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        return self.arrayWithTasks[row]
    }

    // MARK: NSWindow delegate methods

    func windowDidResize(notification: NSNotification) {
        self.textFieldToDo.frame = NSMakeRect(15, self.window!.contentView.frame.height - 45, self.window!.frame.width - 120, 30)
        self.scrollView.frame = NSMakeRect(15, 15, self.window!.frame.width - 30, self.window!.frame.height - 95)
        self.addButton.frame = NSMakeRect(self.window!.frame.width - 90, self.window!.contentView.frame.height - 48, 75, 35)
    }
}
