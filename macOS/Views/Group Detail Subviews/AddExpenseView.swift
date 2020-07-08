//
//  AddExpenseView.swift
//  splitwise
//
//  Created by Miles Grant on 7/8/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import SwiftUI
import Combine


struct AddExpenseView: View {
    @EnvironmentObject var splitwiseModel: SplitwiseModel
    let group: Group
    
    @Binding var isVisible: Bool
    @State var description: String = ""
    @State var amount: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text("Add Expense")
            .font(.headline)
                .padding([.bottom])
            GroupBox(label: Text("Details")) {
                VStack{
                    TextField("Description", text: $description)
                    HStack {
                        Text("$") // TODO!
                            .font(.caption)
                        TextField("Amount", text: $amount)
                    }
                }.padding()
            }
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.isVisible = false
                }) {
                    Text("Cancel")
                }
                Button(action: {
                    // Check if amount is a double
                    guard let amount = self.amount.doubleValue else {
                        NSSound.beep()
                        return
                    }
                    self.splitwiseModel.addExpense(amount: amount, description: self.description, group: self.group)
                    
                    self.isVisible = false
                }) {
                    Text("Add")
                }.focusable()
            }
        }
        .frame(width: 300, height: 175)
        .padding()
        
    }
}
