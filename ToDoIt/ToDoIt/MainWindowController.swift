import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate, NSTableViewDelegate, NSTableViewDataSource {

    let tableView = NSTableView()
    let textFieldToDo = NSTextField()
    let addButton = NSButton()

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window!.contentView.addSubview(self.textFieldToDo)
        self.window!.contentView.addSubview(self.tableView)
        self.window!.contentView.addSubview(self.addButton)

        self.textFieldToDo.placeholderString = "Enter your task here, then tap the add button..."

        self.addButton.bezelStyle = NSBezelStyle.RegularSquareBezelStyle
        self.addButton.target = self
        self.addButton.action = "onAddButtonPressed"

        self.window!.title = "Just doing it"
        self.window!.delegate = self
    }

    // MARK: Action handlers

    func onAddButtonPressed() {

    }

    // MARK: NSTableView delegate methods

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return 0
    }

    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        return nil
    }

    // MARK: NSWindow delegate methods

    func windowDidResize(notification: NSNotification) {
        self.textFieldToDo.frame = NSMakeRect(15, self.window!.contentView.frame.height - 45, self.window!.frame.width - 120, 30)
        self.tableView.frame = NSMakeRect(15, 15, self.window!.frame.width - 30, self.window!.frame.height - 95)
        self.addButton.frame = NSMakeRect(self.window!.frame.width - 90, self.window!.contentView.frame.height - 48, 75, 35)
    }
}
