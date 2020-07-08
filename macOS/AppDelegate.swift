//
//  AppDelegate.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import Cocoa
import SwiftUI
import OAuthSwift

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow!
    // Store our model here so all windows can access it
    let splitwiseModel = SplitwiseModel()

    // Used by swift-oauth
    @objc func handleGetURL(event: NSAppleEventDescriptor!, withReplyEvent: NSAppleEventDescriptor!) {
        if let urlString = event.paramDescriptor(forKeyword: AEKeyword(keyDirectObject))?.stringValue, let url = URL(string: urlString) {
            OAuthSwift.handle(url: url)
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Used by swift-oauth
        NSAppleEventManager.shared().setEventHandler(self, andSelector:#selector(AppDelegate.handleGetURL(event:withReplyEvent:)), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
        
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView().environmentObject(splitwiseModel)
        
        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        
        window.titlebarAppearsTransparent = true // Big Sur style
        window.title = "Split Wisely"
        
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    // MARK: Preferences pane
    
    var prefView: PrefView?
    @IBAction func openPrefWindow(_ sender: Any) {
        // Either open the existing window or create it
        if let prefsView = prefView, prefsView.prefsWindowDelegate.windowIsOpen {
            prefsView.window.makeKeyAndOrderFront(self)
        } else {
            prefView = PrefView(splitwiseModel: splitwiseModel)
        }
    }
    
    // MARK: Open web app
    
    // In future, would be cool to open up right to the active group!
    // TODO
    @IBAction func openWebApp(_ sender: Any) {
        let url = URL(string: "https://secure.splitwise.com")!
        _ = NSWorkspace.shared.open(url)
    }
}

