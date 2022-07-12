//
//  VariableChangeView.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 7/10/22.
//

import SwiftUI

struct VariableChangeView: View {
    

    let index:Int
    @EnvironmentObject var simulator: Simulator
    @State var newValue:String = ""

//    let formatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        //formatter.numberStyle = .decimal
//        formatter.maximumFractionDigits = 3
//        return formatter
//    }()
    
    func checkValue(index:Int)-> Bool{
        // Check new value against limits in the dictionary
        if let value = Double(newValue) {
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
                TextField("Enter new value", text: $newValue)
            }
            
            if let value = Double(newValue) {
            Text("Proposed new value = \(value)")
            } else {
                Text("Current value unchanged: \(simulator.factors[index]!.current, specifier:simulator.factors[index]!.format)")
            }
            
            HStack{
                Button {
                    if checkValue(index: index){
                        simulator.changeParameterValue(key: index, value: Double(newValue) ?? simulator.factors[index]!.current)}
                    newValue = ""
                } label: {Text("Save new value")
                }.padding()
                Button {
                    newValue = ""
                } label: {Text("Cancel change")
                }.padding()
                Button {
                    simulator.changeParameterValue(key: index, value: simulator.factors[index]!.reference)
//                    newValue = "\(simulator.factors[index]!.current)"
                    newValue = ""
                } label: {Text("Revert to reference value")
                }.padding()
            }.padding()

        }
    }
}

struct VariableChangeView_Previews: PreviewProvider {
    static var previews: some View {
        let index = 1
        VariableChangeView(index:index)
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(Simulator())
    }
}
