//
//  ContentView.swift
//  Shared
//
//  Created by J Michael Dean on 6/25/22.
//

import SwiftUI
//var simulator = Simulator()


struct ContentView: View {
    @State private var patientStarted = false
    @ObservedObject var simulator: Simulator

    var body: some View {

        VStack{
            NavigationView{
                List{
                    Section(header: Text("Frequent parameter changes")){
                        
                            ForEach(1..<7){i in
                                NavigationLink(destination: Text(simulator.factors[i]!.title)){
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(simulator.factors[i]!.title)
                                            .font(.subheadline)
                                        Text("Reference value: \(simulator.factors[i]!.reference,specifier:simulator.factors[1]!.format)")
                                            .font(.caption)
                                    }
                                    Spacer()
                                    Text("Current Value: \(simulator.factors[i]!.current,specifier: simulator.factors[i]!.format)")
                                        .font(.caption)
                                }
                            }
                        }
                      
                    }
                    Section(header: Text("Other parameter changes")){
                        ForEach(7..<31){i in
                            NavigationLink(destination: Text(simulator.factors[i]!.title)){
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(simulator.factors[i]!.title)
                                            .font(.subheadline)
                                        Text("Reference value: \(simulator.factors[i]!.reference,specifier:simulator.factors[1]!.format)")
                                            .font(.caption)
                                    }
                                    Spacer()
                                   
                                        Text("Current Value: \(simulator.factors[i]!.current,specifier: simulator.factors[i]!.format)")
                                            .font(.caption)
                                    }
                            }
                          
                                
                            
                        }
                    }

                    
                }.navigationTitle("MacPuf Variables")
                    .font(.title)
                    
                }
                

            
            
            Spacer()
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
    }
    
}
        



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {

        let simulator = Simulator()
        Group{
            ContentView(simulator: simulator)
                .previewInterfaceOrientation(.landscapeLeft)
            ContentView(simulator: simulator)
                .previewInterfaceOrientation(.landscapeRight)
                .preferredColorScheme(.dark)
        }

    }
}

//VStack(spacing:10){
//    Button("Simulate new") {
//        simulator.startUp()
//        patientStarted = true
//    }
//    Button("Continue same") {
//        simulator.continueSubject()
//    }
//    .disabled(!patientStarted)
//    Button("FiO2 to 15%"){
//        simulator.changeParameterValue(key: "FIO2", value: 15)
//        //simulator.continueSubject()
//    }
//    .disabled(!patientStarted)
//    Button("FiCO2 to 5%"){
//        simulator.changeParameterValue(key: "FIC2", value: 5)
//        //simulator.continueSubject()
//    }
//    .disabled(!patientStarted)
//    Button("Cardiac function to 15%"){
//        simulator.changeParameterValue(key: "CO", value: 15)
//        //simulator.continueSubject()
//    }
//    .disabled(!patientStarted)
//    Button("Decompression to 400 mmHg."){
//        simulator.changeParameterValue(key: "BARPR", value: 400)
//        //simulator.continueSubject()
//    }
//    .disabled(!patientStarted)
//}
