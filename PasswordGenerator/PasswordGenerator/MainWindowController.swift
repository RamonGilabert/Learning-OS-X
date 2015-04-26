import Cocoa

class MainWindowController: NSWindowController, NSUserNotificationCenterDelegate {

    var textFieldPassword = NSTextField()
    let viewModel = ViewModel()

    override var windowNibName: String? {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window!.title = "Random passwords"
        self.window!.backgroundColor = NSColor(calibratedHue:0.98, saturation:0.59, brightness:0.93, alpha:1)

        self.viewModel.setButtonToGeneratePassword(self.window!.contentView as! NSView)
        self.textFieldPassword = self.viewModel.setTextFieldInView(self.window!.contentView as! NSView)
    }

    func onGenerateButtonPressed() {
        self.textFieldPassword.stringValue = generateRandomString(10)

        let pasteboard = NSPasteboard.generalPasteboard()
        pasteboard.clearContents()
        pasteboard.writeObjects([self.textFieldPassword.stringValue])

        let notification = NSUserNotification()
        notification.title = "Password generator"
        notification.informativeText = "Your password has been copied to your clipboard"
        notification.soundName = NSUserNotificationDefaultSoundName

        NSUserNotificationCenter.defaultUserNotificationCenter().delegate = self
        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
    }

    // MARK: Notification delegate

    func userNotificationCenter(center: NSUserNotificationCenter, shouldPresentNotification notification: NSUserNotification) -> Bool {
        return true
    }
}
