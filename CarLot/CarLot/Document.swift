import Cocoa

class Document: NSPersistentDocument, NSWindowDelegate, NSTableViewDelegate, NSTableViewDataSource {

    let scrollView = NSScrollView()
    let tableView = NSTableView()
    let addButton = NSButton()
    let removeButton = NSButton()
    let datePicker = NSDatePicker()
    let imageViewCar = NSImageView()
    let levelIndicator = NSLevelIndicator()
    let boxContainer = NSBox()
    var labelDate = NSTextField()
    var labelCondition = NSTextField()
    var documentView = NSView()
    var cars = NSMutableArray()
    var carSelected = Car()

    override init() {
        super.init()
    }

    init(window: NSWindow?) {
        super.init()
        self.addWindowController(NSWindowController())

        (self.windowControllers.first as! NSWindowController).window = window
        self.documentView = window!.contentView as! NSView
        window?.delegate = self

        self.documentView.addSubview(self.scrollView)
        self.documentView.addSubview(self.addButton)
        self.documentView.addSubview(self.removeButton)
        self.documentView.addSubview(self.boxContainer)
        self.boxContainer.addSubview(self.imageViewCar)
        self.boxContainer.addSubview(self.labelDate)
        self.boxContainer.addSubview(self.datePicker)
        self.boxContainer.addSubview(self.labelCondition)
        self.boxContainer.addSubview(self.levelIndicator)

        let firstColumn = NSTableColumn(identifier: "firstColumn")
        firstColumn.title = "Make/Model"
        firstColumn.width = 250
        let secondColumn = NSTableColumn(identifier: "secondColumn")
        secondColumn.title = "Price"
        secondColumn.width = 125
        let thirdColumn = NSTableColumn(identifier: "thirdColumn")
        thirdColumn.title = "Special"

        self.tableView.addTableColumn(firstColumn)
        self.tableView.addTableColumn(secondColumn)
        self.tableView.addTableColumn(thirdColumn)
        self.tableView.setDelegate(self)
        self.tableView.setDataSource(self)
        self.scrollView.documentView = self.tableView

        self.boxContainer.title = "Car details"

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
        self.addButton.target = self
        self.addButton.action = "onAddButtonPressed"
        self.removeButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.removeButton.title = "Remove"
        self.removeButton.target = self
        self.removeButton.action = "onRemoveButtonPressed"

        self.removeButton.enabled = false
        self.boxContainer.hidden = true

        layoutFrameOfViews()
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    // MARK: NSTableView delegate methods

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.cars.count
    }

    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let car = self.cars[row] as! Car

        if tableColumn?.identifier == "firstColumn" {
            let textField = NSTextField()
            textField.bezeled = false
            textField.backgroundColor = NSColor.clearColor()
            textField.stringValue = car.model
            textField.tag = row
            textField.target = self
            textField.action = "onModelTextFieldDidChange:"
            return textField
        } else if tableColumn?.identifier == "secondColumn" {
            let view = NSTextField()
            view.bezeled = false
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            view.stringValue = numberFormatter.stringFromNumber(car.price)!
            view.backgroundColor = NSColor.clearColor()
            view.target = self
            view.action = "onPriceTextFieldDidChange:"
            return view
        } else {
            let checkBox = NSButton()
            checkBox.setButtonType(NSButtonType.SwitchButton)
            checkBox.title = ""
            checkBox.integerValue = car.special.integerValue
            checkBox.tag = row
            checkBox.target = self
            checkBox.action = "onCheckBoxClicked:"
            return checkBox
        }
    }

    func tableViewSelectionDidChange(notification: NSNotification) {
        if self.tableView.selectedRow >= 0 {
            self.removeButton.enabled = true
            self.boxContainer.hidden = false
            self.carSelected = self.cars[self.tableView.selectedRow] as! Car
        } else {
            self.removeButton.enabled = false
            self.boxContainer.hidden = true
        }
    }

    func onModelTextFieldDidChange(sender: NSTextField) {
        let car = self.cars[sender.tag] as! Car
        car.model = sender.stringValue
    }

    func onPriceTextFieldDidChange(sender: NSTextField) {
        let car = self.cars[sender.tag] as! Car
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        car.price = numberFormatter.numberFromString(sender.stringValue)!
    }

    func onCheckBoxClicked(sender: NSButton) {
        let car = self.cars[sender.tag] as! Car
        car.special = sender.integerValue
    }

    // MARK: NSWindow delegate methods

    func windowDidResize(notification: NSNotification) {
        layoutFrameOfViews()
    }

    // MARK: Action methods

    func onAddButtonPressed() {
        let car = Car()
        car.model = "Model name"
        car.price = 1000
        car.special = 0
        self.cars.addObject(car)
        self.tableView.reloadData()
    }

    func onRemoveButtonPressed() {
        if self.cars.containsObject(self.carSelected) {
            self.tableView.deselectRow(self.cars.indexOfObject(self.carSelected))
            self.cars.removeObject(self.carSelected)
            self.tableView.reloadData()
        }
    }

    // MARK: Helper methods

    func layoutFrameOfViews() {
        self.scrollView.frame = NSMakeRect(15, (self.documentView.frame.height * 0.6) - 15, self.documentView.frame.width - 30, (self.documentView.frame.height * 0.4))

        self.addButton.frame = NSMakeRect((self.documentView.frame.width * 0.867) - 15, self.documentView.frame.height - self.scrollView.frame.height - 55, self.documentView.frame.width/7.5, 25)

        self.removeButton.frame = NSMakeRect(self.addButton.frame.origin.x - self.documentView.frame.width/6.5, self.documentView.frame.height - self.scrollView.frame.height - 55, self.documentView.frame.width/6.5, 25)

        self.boxContainer.frame = NSMakeRect(15, 15, self.documentView.frame.width - 30, self.documentView.frame.height - self.scrollView.frame.height - 67.5)

        self.imageViewCar.frame = NSMakeRect(self.boxContainer.frame.width / 2, 15, self.boxContainer.frame.width/2 - 27.5, self.boxContainer.frame.height - 52.5)

        self.datePicker.frame = NSMakeRect(self.boxContainer.frame.width - self.imageViewCar.frame.width - self.boxContainer.frame.width/5 - 40, self.imageViewCar.frame.height - 5, self.boxContainer.frame.width/5, 75)

        self.levelIndicator.frame = NSMakeRect(self.boxContainer.frame.width - self.imageViewCar.frame.width - self.boxContainer.frame.width/5 - 40, self.imageViewCar.frame.height - self.datePicker.frame.height, self.boxContainer.frame.width/5, 75)

        self.labelDate.frame = NSMakeRect(15, self.imageViewCar.frame.height - 10, self.boxContainer.frame.width/5, 25)

        self.labelCondition.frame = NSMakeRect(15, self.imageViewCar.frame.height - 54, self.boxContainer.frame.width/5, 25)
    }

    func configureTextField(textField: NSTextField) -> NSTextField {
        textField.selectable = false
        textField.editable = false
        textField.drawsBackground = false
        textField.bezeled = false
        textField.alignment = NSTextAlignment.RightTextAlignment

        return textField
    }
}
