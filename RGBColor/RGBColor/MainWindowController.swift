import Cocoa

class MainWindowController: NSWindowController, NSUserNotificationCenterDelegate {

    let viewModel = ViewModel()
    var redSlider = NSSlider()
    var greenSlider = NSSlider()
    var blueSlider = NSSlider()
    var colorWell = NSColorWell()

    override var windowNibName: String? {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window!.title = "Color"

        NSUserNotificationCenter.defaultUserNotificationCenter().delegate = self

        self.redSlider = self.viewModel.setLabelAndSlider(self, view: self.window!.contentView as! NSView, text: "R", yValue: 1)
        self.greenSlider = self.viewModel.setLabelAndSlider(self, view: self.window!.contentView as! NSView, text: "G", yValue: 2)
        self.blueSlider = self.viewModel.setLabelAndSlider(self, view: self.window!.contentView as! NSView, text: "B", yValue: 3)
        self.colorWell = self.viewModel.setColorWell(self.window!.contentView as! NSView)
        self.viewModel.setButtonInView(self, view: self.window!.contentView as! NSView)
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
