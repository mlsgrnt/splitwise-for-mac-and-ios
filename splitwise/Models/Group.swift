//
//  Group.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//
import SwiftUI

class Group: Identifiable, Hashable, ObservableObject {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    init(id: Int, name: String, currencies: [String], members: [User], debts: [Debt]) {
        self.id = id
        self.name = name
        self.currencies = currencies
        self.members = members
        self.debts = debts
    }
    
    @Published var id: Int
    @Published var name: String
    @Published var currencies: [String]
    @Published var members: [User]
    @Published var debts: [Debt]
    
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
