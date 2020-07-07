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
    }
}

struct ExpensesTableView: View {
    let expenses: [Expense]
    @EnvironmentObject var splitwiseModel: SplitwiseModel

    
    var body: some View {
        VStack(alignment: .leading){
            Text("Expenses")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.leading, 15.0)
                .padding(.bottom, -5.0)
            
            if expenses.endIndex == 0 {
                Text("No expenses yet!")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(){
                    ForEach(filterToOnlyShowOwed(expenses: expenses/*, user: splitwiseModel.user*/)) { expense in
                            ExpenseRow(expense: expense)
                    }
                }
            }
        }
        
        
    }
}

struct ExpensesTableView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesTableView(expenses: [Expense(id: 1, date: Date(), cost: 12.0, repayment: Debt(from: User(id: 1, firstName: "s", lastName: "s", email: "s", defaultCurrency: "s"), to: User(id: 2, firstName: "s", lastName: "s", email: "s", defaultCurrency: "s"), amount: 12.3), description: "woooo", paid: true)])
    }
}
