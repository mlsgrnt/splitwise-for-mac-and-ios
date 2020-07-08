//
//  GroupListView.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import SwiftUI

struct GroupListView: View {
    @EnvironmentObject var splitwiseModel: SplitwiseModel
    @Binding var selectedGroup: Group?
    
    var body: some View {
        VStack {
            Spacer()
            List(selection: $selectedGroup) {
                Section(header: Text("Your Groups")) {
                    ForEach(splitwiseModel.groups ?? []) { group in
                        NavigationLink(destination: GroupDetailView(group: group)) {
                            Text(group.name)
                        }
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 200, maxWidth: .infinity, maxHeight: .infinity)
        }
        
    }
}

