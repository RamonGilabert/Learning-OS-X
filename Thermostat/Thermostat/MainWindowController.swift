import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {

    let temperatureSlider = NSSlider()
    let warmerButton = NSButton()
    let coolerButton = NSButton()
    let powerButton = NSButton()
    let textFieldTemperature = NSTextField()
    var temperature = 68
    var enableThermostat = true

    // MARK: View lifecycle

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window!.delegate = self
        self.window!.title = "Thermostat"

        self.window!.contentView.addSubview(self.temperatureSlider)
        self.window!.contentView.addSubview(self.textFieldTemperature)
        self.window!.contentView.addSubview(self.warmerButton)
        self.window!.contentView.addSubview(self.coolerButton)
        self.window!.contentView.addSubview(self.powerButton)

        self.temperatureSlider.minValue = 0
        self.temperatureSlider.maxValue = 100
        self.temperatureSlider.numberOfTickMarks = 25

        self.textFieldTemperature.selectable = false
        self.textFieldTemperature.editable = false
        self.textFieldTemperature.drawsBackground = false
        self.textFieldTemperature.bordered = false

        self.warmerButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.warmerButton.title = "Warmer"
        self.warmerButton.target = self
        self.warmerButton.action = "onWarmerButtonPressed"

        self.coolerButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.coolerButton.title = "Cooler"
        self.coolerButton.target = self
        self.coolerButton.action = "onCoolerButtonPressed"

        self.powerButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.powerButton.title = "Power"
        self.powerButton.setButtonType(NSButtonType.OnOffButton)

        self.temperatureSlider.bind("value", toObject: self, withKeyPath: "temperature", options: nil)
        self.temperatureSlider.bind("enabled", toObject: self, withKeyPath: "enableThermostat", options: nil)
        self.textFieldTemperature.bind("value", toObject: self, withKeyPath: "temperature", options: nil)
        self.warmerButton.bind("enabled", toObject: self, withKeyPath: "enableThermostat", options: nil)
        self.coolerButton.bind("enabled", toObject: self, withKeyPath: "enableThermostat", options: nil)
        self.powerButton.bind("value", toObject: self, withKeyPath: "enableThermostat", options: nil)
    }

    // MARK: Action handlers

    func onWarmerButtonPressed() {
        setValue(temperature + 1, forKey: "temperature")
    }

    func onCoolerButtonPressed() {
        setValue(temperature - 1, forKey: "temperature")
    }

    // MARK: NSWindowDelegate methods

    func windowDidResize(notification: NSNotification) {
        self.temperatureSlider.frame = NSMakeRect(15, 15, self.window!.frame.width/2, self.window!.frame.height - 50)
        self.textFieldTemperature.frame = NSMakeRect((self.window!.contentView.frame.width - 50)/2, (self.window!.contentView.frame.height - 30)/2, 30, 30)
        self.warmerButton.frame = NSMakeRect(self.window!.frame.width/2, self.window!.frame.height/2, self.window!.frame.width/2.5, self.window!.frame.height/2)
        self.coolerButton.frame = NSMakeRect(self.window!.frame.width/2, 0, self.window!.frame.width/2.5, self.window!.frame.height/2)
        self.powerButton.frame = NSMakeRect(self.window!.contentView.frame.width - 100, 15, 75, 30)
    }
}
