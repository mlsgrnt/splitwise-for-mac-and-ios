//
//  Group.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

struct Group: Identifiable, Hashable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let currencies: [String]
    let members: [User]
    let debts: [Debt]
    
    func getBalanceForUser(_ user: User?) -> Double {
        guard let user = user else {
            return 0.0
        }
        var balance = 0.0
        for debt in self.debts {
            if debt.to == user {
                balance += debt.amount
            }
            if debt.from == user {
                balance -= debt.amount
            }
        }
        
        return balance.roundedWithTwoDecimalPlaces()
    }
}
