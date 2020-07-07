//
//  Debt.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//
import Foundation

struct Debt: Identifiable, Hashable {
    var id = UUID()
    
    let from: User
    let to: User
    let amount: Double
}
