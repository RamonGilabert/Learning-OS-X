import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var mainWindowController: MainWindowController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let window = NSWindow(contentRect: NSMakeRect(100, 100, 200, 200), styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask, backing: NSBackingStoreType.Buffered, defer: false)
        window.title = "New Window"
        window.opaque = false
        window.center()
        window.movableByWindowBackground = true
        window.makeKeyAndOrderFront(true)

        self.mainWindowController = MainWindowController(window: window)
    }
}

