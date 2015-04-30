import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController = Document()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let window = NSWindow(contentRect: NSMakeRect(100, 100, 575, 529), styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask, backing: NSBackingStoreType.Buffered, defer: false)
        window.title = "New Window"
        window.opaque = false
        window.center()
        window.movableByWindowBackground = true
        window.makeKeyAndOrderFront(true)
        window.minSize = CGSizeMake(575, 550)
        self.mainWindowController = Document(window: window)
    }
}

