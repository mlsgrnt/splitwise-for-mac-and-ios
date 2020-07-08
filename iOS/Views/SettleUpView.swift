//
//  SettleUpView.swift
//  Splitwise for Mac
//
//  Created by Miles Grant on 7/8/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import SwiftUI

struct SettleUpView: View {
    let group: Group?
    @Binding var isVisible: Bool
    @State var amountSent: Double
    @EnvironmentObject var splitwiseModel: SplitwiseModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                
                VStack(alignment: .leading, spacing: 10.0){
                    Text("First Things First")
                        .font(.title)
                    Button(action: {
                        let url = URL(string: "http://bankofscotland.co.uk")!
                        UIApplication.shared.open(url)
                    }) {
                        Text("Visit Bank of Scotland Website")
                    }
                    .padding(.bottom, 25)
                    
                    Text("How Much Was Sent?")
                        .font(.title)
                    Stepper(amountSent.asMoney(), onIncrement: {
                        self.amountSent -= 0.01
                    }, onDecrement: {
                        self.amountSent += 0.01
                    })
                }
                Spacer()
                Spacer()
                Button(action: {
                    self.splitwiseModel.settleUp(amount: self.amountSent, group: self.group!)
                    // Hide modal
                    self.isVisible = false
                }) {
                    Text("Confirm")
                        .padding([.leading, .trailing], 100.0)
                        .font(.headline)
                    
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                .padding(.bottom, 25)
                
            }
            .padding()
            .navigationBarTitle(Text("Add Shared Expense"))
            .navigationBarItems(leading:
                Button(action: {
                    self.isVisible = false
                }) {
                    Text("Cancel")
                }
            )
        }
        
    }
    
    
    /*
     var body: some View {
     VStack(alignment: .leading) {
     Text("First Things First")
     .font(.headline)
     Button(action: {
     let url = URL(string: "http://bankofscotland.co.uk")!
     UIApplication.shared.open(url)
     }) {
     Text("Visit Bank of Scotland Website")
     }
     
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
     
     }*/
}
