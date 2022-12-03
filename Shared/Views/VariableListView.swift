//
//  VariableListView.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 7/12/22.
//  November 29, 2022 Changed navigationView to navigationStack.

import SwiftUI

struct VariableListView: View {
    @EnvironmentObject var simulator: Simulator
    let frequentParams: Range = 1..<7
    let infrequentParams: Range = 7..<31
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("Frequently changed parameters")
                    .font(.headline)){
                        ForEach(frequentParams, id: \.self){i in
                            NavigationLink(destination: VariableChangeView(index: i)){
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
                Section(header: Text("Other parameter changes")
                    .font(.headline)){
                        ForEach(infrequentParams, id: \.self){i in
                            
                            
                            NavigationLink(destination: VariableChangeView(index: i)){
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
            }.navigationTitle("MacPuf Parameters")
                .font(.title)
        }
    }
}

struct VariableListView_Previews: PreviewProvider {
    static var previews: some View {
        VariableListView()
            .environmentObject(Simulator())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
