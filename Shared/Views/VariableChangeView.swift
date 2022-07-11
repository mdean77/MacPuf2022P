//
//  VariableChangeView.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 7/10/22.
//

import SwiftUI

struct VariableChangeView: View {
    

    let index:Int
    @ObservedObject var simulator: Simulator
    @State  var newValue:Double? = 0.0


    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    func checkValue(index:Int)-> Bool{
        // Check new value against limits in the dictionary
        if let value = newValue {
            return value >= simulator.factors[index]!.lower && value <= simulator.factors[index]!.upper}
        return false
    }
    
    var body: some View {
        VStack(alignment: .center){
            Text(simulator.factors[index]!.title)
                .font(.subheadline)
            Text("Reference value: \(simulator.factors[index]!.reference,specifier:simulator.factors[index]!.format)")
                .font(.caption)
            Text("Current Value: \(simulator.factors[index]!.current,specifier: simulator.factors[index]!.format)")
                .font(.caption)
            HStack{
                Text("Change value:").padding(.leading)
                TextField("Enter new value", value: $newValue, formatter: formatter)
            }
            Text("Proposed new value = \(newValue ?? simulator.factors[index]!.current, specifier:simulator.factors[index]!.format)")
            HStack{
                Button {
                    if checkValue(index: index){
                        simulator.changeParameterValue(key: index, value: newValue ?? simulator.factors[index]!.current)}
                } label: {Text("Save new value")
                }.padding()
                Button {
                    newValue = simulator.factors[index]!.current
                } label: {Text("Cancel change")
                }.padding()
                Button {
                    simulator.changeParameterValue(key: index, value: simulator.factors[index]!.reference)
                    newValue = simulator.factors[index]!.current
                    
                } label: {Text("Revert to reference value")
                }.padding()
            }.padding()

        }
    }
}

struct VariableChangeView_Previews: PreviewProvider {
    static var previews: some View {
        let simulator = Simulator()
        let index = 1
        VariableChangeView(index:index, simulator: simulator)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
