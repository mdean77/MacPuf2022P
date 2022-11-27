//
//  ContentView.swift
//  Shared
//
//  Created by J Michael Dean on 6/25/22.
//

import SwiftUI

struct ContentView: View {
    @State private var patientStarted = false
    @State private var selection: String? = nil
    @EnvironmentObject var simulator: Simulator
    
    var body: some View {
        
        NavigationView{
           Form {
                NavigationLink(destination: VariableListView()){
                    Text("Change parameters")
                }
                
               HStack{
                   Text("Inspect MacPuf")
                   Spacer()
                   Text("Artificial ventilation")
               }
               HStack{
                   Text("Douglas bag experiments")
                   Spacer()
                   Text("Preset patients")
               }
               HStack{
                   Text("Define your own patient")
                   Spacer()
                   Text("Display frequency")
               }
              Text("Length of each simulation run (seconds)")

               NavigationLink(destination: ConsoleView()){
                   Text("Simulate")
               }
               simButtons
           }.font(.subheadline)
                .navigationTitle("MacPuf Simulation") .buttonStyle(.bordered)
        }
    }

    
    var simButtons: some View {
        HStack{
            Button{
                simulator.startUp()
                patientStarted = true
            }
        label: {
            Text("Simulate new")
                .font(.headline)
        }
        .buttonStyle(.bordered)
        Spacer()
            Button{
                simulator.continueSubject()
            }
        label: {
            Text("Continue same")
                .font(.headline)
        }.buttonStyle(.bordered)
                .disabled(!patientStarted)
            
        }.padding(.horizontal)
        
    }
}



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group{
            ContentView()
                .previewInterfaceOrientation(.landscapeLeft)
            ContentView()
                .previewInterfaceOrientation(.landscapeRight)
                .preferredColorScheme(.dark)
        }.environmentObject(Simulator())

    }
}


