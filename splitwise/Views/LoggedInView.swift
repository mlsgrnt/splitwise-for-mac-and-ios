//
//  UserView.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import SwiftUI

struct LoggedInView: View {
    let user: User?
    let groups: [Group]?
    
    @State private var selectedGroup: Group?
    
    var body: some View {
        NavigationView {
            GroupListView(groups: groups ?? [], selectedGroup: $selectedGroup)
            Text("Choose one").frame(minWidth: 500, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        // Cool big sur style
        .edgesIgnoringSafeArea(.all)
    }
}
