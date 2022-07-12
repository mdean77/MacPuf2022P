//
//  ContentView.swift
//  Shared
//
//  Created by J Michael Dean on 6/25/22.
//

import SwiftUI

struct ContentView: View {
    @State private var patientStarted = false
    @EnvironmentObject var simulator: Simulator
    
    var body: some View {
        
        NavigationView{
            //changeVariables
           // ScrollView{
           Form {
                NavigationLink(destination: VariableListView()){
                    Text("Change parameters")
                        
                }//.navigationTitle("MacPuf Parameters")
                
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


           // Spacer()
            simButtons
           }.font(.subheadline)
                .navigationTitle("MacPuf Simulation")
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
                .font(.headline).foregroundColor(.gray)
        }
        .buttonStyle(.bordered)
            Spacer()
            Button{
                simulator.continueSubject()
            }
        label: {
            Text("Continue same")
                .font(.headline).foregroundColor(.gray)
        }.buttonStyle(.bordered)
                .disabled(!patientStarted)
            
        }.padding(.horizontal)
        
    }
    
//    var changeVariables: some View {
//        NavigationView{
//            List{
//                Section(header: Text("Frequent parameter changes")){
//                    ForEach(1..<7){i in
//                        NavigationLink(destination: VariableChangeView(index: i)){
//                            HStack{
//                                VStack(alignment: .leading){
//                                    Text(simulator.factors[i]!.title)
//                                        .font(.subheadline)
//                                    Text("Reference value: \(simulator.factors[i]!.reference,specifier:simulator.factors[1]!.format)")
//                                        .font(.caption)
//                                }
//                                Spacer()
//                                Text("Current Value: \(simulator.factors[i]!.current,specifier: simulator.factors[i]!.format)")
//                                    .font(.caption)
//                            }
//                        }
//                    }
//                }
//                Section(header: Text("Other parameter changes")){
//                    ForEach(7..<31){i in
//                        NavigationLink(destination: VariableChangeView(index: i)){
//                            HStack{
//                                VStack(alignment: .leading){
//                                    Text(simulator.factors[i]!.title)
//                                        .font(.subheadline)
//                                    Text("Reference value: \(simulator.factors[i]!.reference,specifier:simulator.factors[1]!.format)")
//                                        .font(.caption)
//                                }
//                                Spacer()
//                                Text("Current Value: \(simulator.factors[i]!.current,specifier: simulator.factors[i]!.format)")
//                                    .font(.caption)
//                            }
//                        }
//                    }
//                }
//            }.navigationTitle("MacPuf Variables")
//                .font(.title)
//        }
//    }
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


