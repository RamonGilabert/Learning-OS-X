import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window!.title = "Random passwords"
        self.window!.backgroundColor = NSColor(calibratedHue:0.98, saturation:0.59, brightness:0.93, alpha:1)

        let buttonGenerate = NSButton(frame: NSMakeRect((self.window!.contentView.frame.width - 300)/2, 40, 300, 50))
        buttonGenerate.title = "Generate password"
        buttonGenerate.bezelStyle = NSBezelStyle.RegularSquareBezelStyle
        self.window!.contentView.addSubview(buttonGenerate)
    }
}
