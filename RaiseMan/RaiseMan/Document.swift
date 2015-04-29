import Cocoa

class Document: NSDocument, NSWindowDelegate, NSTableViewDelegate, NSTableViewDataSource {

    let scrollView = NSScrollView()
    let tableView = NSTableView()
    let addEmployeeButton = NSButton()
    let removeButton = NSButton()
    var documentWindow = NSWindow()
    var employees = NSMutableArray()
    var employeeToRemove = Employee()

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
        firstColumn.width = 160
        let secondColumn = NSTableColumn(identifier: "secondColumn")
        secondColumn.title = "Raise"
        self.tableView.addTableColumn(firstColumn)
        self.tableView.addTableColumn(secondColumn)
        self.tableView.setDelegate(self)
        self.tableView.setDataSource(self)
        self.scrollView.borderType = NSBorderType.BezelBorder
        self.scrollView.documentView = self.tableView

        self.addEmployeeButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.addEmployeeButton.title = "Add employee"
        self.addEmployeeButton.target = self
        self.addEmployeeButton.action = "addEmployee"

        self.removeButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.removeButton.title = "Remove"
        self.removeButton.target = self
        self.removeButton.action = "removeEmployee"
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

    // MARK: IBAction handlers

    func addEmployee() {
        self.employees.addObject(Employee())
        self.tableView.reloadData()
    }

    func removeEmployee() {
        if self.employees.containsObject(self.employeeToRemove) {
            self.tableView.deselectRow(self.employees.indexOfObject(self.employeeToRemove))
            self.employees.removeObject(self.employeeToRemove)
            self.tableView.reloadData()
        }
    }

    // MARK: NSTableView delegate methods

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        if self.employees.containsObject(self.employeeToRemove) {
            self.removeButton.enabled = true
        } else {
            self.removeButton.enabled = false
        }

        return self.employees.count
    }

    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let employee = self.employees[row] as! Employee

        if tableColumn!.identifier == "firstColumn" {
            return employee.name
        } else if tableColumn!.identifier == "secondColumn" {
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = NSNumberFormatterStyle.PercentStyle
            let formattedString = numberFormatter.stringFromNumber(employee.raise!)
            return formattedString
        }

        return nil
    }

    func tableViewSelectionDidChange(notification: NSNotification) {
        if self.tableView.selectedRow >= 0 {
            self.employeeToRemove = self.employees[self.tableView.selectedRow] as! Employee
            self.removeButton.enabled = true
        } else {
            self.removeButton.enabled = false
        }
    }

    override func controlTextDidEndEditing(obj: NSNotification) {
        let dictionary = obj.userInfo!
        let textView = dictionary["NSFieldEditor"] as! NSTextView
        let employee = self.employeeToRemove
        employee.name = textView.string!
        self.employees
        self.employees.removeObject(self.employeeToRemove)
        println(textView.string!)
    }

    // MARK: NSWindow delegate methods

    func windowDidResize(notification: NSNotification) {
        self.scrollView.frame = NSMakeRect(15, 15, self.documentWindow.contentView.frame.width/1.5, self.documentWindow.contentView.frame.height - 30)
        self.addEmployeeButton.frame = NSMakeRect(self.documentWindow.frame.width/1.5 + 30, self.documentWindow.contentView.frame.height - 42.5, self.documentWindow.contentView.frame.width - (self.documentWindow.contentView.frame.width/1.5) - 45, 35)
        self.removeButton.frame = NSMakeRect(self.documentWindow.frame.width/1.5 + 30, self.documentWindow.contentView.frame.height - 77.5, self.documentWindow.contentView.frame.width - (self.documentWindow.contentView.frame.width/1.5) - 45, 35)
    }
}
