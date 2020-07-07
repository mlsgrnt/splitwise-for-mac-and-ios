//
//  PrefView.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import SwiftUI

struct PrefView: View {
    @ObservedObject var splitwiseModel: SplitwiseModel;
    // Used to know if the window is open
    @State var prefsWindowDelegate = PrefsWindowDelegate()

    @ViewBuilder
    var body: some View {
        if splitwiseModel.loggedIn {
            VStack {
                Button(action: splitwiseModel.logOut) {
                    Text("Log Out")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        } else {
            VStack {
                Text("I am not logged in")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
    }
    // Open window when view opened
    var window: NSWindow!
    init(splitwiseModel: SplitwiseModel) {
        self.splitwiseModel = splitwiseModel
        
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered, defer: false)
        window.title = "Preferences"
        window.contentView = NSHostingView(rootView: self)
        window.makeKeyAndOrderFront(nil)
    }
    
    // Keep track if window is open
    class PrefsWindowDelegate: NSObject, NSWindowDelegate {
        var windowIsOpen = true

        func windowWillClose(_ notification: Notification) {
            windowIsOpen = false
        }
    }
}
