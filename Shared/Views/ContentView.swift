//
//  ContentView.swift
//  Shared
//
//  Created by J Michael Dean on 6/25/22.  Revised November 27, 2022.
//  Changed to new navigation stack.

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var simulator: Simulator
    var body: some View {
        
        NavigationStack{
           Form {
               NavigationLink(destination: ConsoleView()){
                   Text("Go to main simulation window")
               }
               
                NavigationLink(destination: VariableListView()){
                    Text("Change model parameters")
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
           }.font(.subheadline)
                .navigationTitle("MacPuf Simulation Setup") .buttonStyle(.bordered)
        }
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


