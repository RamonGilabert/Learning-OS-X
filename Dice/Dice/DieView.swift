import Cocoa

class DieView: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        let backgroundColor = NSColor.redColor()
        backgroundColor.set()
        NSBezierPath.fillRect(bounds)
    }
}
