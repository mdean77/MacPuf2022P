//
//  VariableListView.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 7/12/22.
//

import SwiftUI

struct VariableListView: View {
    @EnvironmentObject var simulator: Simulator
    var body: some View {
//        changeVariables
//    }
    
//    var changeVariables: some View {
        NavigationView{
            List{
                Section(header: Text("Frequent parameter changes")){
                    ForEach(1..<7){i in
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
                Section(header: Text("Other parameter changes")){
                    ForEach(7..<31){i in
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
            }.navigationTitle("MacPuf Variables")
                .font(.title)
        }
    }
}

struct VariableListView_Previews: PreviewProvider {
    static var previews: some View {
        VariableListView()
            .environmentObject(Simulator())
    }
}
