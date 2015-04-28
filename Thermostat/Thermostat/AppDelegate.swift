//
//  AppDelegate.swift
//  Thermostat
//
//  Created by Ramon Gilabert Llop on 4/28/15.
//  Copyright (c) 2015 Ramon Gilabert. All rights reserved.
//

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

