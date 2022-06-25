//
//  ContentView.swift
//  Shared
//
//  Created by J Michael Dean on 6/25/22.
//

import SwiftUI
var macpuf = Simulator()

struct ContentView: View {
    var body: some View {
        Button("Simulate") {
            macpuf.simulate()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
