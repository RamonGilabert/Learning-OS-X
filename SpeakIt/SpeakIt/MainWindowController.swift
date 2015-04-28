import Cocoa

class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate, NSWindowDelegate, NSTableViewDelegate, NSTableViewDataSource {

    let textField = NSTextField()
    let speechSynth = NSSpeechSynthesizer()
    let speakItButton = NSButton()
    let stopItButton = NSButton()
    let scrollView = NSScrollView()
    let tableView = NSTableView()
    var isSpeaking = false

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window!.title = "Speaking it"
        self.window!.backgroundColor = NSColor(calibratedHue:0.02, saturation:0.67, brightness:0.87, alpha:1)
        self.window!.delegate = self

        self.textField.placeholderString = "Enter the text you want the computer to say to you"
        self.window!.contentView.addSubview(self.textField)

        self.speechSynth.delegate = self
        self.tableView.setDelegate(self)
        self.tableView.setDataSource(self)

        let firstColumn = NSTableColumn(identifier: "firstColumn")
        firstColumn.width = self.tableView.frame.width
        self.tableView.addTableColumn(firstColumn)
        self.scrollView.documentView = self.tableView

        self.window!.contentView.addSubview(self.scrollView)
        self.tableView.reloadData()

        self.speakItButton.title = "Speak it"
        self.speakItButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.speakItButton.target = self
        self.speakItButton.action = "onSpeakItButtonPressed"
        self.window!.contentView.addSubview(self.speakItButton)

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

    // MARK: TableView delegate methods

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return NSSpeechSynthesizer.availableVoices()!.count
    }

    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let arrayOfVoices = NSSpeechSynthesizer.availableVoices() as! [String]
        var nameOfVoice = arrayOfVoices[row]
        nameOfVoice = getTheStringFromIdentifier(nameOfVoice)!
        return nameOfVoice
    }

    // MARK: NSSpeechSynthesizer delegate methods

    func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        self.isSpeaking = false
        updateButtons()
    }

    // MARK: NSWindow delegate methods

    func windowShouldClose(sender: AnyObject) -> Bool {
        return !self.isSpeaking
    }

    func windowDidResize(notification: NSNotification) {
        self.textField.frame = NSMakeRect(15, self.window!.contentView.frame.height - 15 - (self.window!.contentView.frame.height / 1.75), self.window!.contentView.frame.width - 230, self.window!.contentView.frame.height / 1.75)
        self.scrollView.frame = NSMakeRect(self.textField.frame.width + 30, self.window!.contentView.frame.height - 15 - (self.window!.contentView.frame.height / 1.75), self.window!.contentView.frame.width - self.textField.frame.width - 45, self.window!.contentView.frame.height / 1.75)
        self.speakItButton.frame = NSMakeRect(self.window!.contentView.frame.width - 82.5, self.textField.frame.origin.y - 65, 75, 25)
        self.stopItButton.frame = NSMakeRect(self.window!.contentView.frame.width - 155, self.textField.frame.origin.y - 65, 75, 25)
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

    func getTheStringFromIdentifier(identifier: String) -> String? {
        if let attributes = NSSpeechSynthesizer.attributesForVoice(identifier) {
            return attributes[NSVoiceName] as? String
        } else {
            return nil
        }
    }
}
