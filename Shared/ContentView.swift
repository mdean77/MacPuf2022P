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
                    ForEach(1..<4){i in
                        HStack{
                            VStack(alignment: .leading){
                                Text(simulator.factors[i]!.title)
                                    .font(.title2)
                                Text("Reference value: \(simulator.factors[i]!.reference)")
                                    .font(.caption)
                            }
                            Spacer()
                            Text("Current Value: \(simulator.factors[i]!.current)")
                                .font(.title2)
                        }
                    }
                    
                }
                    
                    //                            Text("Inspired CO2 (%)")
                    //                            Text("Cardiac pump performance, % normal")
                    //                            Text("Metabolic rate, % normal")
                    //                            Text("Extra R-->L shunt, % cardiac output")
                    //                            Text("Extra dead space above normal, ml")
                    
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
