//
//  ExpenseRow.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import SwiftUI


struct ExpenseRow: View {
    @EnvironmentObject var splitwiseModel: SplitwiseModel
    let expense: Expense
    
    var body: some View {
        HStack(alignment: .center) {
            Text(expense.description)
                .font(.subheadline)
            //Divider()
            Text(String(expense.cost.asMoney()))
                .font(.caption)
                .foregroundColor(Color.gray)
            Spacer()
            VStack(alignment: .trailing){
            Text(expense.asYou(user: splitwiseModel.user))
            Text(expense.repayment.amount.asMoney())
                .foregroundColor(expense.repayment.colorForUser(user: splitwiseModel.user))
            }
        }
        .padding(10.0)
        .frame(maxHeight: 75)
    }
}

struct ExpenseRow_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRow(expense: Expense(id: 1, date: Date(), cost: 12.0, repayment: Debt(from: User(id: 1, firstName: "s", lastName: "s", email: "s", defaultCurrency: "s"), to: User(id: 2, firstName: "s", lastName: "s", email: "s", defaultCurrency: "s"), amount: 12.3), description: "woooo", paid: false))
    }
}
