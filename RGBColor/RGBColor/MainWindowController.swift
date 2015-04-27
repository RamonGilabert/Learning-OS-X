import Cocoa

class MainWindowController: NSWindowController {

    let redSlider = NSSlider()
    let greenSlider = NSSlider()
    let blueSlider = NSSlider()
    let colorWell = NSColorWell()

    override var windowNibName: String? {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window!.title = "Color sliders"

        self.redSlider.frame = NSMakeRect(self.window!.contentView.frame.width - 175, self.window!.contentView.frame.height, 150, 50)
        self.redSlider.minValue = 0.0
        self.redSlider.maxValue = 1.0
        self.window!.contentView.addSubview(self.redSlider)

        let redLabel = NSTextField(frame: NSMakeRect(self.redSlider.frame.origin.x - 15, self.redSlider.frame.origin.y + 8, 18, 18))
        redLabel.selectable = false
        redLabel.editable = false
        redLabel.bezeled = false
        redLabel.bordered = false
        redLabel.drawsBackground = false
        redLabel.stringValue = "R"
        redLabel.font = NSFont(name: "AvenirNext-Regular", size: 16)
        redLabel.sizeToFit()
        self.window!.contentView.addSubview(redLabel)

        self.greenSlider.frame = NSMakeRect(self.window!.contentView.frame.width - 175, self.window!.contentView.frame.height - 100, 150, 50)
        self.greenSlider.minValue = 0.0
        self.greenSlider.maxValue = 1.0
        self.window!.contentView.addSubview(self.greenSlider)

        let redLabel = NSTextField(frame: NSMakeRect(self.redSlider.frame.origin.x - 15, self.redSlider.frame.origin.y + 8, 18, 18))
        redLabel.selectable = false
        redLabel.editable = false
        redLabel.bezeled = false
        redLabel.bordered = false
        redLabel.drawsBackground = false
        redLabel.stringValue = "R"
        redLabel.font = NSFont(name: "AvenirNext-Regular", size: 16)
        redLabel.sizeToFit()
        self.window!.contentView.addSubview(redLabel)

        self.blueSlider.frame = NSMakeRect(self.window!.contentView.frame.width - 175, self.window!.contentView.frame.height - 200, 150, 50)
        self.blueSlider.minValue = 0.0
        self.blueSlider.maxValue = 1.0
        self.window!.contentView.addSubview(self.blueSlider)
    }
    
}
