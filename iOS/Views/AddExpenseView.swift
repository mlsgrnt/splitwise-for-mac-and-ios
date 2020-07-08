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
        NavigationView {
            List{
                VStack(alignment: .leading) {
                    TextField("Description", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 10.0)
                    HStack {
                        Text("$") // TODO!
                        TextField("Amount", text: $amount).keyboardType(.decimalPad)
                    }
                    .foregroundColor(Color.green)
                    Spacer()
                }
                .padding(.all, 5)
                .font(Font.system(size: 30, design: .default))
                    
                .padding()
            }.listStyle(GroupedListStyle())
                .navigationBarTitle(Text("Add Shared Expense"))
                .navigationBarItems(leading:
                    Button(action: {
                        self.isVisible = false
                    }) {
                        Text("Cancel")
                    },
                                    trailing: Button(action: {
                                        // Check if amount is a double
                                        guard let amount = self.amount.doubleValue else {
                                            return
                                        }
                                        self.splitwiseModel.addExpense(amount: amount, description: self.description, group: self.group)
                                        
                                        self.isVisible = false
                                    }
                                    ) {
                                        Text("Add").fontWeight(.bold)
                    }
            )
        }
        
    }
}
