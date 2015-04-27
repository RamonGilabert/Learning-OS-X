import Cocoa

class MainWindowController: NSWindowController, NSUserNotificationCenterDelegate {

    let redSlider = NSSlider()
    let greenSlider = NSSlider()
    let blueSlider = NSSlider()
    let colorWell = NSColorWell()

    override var windowNibName: String? {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window!.title = "Color"

        NSUserNotificationCenter.defaultUserNotificationCenter().delegate = self

        self.redSlider.frame = NSMakeRect(self.window!.contentView.frame.width - 175, self.window!.contentView.frame.height - 50, 150, 50)
        self.redSlider.minValue = 0.0
        self.redSlider.maxValue = 1.0
        self.redSlider.target = self
        self.redSlider.action = "onSliderMoved"
        self.window!.contentView.addSubview(self.redSlider)

        let redLabel = NSTextField(frame: NSMakeRect(self.redSlider.frame.origin.x - 17.5, self.redSlider.frame.origin.y + 8, 18, 18))
        redLabel.stringValue = "R"
        redLabel.font = NSFont(name: "AvenirNext-Regular", size: 16)
        redLabel.sizeToFit()
        redLabel.selectable = false
        redLabel.editable = false
        redLabel.bezeled = false
        redLabel.bordered = false
        redLabel.drawsBackground = false
        self.window!.contentView.addSubview(redLabel)

        self.greenSlider.frame = NSMakeRect(self.window!.contentView.frame.width - 175, self.window!.contentView.frame.height - 100, 150, 50)
        self.greenSlider.minValue = 0.0
        self.greenSlider.maxValue = 1.0
        self.greenSlider.action = "onSliderMoved"
        self.window!.contentView.addSubview(self.greenSlider)

        let greenLabel = NSTextField(frame: NSMakeRect(self.greenSlider.frame.origin.x - 17.5, self.greenSlider.frame.origin.y + 8, 18, 18))
        greenLabel.stringValue = "G"
        greenLabel.font = NSFont(name: "AvenirNext-Regular", size: 16)
        greenLabel.sizeToFit()
        greenLabel.selectable = false
        greenLabel.editable = false
        greenLabel.bezeled = false
        greenLabel.bordered = false
        greenLabel.drawsBackground = false
        self.window!.contentView.addSubview(greenLabel)

        self.blueSlider.frame = NSMakeRect(self.window!.contentView.frame.width - 175, self.window!.contentView.frame.height - 150, 150, 50)
        self.blueSlider.minValue = 0.0
        self.blueSlider.maxValue = 1.0
        self.blueSlider.action = "onSliderMoved"
        self.window!.contentView.addSubview(self.blueSlider)

        let blueLabel = NSTextField(frame: NSMakeRect(self.blueSlider.frame.origin.x - 17.5, self.blueSlider.frame.origin.y + 8, 18, 18))
        blueLabel.drawsBackground = false
        blueLabel.stringValue = "B"
        blueLabel.font = NSFont(name: "AvenirNext-Regular", size: 16)
        blueLabel.sizeToFit()
        blueLabel.selectable = false
        blueLabel.editable = false
        blueLabel.bezeled = false
        blueLabel.bordered = false
        self.window!.contentView.addSubview(blueLabel)

        self.colorWell.frame = NSMakeRect(15, 15, self.window!.contentView.frame.width - 225, self.window!.contentView.frame.height)
        self.colorWell.bordered = true
        self.colorWell.enabled = false
        self.colorWell.color = NSColor(calibratedRed: CGFloat(self.redSlider.floatValue), green: CGFloat(self.greenSlider.floatValue), blue: CGFloat(self.blueSlider.floatValue), alpha: 1.0)
        self.window!.contentView.addSubview(self.colorWell)

        let colorButton = NSButton(frame: NSMakeRect(self.redSlider.frame.origin.x - 10, self.blueSlider.frame.origin.y - 75, 165, 50))
        colorButton.target = self
        colorButton.action = "onGetColorButtonPressed"
        colorButton.title = "Get color"
        colorButton.bezelStyle = NSBezelStyle.RegularSquareBezelStyle
        self.window!.contentView.addSubview(colorButton)
    }

    // MARK: Slider methods

    func onSliderMoved() {
        self.colorWell.color = NSColor(calibratedRed: CGFloat(self.redSlider.floatValue), green: CGFloat(self.greenSlider.floatValue), blue: CGFloat(self.blueSlider.floatValue), alpha: 1.0)
    }

    // MARK: Button methods

    func onGetColorButtonPressed() {
        let pasteboard = NSPasteboard.generalPasteboard()
        pasteboard.clearContents()
        pasteboard.setString(String(format: "NSColor(calibratedRed: %.2f, green: %.2f, blue: %.2f, alpha: 1.0)", self.redSlider.floatValue, self.greenSlider.floatValue, self.blueSlider.floatValue), forType: NSStringPboardType)

        let notification = NSUserNotification()
        notification.title = "Color copied"
        notification.informativeText = "Your color has been copied to your clipboard"
        notification.soundName = NSUserNotificationDefaultSoundName

        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
    }

    // MARK: Notification delegate

    func userNotificationCenter(center: NSUserNotificationCenter, shouldPresentNotification notification: NSUserNotification) -> Bool {
        return true
    }
}
