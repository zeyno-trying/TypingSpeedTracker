//
//  Home.swift
//  TypingSpeedTracker
//
//  Created by Djebbari on 25/8/2025.
//

import SwiftUI

struct TestLogic: View {
    @State private var username: String = ""
    var body: some View {
        Text("Type in here naturally and let me count ur SPEED")
        TextField(
               "Make it quick",
               text: $username
           )
        .padding()
    }
}

#Preview {
    TestLogic()
}
