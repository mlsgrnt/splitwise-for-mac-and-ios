//
//  GroupDetailView.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import SwiftUI

struct GroupDetailView: View {
    let group: Group?
    
    var body: some View {
            VStack {
                Text(group?.name ?? "Select a group")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Divider()
                Text("hmm")
            }
            .frame(minWidth: 500, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    }
}


struct GroupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetailView(group: Group(id: 1, name: "wow group", currencies: [], members: []))
    }
}
