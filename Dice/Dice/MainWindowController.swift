import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {

    let dieView = DieView()
    var contentView = NSView()

    override init(window: NSWindow?) {
        super.init(window: window)
        window?.delegate = self
        self.contentView = window!.contentView as! NSView

        self.contentView.addSubview(self.dieView)

        layoutSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Window delegate methods

    func windowDidResize(notification: NSNotification) {
        layoutSubviews()
    }

    // MARK: Helper methods

    func layoutSubviews() {
        self.dieView.frame = NSMakeRect(15, 15, self.contentView.frame.width - 30, self.contentView.frame.height - 30)
    }
}
