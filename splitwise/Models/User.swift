//
//  User.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//
// Thank you https://github.com/janwasgint/Cupwise for some of this

struct User: Identifiable, Hashable {
    let id: Int
    let firstName: String
    let lastName: String
    var name: String { return "\(firstName) \(lastName)"}
    let email: String
    let defaultCurrency: String
}
