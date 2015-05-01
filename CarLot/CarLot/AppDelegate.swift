import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController = Document()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let window = NSWindow(contentRect: NSMakeRect(100, 100, 510, 479), styleMask: NSTitledWindowMask | NSResizableWindowMask | NSMiniaturizableWindowMask | NSClosableWindowMask, backing: NSBackingStoreType.Buffered, defer: false)
        window.title = "New Window"
        window.opaque = false
        window.center()
        window.movableByWindowBackground = true
        window.makeKeyAndOrderFront(true)
        window.minSize = CGSizeMake(510, 500)
        self.mainWindowController = Document(window: window)
    }
}

