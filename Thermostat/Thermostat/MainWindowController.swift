import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {

    let temperatureSlider = NSSlider()
    let warmerButton = NSButton()
    let coolerButton = NSButton()

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window!.delegate = self
        self.window!.title = "Thermostat"

        self.window!.contentView.addSubview(self.temperatureSlider)
        self.window!.contentView.addSubview(self.warmerButton)
        self.window!.contentView.addSubview(self.coolerButton)

        self.temperatureSlider.minValue = 0
        self.temperatureSlider.maxValue = 100
        self.temperatureSlider.numberOfTickMarks = 25

        self.warmerButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.warmerButton.title = "Warmer"

        self.coolerButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.coolerButton.title = "Cooler"
    }

    // MARK: NSWindowDelegate methods

    func windowDidResize(notification: NSNotification) {
        self.temperatureSlider.frame = NSMakeRect(15, 15, self.window!.frame.width/2, self.window!.frame.height - 50)
        self.warmerButton.frame = NSMakeRect(self.window!.frame.width/2, self.window!.frame.height/2, self.window!.frame.width/2.5, self.window!.frame.height/2)
        self.coolerButton.frame = NSMakeRect(self.window!.frame.width/2, 0, self.window!.frame.width/2.5, self.window!.frame.height/2)
    }
}
