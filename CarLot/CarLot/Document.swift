import Cocoa

class Document: NSPersistentDocument, NSWindowDelegate, NSTableViewDelegate, NSTableViewDataSource {

    let tableView = NSTableView()
    let addButton = NSButton()
    let removeButton = NSButton()
    let datePicker = NSDatePicker()
    let imageViewCar = NSImageView()
    let levelIndicator = NSLevelIndicator()
    let labelExplanation = NSTextField()
    var labelDate = NSTextField()
    var labelCondition = NSTextField()
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
        self.documentView.addSubview(self.imageViewCar)
        self.documentView.addSubview(self.labelDate)
        self.documentView.addSubview(self.datePicker)
        self.documentView.addSubview(self.labelCondition)
        self.documentView.addSubview(self.levelIndicator)

        let firstColumn = NSTableColumn(identifier: "firstColumn")
        firstColumn.title = "Make/Model"
        firstColumn.width = self.tableView.frame.width/1.5
        let secondColumn = NSTableColumn(identifier: "secondColumn")
        secondColumn.title = "Price"
        secondColumn.width = 150
        let thirdColumn = NSTableColumn(identifier: "thirdColumn")
        thirdColumn.title = "Special"

        self.tableView.addTableColumn(firstColumn)
        self.tableView.addTableColumn(secondColumn)
        self.tableView.addTableColumn(thirdColumn)
        self.tableView.setDelegate(self)
        self.tableView.setDataSource(self)

        self.imageViewCar.editable = true

        self.datePicker.dateValue = NSDate()
        self.datePicker.datePickerElements = NSDatePickerElementFlags.YearMonthDayDatePickerElementFlag
        self.datePicker.drawsBackground = true
        self.datePicker.backgroundColor = NSColor.whiteColor()

        let levelIndicatorCell = self.levelIndicator.cell() as! NSLevelIndicatorCell
        levelIndicatorCell.editable = true
        self.levelIndicator.levelIndicatorStyle = NSLevelIndicatorStyle.RatingLevelIndicatorStyle
        self.levelIndicator.minValue = 0
        self.levelIndicator.maxValue = 5
        self.levelIndicator.warningValue = 2
        self.levelIndicator.criticalValue = 2
        self.levelIndicator.integerValue = 2

        self.labelDate = configureTextField(self.labelDate)
        self.labelCondition = configureTextField(self.labelCondition)

        self.labelDate.stringValue = "Date purchased"
        self.labelCondition.stringValue = "Condition"
        self.labelCondition.alignment = NSTextAlignment.RightTextAlignment

        self.addButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.addButton.title = "Add"
        self.removeButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.removeButton.title = "Remove"

        layoutFrameOfViews()
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    // MARK: NSTableView delegate methods

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return 10
    }

    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        return nil
    }

    // MARK: NSWindow delegate methods

    func windowDidResize(notification: NSNotification) {
        layoutFrameOfViews()
    }

    // MARK: Helper methods

    func layoutFrameOfViews() {
        self.tableView.frame = NSMakeRect(15, (self.documentView.frame.height * 0.6) - 15, self.documentView.frame.width - 30, (self.documentView.frame.height * 0.4))
        self.addButton.frame = NSMakeRect((self.documentView.frame.width * 0.867) - 15, self.documentView.frame.height - self.tableView.frame.height - 55, self.documentView.frame.width/7.5, 25)
        self.removeButton.frame = NSMakeRect(self.addButton.frame.origin.x - self.documentView.frame.width/7.5, self.documentView.frame.height - self.tableView.frame.height - 55, self.documentView.frame.width/7.5, 25)
        self.imageViewCar.frame = NSMakeRect(self.documentView.frame.width / 2, 15, self.documentView.frame.width/2 - 15, self.documentView.frame.height - self.tableView.frame.height - 85)
        self.datePicker.frame = NSMakeRect(self.documentView.frame.width - self.imageViewCar.frame.width - self.documentView.frame.width/5 - 30, self.imageViewCar.frame.height - 5, self.documentView.frame.width/5, 75)
        self.levelIndicator.frame = NSMakeRect(self.documentView.frame.width - self.imageViewCar.frame.width - self.documentView.frame.width/5 - 30, self.imageViewCar.frame.height - self.datePicker.frame.height, self.documentView.frame.width/5, 75)
        self.labelDate.frame = NSMakeRect(self.documentView.frame.width - self.imageViewCar.frame.width - self.documentView.frame.width/2.5 - 32.5, self.imageViewCar.frame.height - 5, self.documentView.frame.width/2.5, 25)
        self.labelDate.sizeToFit()
        self.labelCondition.frame = NSMakeRect(self.documentView.frame.width - self.imageViewCar.frame.width - self.documentView.frame.width/2.5 - 32.5, self.imageViewCar.frame.height - self.datePicker.frame.height + 25, self.documentView.frame.width/2.5, 25)
        self.labelCondition.sizeToFit()
    }

    func configureTextField(textField: NSTextField) -> NSTextField {
        textField.selectable = false
        textField.editable = false
        textField.drawsBackground = false
        textField.bezeled = false
        textField.font = NSFont(name: "AvenirNext-Regular", size: 15)
        textField.sizeToFit()

        return textField
    }
}
