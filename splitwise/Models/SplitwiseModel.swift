//
//  SplitwiseModel.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import Foundation

class SplitwiseModel: ObservableObject {
    fileprivate let splitwiseNetworking: SplitwiseNetworking
    @Published var user: User?
    @Published var groups: [Group]?
    @Published var expenses = [Int: [Expense]]() // Not the perfect way to do it, but works.
    
    @Published var loggedIn: Bool! {
        didSet {
            // After logging in, let's make all of our inital requests to grab the data we need
            if self.loggedIn == true {
                _ = splitwiseNetworking.previousAuthorizationAvailable()
                self.loadUser()
                self.loadGroups()
            }
        }
    }
    
    init() {
        splitwiseNetworking = SplitwiseNetworking();
        // Are we logged in?
        setLoggedIn(splitwiseNetworking.previousAuthorizationAvailable())
    }
    
    // Used so we can set logged in value from init
    func setLoggedIn(_ newValue: Bool) {
        self.loggedIn = newValue
    }
    
    // MARK: Login
    func logIn() {
        splitwiseNetworking.authorize(success: {
            self.loggedIn = true;
        }) { (err: String) in
            print(err)
        }
    }
    
    // The class needs to be re-initialized to login again. Easy fix: kill the app.
    func logOut() {
        splitwiseNetworking.logOut {
            self.loggedIn = false;
            exit(1)
        }
    }
    
    // MARK: load things
    // TODO: This should be some kind of helper?
    func loadUser() {
        splitwiseNetworking.httpGetCurrentUser(success: { (user: User) in
            self.user = user
        }) { (error: String) in
            print(error)
        }
    }
    
    func loadGroups() {
        splitwiseNetworking.httpGetGroupsWithMembers(success: { (groups: [Group]) in
            self.groups = groups
        }) { (err: String) in
            print(err)
        }
    }
    
    func loadExpenses(group: Group) {
        // Doing some messy array stuff here. Not sure how Swift works well enough to do this well...
        // Originally I wanted expenses to be inside of Group... :(
        
        // See if we've seen it before
        if self.expenses[group.id] != nil {
            // We already grabbed these expenses, so do nothing.
            print("We already grabbed expenses for \(group.name)")
            return
        }
        
        // After all this finally we can grab
        splitwiseNetworking.HttpGetExpenses(group: group, success: { (expenses: [Expense]) in
            self.expenses[group.id] = expenses
        }) { (errr: String) in
            print(errr)
        }
    }
    
}
