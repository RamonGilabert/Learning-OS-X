import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window!.title = "Random passwords"
        self.window!.backgroundColor = NSColor(calibratedHue:0.98, saturation:0.59, brightness:0.93, alpha:1)

        let buttonGenerate = NSButton(frame: NSMakeRect((self.window!.contentView.frame.width - 300)/2, 25, 300, 40))
        buttonGenerate.title = "Generate password"
        buttonGenerate.bezelStyle = NSBezelStyle.RegularSquareBezelStyle
        self.window!.contentView.addSubview(buttonGenerate)

        let textFieldPassword = NSTextField(frame: NSMakeRect((self.window!.contentView.frame.width - 300)/2, self.window!.contentView.frame.height - 175, 300, 50))
        self.window!.contentView.addSubview(textFieldPassword)
    }
}
