//
//  SplitwiseNetworking.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import OAuthSwift
import SwiftyJSON
import Foundation

let dateFormatter = DateFormatter()

fileprivate let consumerKey = "5ZaHwFkT0nLiO49jbxLU6JtKfetJEWwnATBpPwtf" // go to https://secure.splitwise.com/oauth_clients to obtain a consumerKey or use provided binary
fileprivate let consumerSecret = "npiDLszUl2pLEpmcztWWhEz3n1aZVmuFnEx1ZxIy" // go to https://secure.splitwise.com/oauth_clients to obtain a consumerSecret or use provided binary

class SplitwiseNetworking {
    fileprivate let oauthswift = OAuth1Swift(
        consumerKey: consumerKey,
        consumerSecret: consumerSecret,
        requestTokenUrl: "https://secure.splitwise.com/oauth/request_token",
        authorizeUrl:    "https://secure.splitwise.com/oauth/authorize",
        accessTokenUrl:  "https://secure.splitwise.com/oauth/access_token")
    fileprivate var requestHandle: OAuthSwiftRequestHandle?
    fileprivate var client: OAuthSwiftClient?
    
    func previousAuthorizationAvailable() -> Bool {
        if let oauthToken = UserDefaults.standard.string(forKey: "oauthToken"),
            let oauthTokenSecret = UserDefaults.standard.string(forKey: "oauthTokenSecret"),
            let oauthTokenExpiresAtString = UserDefaults.standard.string(forKey: "oauthTokenExpiresAt") {
            if let oauthTokenExpiresAt = dateFormatter.date(from:oauthTokenExpiresAtString),
                Date() > oauthTokenExpiresAt {
                return false
            } else {
                self.client = OAuthSwiftClient(consumerKey: consumerKey, consumerSecret: consumerSecret, oauthToken: oauthToken, oauthTokenSecret: oauthTokenSecret, version: .oauth1)
                return true
            }
        }
        return false
    }
    
    func authorize(success: @escaping () -> Void, failure: @escaping (String) -> Void) {
        _ = oauthswift.authorize(
        withCallbackURL: "splitwise://oauth-callback") { result in
            switch result {
            case .success(let (credential, _, _)):
                UserDefaults.standard.set(credential.oauthToken, forKey: "oauthToken")
                UserDefaults.standard.set(credential.oauthTokenSecret, forKey: "oauthTokenSecret")
                UserDefaults.standard.set(credential.oauthTokenExpiresAt ?? "-", forKey: "oauthTokenExpiresAt")
                success()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func logOut(success: @escaping () -> Void?) {
        UserDefaults.standard.removeObject(forKey: "oauthToken")
        UserDefaults.standard.removeObject(forKey: "oauthTokenSecret")
        UserDefaults.standard.removeObject(forKey: "oauthTokenExpiresAt")
        success()
    }
    
    // MARK: Requests
    func httpGetCurrentUser(success: @escaping (User) -> Void, failure: @escaping (String) -> Void) {
        guard let client = self.client else {
            failure("Not authorized. Call authorize(...) before using")
            return
        }
        
        client.get("https://secure.splitwise.com/api/v3.0/get_current_user") { result in
            switch result {
            case .success(let response):
                let responseJSON = JSON(parseJSON: response.dataString() ?? "")
                let userJSON = responseJSON["user"]
                
                let id = userJSON["id"].intValue
                let firstName = userJSON["first_name"].stringValue
                let lastName = userJSON["last_name"].stringValue
                let email = userJSON["email"].stringValue
                let defaultCurrency = userJSON["default_currency"].stringValue
                
                let user = User(id: id, firstName: firstName, lastName: lastName, email: email, defaultCurrency: defaultCurrency)
                success(user)
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
    func httpGetGroupsWithMembers(success: @escaping ([Group]) -> Void, failure: @escaping (String) -> Void) {
        guard let client = self.client else {
            failure("Not authorized. Call authorize(...) before using")
            return
        }
        
        client.get("https://secure.splitwise.com/api/v3.0/get_groups") { result in
            switch result {
            case .success(let response):
                let responseJSON = JSON(parseJSON: response.dataString() ?? "")
                let groupsJSON = responseJSON["groups"].arrayValue
                var groups = [Group]()
                
                for groupJSON in groupsJSON {
                    let groupId = groupJSON["id"].intValue
                    let groupName = groupJSON["name"].stringValue
                    let groupMembersJSON = groupJSON["members"].arrayValue
                    
                    var currencies = [String]()
                    let originalDeptsJSON = groupJSON["original_debts"].arrayValue
                    for originalDeptJSON in originalDeptsJSON {
                        let currency = originalDeptJSON["currency_code"].stringValue
                        if (!currencies.contains { $0 == currency}) {
                            currencies.append(currency)
                        }
                    }
                    
                    var members = [User]()
                    for groupMemberJSON in groupMembersJSON {
                        let memberId = groupMemberJSON["id"].intValue
                        let memberFirstName = groupMemberJSON["first_name"].stringValue
                        let memberLastName = groupMemberJSON["last_name"].stringValue
                        let memberEmail = groupMemberJSON["email"].stringValue
                        let memberDefaultCurrency = groupMemberJSON["default_currency"].stringValue
                        
                        let member = User(id: memberId, firstName: memberFirstName, lastName: memberLastName, email: memberEmail, defaultCurrency: memberDefaultCurrency)
                        members.append(member)
                    }
                    
                    let group = Group(id: groupId, name: groupName, currencies: currencies, members: members)
                    groups.append(group)
                }
                success(groups)
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
