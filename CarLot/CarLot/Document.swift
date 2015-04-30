//
//  Document.swift
//  CarLot
//
//  Created by Ramon Gilabert Llop on 4/30/15.
//  Copyright (c) 2015 Ramon Gilabert. All rights reserved.
//

import Cocoa

class Document: NSPersistentDocument {

    override class func autosavesInPlace() -> Bool {
        return true
    }
}
