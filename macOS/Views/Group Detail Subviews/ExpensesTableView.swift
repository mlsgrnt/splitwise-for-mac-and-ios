//
//  ExpensesTableView.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import SwiftUI

func filterToOnlyShowOwed(expenses: [Expense]/*, user: User?*/) -> [Expense] {
    // Tried to do some fancy things with figuring out which payments to show... not worth the hassle
    //guard let user = user else {
    //    return expenses
    //}
    
    return expenses.filter { (expense) -> Bool in
        return !expense.paid
    }.sorted { (l, r) -> Bool in
        l.date > r.date
    }
}

struct ExpensesTableView: View {
    let expenses: [Expense]?
    let debt: Double
    let group: Group?
    
    @State var settleUpViewVisible = false
    @State var addExpenseVisible = false
    @EnvironmentObject var splitwiseModel: SplitwiseModel
    
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .center) {
                Text("Expenses")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                if debt < 0 {
                    Button(action:{
                        self.settleUpViewVisible = true
                    }) {
                        Text("Settle Up")
                    }
                }
                Button(action: {
                    self.addExpenseVisible = true
                }) {
                    Text("+")
                }
            }
            .padding(.leading, 15.0)
            .padding(.trailing, 15.0)
            .padding(.bottom, -5.0)
            
            if expenses == nil {
                Text("Loading")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                if expenses!.endIndex == 0 {
                    Text("No expenses yet!")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(){
                        ForEach(filterToOnlyShowOwed(expenses: expenses!/*, user: splitwiseModel.user*/)) { expense in
                            ExpenseRow(expense: expense)
                        }
                    }
                }
            }
            
        }
            // Hacks for multipel sheets
            .background(EmptyView().sheet(isPresented: $settleUpViewVisible) {
                SettleUpView(group: self.group, isVisible: self.$settleUpViewVisible, amountSent: self.debt).environmentObject(self.splitwiseModel)
            })
            .background(EmptyView().sheet(isPresented: $addExpenseVisible) {
                AddExpenseView(group: self.group!, isVisible: self.$addExpenseVisible).environmentObject(self.splitwiseModel)
            })
        
        
    }
}
