//
//  VariableListView.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 7/12/22.
//  November 29, 2022 Changed navigationView to navigationStack.
//  Refactored December 8, 2022

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
                        variableParams(params: frequentParams)
                    }
                Section(header: Text("Other parameter changes")
                    .font(.headline)){
                        variableParams(params: infrequentParams)
                    }
            }.navigationTitle("MacPuf Parameters")
                .font(.title)
        }
    }
    
    func variableParams(params:Range<Int>)-> some View {
        ForEach(params, id: \.self){i in
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
    
}

struct VariableListView_Previews: PreviewProvider {
    static var previews: some View {
        VariableListView()
            .environmentObject(Simulator())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
