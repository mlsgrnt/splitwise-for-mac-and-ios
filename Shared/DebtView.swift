//
//  DebtView.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import SwiftUI

// This file could use some rewriting. Part of the problem is the bad 2-user assumtion.

fileprivate func getBalance(debts: [Debt], myUserId: Int) -> Double {
    var balance = 0.0
    for debt in debts {
        if debt.to.id == myUserId {
            balance += debt.amount
        }
        if debt.from.id == myUserId {
            balance -= debt.amount
        }
    }
    
    return balance.roundedWithTwoDecimalPlaces()
}


// For now, a nasty hack:
// Assume that the group only has 2 people in it
fileprivate func getOtherPerson(debts: [Debt], myUserId: Int)->User? {
    // Because this is a horrible hack, we do some horrible things
    if debts.endIndex == 0 {
        return nil
    }
    return debts[0].to.id == myUserId ? debts[0].from : debts[0].to
}

struct DebtView: View {
    var debts: [Debt]?
    let myUserId: Int
    
    @ViewBuilder
    var body: some View {
        // SwiftUI is annoying in that variables can't be set at runtime...
        // So there's this instead............
        // TODO: move some of these string constructors to the double extension?
        if getBalance(debts: debts!, myUserId: myUserId) != 0 {
            VStack(alignment: .trailing) {
                HStack(alignment: .bottom) {
                    Text(getBalance(debts: debts!, myUserId: myUserId) > 0 ? "You are owed" : "You owe")
                    Text(getBalance(debts: debts!, myUserId: myUserId).asMoney())
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                HStack(alignment: .bottom) {
                    Text(getBalance(debts: debts!, myUserId: myUserId) > 0 ? "by":"to")
                        .padding([.trailing],-5.0) // Make it more squished
                    Text(getOtherPerson(debts: debts!, myUserId: myUserId)?.name ?? "")
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal, 10.0)
            .padding(.vertical, 5.0)
            .background(getBalance(debts: debts!, myUserId: myUserId) > 0 ? Color.green:Color.red)
            .cornerRadius(5.0)
            .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.9))
            
        } else {
            Text("Perfectly balanced")
                .font(.headline)
                .padding(.horizontal, 10.0)
                .padding(.vertical, 10.0)
                .background(Color(red: 0.3, green: 0.3, blue: 0.3, opacity: 0.5))
                .cornerRadius(5.0)
                .foregroundColor(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.9))
        }
    }
    
}
