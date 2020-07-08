//
//  LoggedInView.swift
//  Splitwise for Mac
//
//  Created by Miles Grant on 7/8/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import SwiftUI

struct LoggedInView: View {
    @EnvironmentObject var splitwiseModel: SplitwiseModel
        
    var body: some View {
        NavigationView {
            List {
                Section(header: Text(splitwiseModel.user?.name ?? "")){
                     ForEach(splitwiseModel.groups ?? []) { group in
                        NavigationLink(destination: GroupDetailView(group: group).navigationBarTitle(Text(group.name))) {
                             Text(group.name)
                        }
                     }
                }
            }.listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Your Groups"))
            .navigationBarItems(trailing:
                Button(action: {
                    self.splitwiseModel.logOut()
                }, label: {
                    Text("Logout")
                })
            )
        }
    }
}
