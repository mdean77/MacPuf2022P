//
//  ConsoleView.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 11/27/22.
//  This is where I will put the main simulation console output.
//

import SwiftUI

struct ConsoleView: View {
    @EnvironmentObject var simulator: Simulator
    var body: some View {
        TextEditor(text: $simulator.consoleContentString)
            .monospaced()
            .font(.system(size:12))
        simButtons
    }
    
    
    var simButtons: some View {
        HStack{
            Button{
                simulator.startUp()
            } label: {
                Text("Simulate new")
                    .font(.headline)
            }
            .buttonStyle(.bordered)
            
            //Spacer()
            
            Group{
                Button{
                    simulator.continueSubject()
                } label: {
                    Text("Continue same")
                        .font(.headline)
                }
                .disabled(!simulator.alive)
                
                Button{
                    simulator.inspectSubject()
                } label: {
                    Text("Inspect")
                        .font(.headline)
                }
                
                Button{
                    simulator.dumpParameters()
                } label: {
                    Text("Dump Parameters")
                        .font(.headline)
                }
            }.buttonStyle(.bordered)
                .disabled(!simulator.patientStarted)
            
        }.padding(.horizontal)
        
    }
}




struct ConsoleView_Previews: PreviewProvider {

    static var previews: some View {
        Group{
            ConsoleView()
                .previewInterfaceOrientation(.landscapeLeft)
            ConsoleView()
                .previewInterfaceOrientation(.landscapeRight)
                .preferredColorScheme(.dark)
        }.environmentObject(Simulator())

    }
}
