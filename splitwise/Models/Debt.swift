//
//  Debt.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//
import SwiftUI

struct Debt: Identifiable, Hashable {
    var id = UUID()
    
    let from: User
    let to: User
    let amount: Double
    
    var friendly: String { return "\(from.firstName) owes \(to.firstName)"}
    func colorForUser(user: User?) -> Color {
        guard let user = user else {
            return Color.gray
        }
        if user == to {
            return Color.green
        }
        if user == from {
            return Color.red
        }
        return Color.gray
    }
}
