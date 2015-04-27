import Cocoa

class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate {

    let textField = NSTextField()
    let speechSynth = NSSpeechSynthesizer()
    let speakItButton = NSButton()
    let stopItButton = NSButton()
    var isSpeaking = false

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window!.title = "Speaking it"
        self.window!.backgroundColor = NSColor(calibratedHue:0.02, saturation:0.67, brightness:0.87, alpha:1)

        self.speechSynth.delegate = self

        self.textField.frame = NSMakeRect(15, self.window!.contentView.frame.height - 215, self.window!.contentView.frame.width - 30, 100)
        self.textField.placeholderString = "Enter the text you want the computer to say to you"
        self.window!.contentView.addSubview(self.textField)

        self.speakItButton.frame = NSMakeRect(self.window!.contentView.frame.width - 82.5, self.textField.frame.origin.y - 37.5, 75, 20)
        self.speakItButton.title = "Speak it"
        self.speakItButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.speakItButton.target = self
        self.speakItButton.action = "onSpeakItButtonPressed"
        self.window!.contentView.addSubview(self.speakItButton)

        self.stopItButton.frame = NSMakeRect(self.window!.contentView.frame.width - 155, self.textField.frame.origin.y - 37.5, 75, 20)
        self.stopItButton.title = "Stop it"
        self.stopItButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.stopItButton.target = self
        self.stopItButton.action = "onStopButtonPressed"
        self.window!.contentView.addSubview(self.stopItButton)

        updateButtons()
    }

    // MARK: Action handlers

    func onSpeakItButtonPressed() {
        if self.textField.stringValue.isEmpty {
            let alertNoText = NSAlert()
            alertNoText.messageText = "There's no text!"
            alertNoText.informativeText = "Write some in the text field and I'll speak it!"
            alertNoText.alertStyle = NSAlertStyle.WarningAlertStyle
            alertNoText.addButtonWithTitle("OK")
            alertNoText.runModal()
        } else {
            self.speechSynth.startSpeakingString(self.textField.stringValue)
            self.isSpeaking = true
            updateButtons()
        }
    }

    func onStopButtonPressed() {
        if self.isSpeaking {
            self.speechSynth.stopSpeaking()
            self.isSpeaking = false
            updateButtons()
        }
    }

    // MARK: NSSpeechSynthesizer delegate methods

    func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        self.isSpeaking = false
        updateButtons()
    }

    // MARK: Helper methods

    func updateButtons() {
        if self.isSpeaking {
            self.stopItButton.enabled = true
            self.speakItButton.enabled = false
        } else {
            self.stopItButton.enabled = false
            self.speakItButton.enabled = true
        }
    }
}
