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
                ScrollView{
                    Text(simulator.consoleContentString)
                        .monospaced()
                        .font(.system(size:12))
                }
        
        simButtons
    }
    
   
        
    var simButtons: some View {
        HStack{
            Button{
                simulator.startUp()
            } label: {
                Text("Simulate new")
            }
            
            Group{
                Button{simulator.continueSubject()
                } label: {
                    Text("Continue same")
                }
                .disabled(!simulator.alive)     // If not alive, cannot allow continuation
                Button{
                    simulator.inspectSubject()
                } label: {
                    Text("Inspect")
                }
                Button{
                    simulator.dumpParameters()
                } label: {
                    Text("Dump")
                }
                //ShareLink("Export PDF", item:render())
            }
            .disabled(!simulator.patientStarted)
        }
        .buttonStyle(.bordered)
        .font(.headline)
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


