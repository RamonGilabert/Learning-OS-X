import Cocoa

class MainWindowController: NSWindowController, NSUserNotificationCenterDelegate {

    let textFieldPassword = NSTextField()

    override var windowNibName: String? {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window!.title = "Random passwords"
        self.window!.backgroundColor = NSColor(calibratedHue:0.98, saturation:0.59, brightness:0.93, alpha:1)

        let buttonGenerate = NSButton(frame: NSMakeRect((self.window!.contentView.frame.width - 300)/2, 25, 300, 40))
        buttonGenerate.title = "Generate password"
        buttonGenerate.bezelStyle = NSBezelStyle.RegularSquareBezelStyle
        buttonGenerate.target = self
        buttonGenerate.action = "onGenerateButtonPressed"
        self.window!.contentView.addSubview(buttonGenerate)

        self.textFieldPassword.frame = NSMakeRect((self.window!.contentView.frame.width - 300)/2, self.window!.contentView.frame.height - 175, 300, 50)
        self.textFieldPassword.placeholderString = "Tap generate password"
        self.textFieldPassword.font = NSFont(name: "AvenirNext-Regular", size: 22)
        self.textFieldPassword.alignment = NSTextAlignment.CenterTextAlignment
        self.textFieldPassword.editable = false
        self.textFieldPassword.selectable = true
        self.window!.contentView.addSubview(textFieldPassword)
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
