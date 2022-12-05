//
//  ContentView.swift
//  Shared
//
//  Created by J Michael Dean on 6/25/22.  Revised November 27, 2022.
//  Changed to new navigation stack.

import SwiftUI

struct ContentView: View {
    let simIterations = [30, 60, 180, 720, 1800]
    let intervals = [1, 6, 10, 30, 60, 100]
    @EnvironmentObject var simulator: Simulator
    var body: some View {
        
        NavigationStack{
            Form{
                Section{
                    Picker("Seconds per simulation run:",
                           selection: $simulator.iterations){
                        ForEach(simIterations, id: \.self){
                            Text("\($0)")
                        }
                    }
                    Picker("Iterations per output:",
                           selection: $simulator.intervalFactor){
                        ForEach(intervals, id: \.self){
                            Text("\($0)")
                        }
                    }
                    Picker("Type of output:",
                           selection: $simulator.outputFormat){
                        ForEach(Simulator.OutputFormats.allCases, id: \.self){
                            Text($0.rawValue).tag($0)
                        }
                    }
                }
                Section{
                    NavigationLink(destination: VariableListView(), label: {
                        Text("Change simulation parameters")
                    })
   
                    NavigationLink(destination: ConsoleView(), label: {
                        Text("Go to simulation window")
                    })
                }
            }
            
        }
//        Form{
//            Section{
//                Picker("How many seconds per simulation run?",
//                       selection:$simulator.iterations){
//                    ForEach(simulator.simIterations, id: \.self){
//                        Text($0)
//                    }
//                }
//            }
//
//               NavigationLink(destination: ConsoleView()){
//                   Text("Go to main simulation window")
//               }
//
//                NavigationLink(destination: VariableListView()){
//                    Text("Change model parameters")
//                }
//
//               HStack{
//                   Text("Inspect MacPuf")
//                   Spacer()
//                   Text("Artificial ventilation")
//               }
//               HStack{
//                   Text("Douglas bag experiments")
//                   Spacer()
//                   Text("Preset patients")
//               }
//               HStack{
//                   Text("Define your own patient")
//                   Spacer()
//                   Text("Display frequency")
//               }
//              Text("Length of each simulation run (seconds)")
//           }.font(.subheadline)
//                .navigationTitle("MacPuf Simulation Setup") .buttonStyle(.bordered)
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


