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
            }.padding()
            
            if let value = Double(newValue) {
                Text("Proposed new value: \(value,specifier: simulator.factors[index]!.format)")
            } else {
                Text("Current value: \(simulator.factors[index]!.current, specifier:simulator.factors[index]!.format)")
            }
            
            HStack{
                saveButton
                cancelButton
                revertToReferenceButton
            }.padding(.top)
        }
    }
    
    var saveButton: some View {
        Button {
            if checkValue(index: index){
                simulator.changeParameterValue(key: index, value: Double(newValue) ?? simulator.factors[index]!.current)}
            newValue = ""
        } label: {Text("Save new value")
            
        }.padding(.horizontal)
            .buttonStyle(.bordered)
            
    }
    
    var cancelButton: some View {
        Button {
            newValue = ""
        } label: {Text("Cancel change")
        }.padding(.horizontal)
            .buttonStyle(.bordered)
        
    }
    
    var revertToReferenceButton: some View {
        Button {
            simulator.changeParameterValue(key: index, value: simulator.factors[index]!.reference)
            newValue = ""
        } label: {Text("Revert to reference value")
        }.padding(.horizontal)
            .buttonStyle(.bordered)
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
