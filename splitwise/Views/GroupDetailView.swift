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
    let group: Group?
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text(group?.name ?? "Select a group")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    if group?.members != nil && group!.members.endIndex > 0 {
                        HStack {
                            Text("Members:")
                                .fontWeight(.medium)
                            ForEach(group?.members ?? []) { member in
                                Text(member.name)
                            }
                            Spacer()
                        }
                        .padding([.top], 10.0)
                    }
                    
                }
                VStack{
                    if splitwiseModel.user != nil && group != nil {
                        DebtView(debts: group!.debts, myUserId: splitwiseModel.user!.id)
                    }
                }
                
            }.padding([.top, .leading, .trailing], 15.0)
            
            
            Divider()
            if group != nil && (splitwiseModel.expenses[group!.id] != nil) {
                ExpensesTableView(expenses: splitwiseModel.expenses[group!.id]!)
            }
            
            Spacer()
            
        }
        .frame(minWidth: 500, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        .onAppear() {
            if let group = self.group {
                self.splitwiseModel.loadExpenses(group: group)
            }
        }
    }
}


struct GroupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetailView(group: Group(id: 1, name: "wow group", currencies: [], members: [User(id: 1, firstName: "wow", lastName: "ooo", email: " ", defaultCurrency: "asdf")], debts: []))
    }
}
