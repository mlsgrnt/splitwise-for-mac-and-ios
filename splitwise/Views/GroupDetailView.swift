//
//  GroupDetailView.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import SwiftUI

struct GroupDetailView: View {
    @EnvironmentObject var splitwiseModel: SplitwiseModel
    let group: Group
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text(group.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    if group.members.endIndex > 0 {
                        HStack {
                            Text("Members:")
                                .fontWeight(.medium)
                            ForEach(group.members) { member in
                                Text(member.name)
                            }
                            Spacer()
                        }
                        .padding([.top], 10.0)
                    }
                    
                }
                VStack{
                    if splitwiseModel.user != nil {
                        DebtView(debts: group.debts, myUserId: splitwiseModel.user!.id)
                    }
                }
                
            }.padding([.top, .leading, .trailing], 15.0)
            
            
            Divider()
                ExpensesTableView(expenses: splitwiseModel.expenses[group.id], debt: group.getBalanceForUser(splitwiseModel.user), group: group)
            
            Spacer()
            
        }
        .frame(minWidth: 500, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        .onAppear() {
            self.splitwiseModel.loadExpenses(group: self.group)
        }
    }
}
