//
//  GroupDetailView.swift
//  Splitwise for Mac
//
//  Created by Miles Grant on 7/8/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import SwiftUI

struct GroupDetailView: View {
    @EnvironmentObject var splitwiseModel: SplitwiseModel
    @ObservedObject var group: Group
    
    @State var settleUpViewVisible = false
    @State var addExpenseVisible = false
    
    var body: some View {
        VStack(alignment: .trailing) {
            if splitwiseModel.user != nil {
                DebtView(debts: group.debts, myUserId: splitwiseModel.user!.id).padding()
            }
            ExpensesView(expenses: splitwiseModel.expenses[group.id], debt: group.getBalanceForUser(splitwiseModel.user), group: group)
            Spacer()
        }
            
        .onAppear() {
            self.splitwiseModel.loadExpenses(group: self.group)
        }
        .navigationBarItems(trailing:
            Button(action: {
                self.addExpenseVisible = true
            }) {
                Image(systemName: "plus.circle.fill").imageScale(.large)
            }
        )
            .background(EmptyView().sheet(isPresented: $addExpenseVisible) {
            AddExpenseView(group: self.group, isVisible: self.$addExpenseVisible).environmentObject(self.splitwiseModel)
        })
    }
}
