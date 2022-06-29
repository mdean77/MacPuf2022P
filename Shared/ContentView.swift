//
//  ContentView.swift
//  Shared
//
//  Created by J Michael Dean on 6/25/22.
//

import SwiftUI
var macpuf = Simulator()


struct ContentView: View {
    @State private var patientStarted = false
    
    var body: some View {
        VStack(spacing:10){
            Button("Simulate new") {
                macpuf.startUp()
                patientStarted = true
            }
            Button("Continue same") {
                macpuf.continueSubject()
            }
            .disabled(!patientStarted)
        }
   
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
