import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var mainWindowController: MainWindowController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let mainWindowController = MainWindowController(windowNibName: "MainWindowController")
        mainWindowController.showWindow(self)
        self.mainWindowController = mainWindowController
    }
}

