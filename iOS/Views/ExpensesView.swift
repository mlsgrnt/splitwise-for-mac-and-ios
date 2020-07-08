//
//  ExpensesView.swift
//  Splitwise for Mac
//
//  Created by Miles Grant on 7/8/20.
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

struct ExpensesView: View {
    let expenses: [Expense]?
    let group: Group?
    
    var body: some View {
        List(){
            if expenses == nil {
                Text("Loading")
            } else {
                if expenses!.endIndex == 0 {
                    Text("No expenses yet!")
                } else {
                    
                    ForEach(filterToOnlyShowOwed(expenses: expenses!/*, user: splitwiseModel.user*/)) { expense in
                        ExpenseRow(expense: expense)
                    }
                }
            }
        }.listStyle(PlainListStyle())
            
    }
}
