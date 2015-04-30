//
//  AppDelegate.swift
//  CarLot
//
//  Created by Ramon Gilabert Llop on 4/30/15.
//  Copyright (c) 2015 Ramon Gilabert. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController = Document()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let window = NSWindow(contentRect: NSMakeRect(100, 100, 200, 200), styleMask: NSTitledWindowMask|NSResizableWindowMask|NSMiniaturizableWindowMask|NSClosableWindowMask, backing: NSBackingStoreType.Buffered, defer: false)
        window.title = "New Window"
        window.opaque = false
        window.center()
        window.movableByWindowBackground = true
        window.makeKeyAndOrderFront(true)

        self.mainWindowController = Document(window: window)
    }
}

