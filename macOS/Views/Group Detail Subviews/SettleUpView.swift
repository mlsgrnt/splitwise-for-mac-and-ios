//
//  TestView.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import SwiftUI
import Combine

struct SettleUpView: View {
    let group: Group?
    @Binding var isVisible: Bool
    @State var amountSent: Double
    @EnvironmentObject var splitwiseModel: SplitwiseModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("First Things First")
                .font(.headline)
            Button(action: {
                let url = URL(string: "http://bankofscotland.co.uk")!
                _ = NSWorkspace.shared.open(url)
            }) {
                Text("Visit Bank of Scotland Website")
            }
            .buttonStyle(LinkButtonStyle())
            
            Spacer()
            
            Text("How Much Was Sent?")
                .font(.headline)
            Stepper(amountSent.asMoney(), onIncrement: {
                self.amountSent -= 0.01
            }, onDecrement: {
                self.amountSent += 0.01
            })
            
            Spacer()
            Divider()
            HStack {
                Spacer()
                Button("Cancel") {
                    self.isVisible = false
                }
                
                Button(action: {
                    self.splitwiseModel.settleUp(amount: self.amountSent, group: self.group!)
                    // Hide modal
                    self.isVisible = false
                }) {
                    Text("OK").padding([.trailing, .leading], 12.5)
                }
            }
        }
        .frame(width: 300, height: 200)
        .padding()
        
    }
}
