import Cocoa

class ViewModel: NSObject {

    func setLabelAndSlider(windowController: NSWindowController, view: NSView, text: String, yValue: Int) -> NSSlider {
        let slider = NSSlider(frame: NSMakeRect(view.frame.width - 175, view.frame.height - CGFloat(50 * yValue), 150, 50))
        slider.minValue = 0.0
        slider.maxValue = 1.0
        slider.target = windowController
        slider.action = "onSliderMoved"
        view.addSubview(slider)

        let label = NSTextField(frame: NSMakeRect(slider.frame.origin.x - 17.5, slider.frame.origin.y + 8, 18, 18))
        label.stringValue = text
        label.font = NSFont(name: "AvenirNext-Regular", size: 16)
        label.sizeToFit()
        label.selectable = false
        label.editable = false
        label.bezeled = false
        label.bordered = false
        label.drawsBackground = false
        view.addSubview(label)

        return slider
    }

}
