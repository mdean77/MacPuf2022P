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
            Button("FiO2 to 15%"){
                macpuf.changeParameterValue(key: "FIO2", value: 15)
                macpuf.continueSubject()
            }
            .disabled(!patientStarted)
            Button("FiCO2 to 5%"){
                macpuf.changeParameterValue(key: "FIC2", value: 5)
                macpuf.continueSubject()
            }
            .disabled(!patientStarted)
            Button("Cardiac function to 15%"){
                macpuf.changeParameterValue(key: "CO", value: 15)
                macpuf.continueSubject()
            }
            .disabled(!patientStarted)
            Button("Decompression to 400 mmHg."){
                macpuf.changeParameterValue(key: "BARPR", value: 400)
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
