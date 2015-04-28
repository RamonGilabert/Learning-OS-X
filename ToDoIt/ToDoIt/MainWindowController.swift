import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {

    let tableView = NSTableView()
    let textFieldToDo = NSTextField()
    let addButton = NSButton()

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window!.title = "Just doing it"
        self.window!.delegate = self
    }

    // MARK: NSWindow delegate methods

    func windowDidResize(notification: NSNotification) {
        
    }
}
