//
//  ContentView.swift
//  splitwise
//
//  Created by Miles Grant on 7/7/20.
//  Copyright © 2020 mlsgrnt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var splitwiseModel: SplitwiseModel;
    
    @ViewBuilder
    var body: some View {
        if splitwiseModel.loggedIn {
            LoggedInView(user: splitwiseModel.user, groups: splitwiseModel.groups)
        } else {
            VStack {
                Text("I am not logged in")
                Button(action: splitwiseModel.logIn) {
                    Text("Log In")
                }
            }.frame(minWidth: 800, minHeight: 400)
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
