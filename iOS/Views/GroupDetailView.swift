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
                VStack(alignment: .trailing) {
                    DebtView(debts: group.debts, myUserId: splitwiseModel.user!.id)
                    if(group.getBalanceForUser(splitwiseModel.user) < 0) {
                        Button(action: {
                            self.settleUpViewVisible = true
                        }) {
                            Text("Settle Up")
                        }.padding(.top)
                    }
                }.padding()
                
            }
            ExpensesView(expenses: splitwiseModel.expenses[group.id], group: group)
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
            .background(EmptyView().sheet(isPresented: $settleUpViewVisible) {
                SettleUpView(group: self.group, isVisible: self.$settleUpViewVisible, amountSent: self.group.getBalanceForUser(self.splitwiseModel.user)).environmentObject(self.splitwiseModel)
            })
    }
}
