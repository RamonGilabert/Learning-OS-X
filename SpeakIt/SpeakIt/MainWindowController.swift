import Cocoa

class MainWindowController: NSWindowController {

    let textField = NSTextField()

    override func windowDidLoad() {
        super.windowDidLoad()

        self.textField.frame = NSMakeRect(15, self.window!.contentView.frame.height - 215, self.window!.contentView.frame.width - 30, 100)
        self.textField.placeholderString = "Enter the text you want the computer to say to you"
        self.window!.contentView.addSubview(self.textField)

        let speakItButton = NSButton(frame: NSMakeRect(self.window!.contentView.frame.width - 82.5, self.textField.frame.origin.y - 37.5, 75, 20))
        speakItButton.title = "Speak it"
        speakItButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.window!.contentView.addSubview(speakItButton)

        let stopItButton = NSButton(frame: NSMakeRect(self.window!.contentView.frame.width - 155, self.textField.frame.origin.y - 37.5, 75, 20))
        stopItButton.title = "Stop it"
        stopItButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.window!.contentView.addSubview(stopItButton)
    }
}
