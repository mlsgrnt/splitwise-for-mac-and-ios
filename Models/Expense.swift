//
//  Expense.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//
import Foundation

struct Expense: Identifiable, Hashable {
    let id: Int
    
    let date: Date
    let cost: Double
    let repayment: Debt // Really should be an array if multiple people. TODO bad assumption
    let description: String
    let paid: Bool
    
    func asYou(user: User?) -> String {
        guard let user = user else {
            return repayment.friendly
        }
        
        if repayment.to == user {
            return "\(repayment.from.firstName) owes you"
        }
        if repayment.from == user {
            return "You owe \(repayment.to.firstName)"
        }
        return repayment.friendly
    }
}
