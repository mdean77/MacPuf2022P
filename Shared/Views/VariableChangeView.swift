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
    @State var showInfo = false
    @State var showAlert = false
    
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
                infoButton
            }.padding(.top)
        }
    }
    
    var saveButton: some View {
        Button {
            if checkValue(index: index){
                simulator.changeParameterValue(key: index, value: Double(newValue) ?? simulator.factors[index]!.current)
                newValue = ""
            } else {
                showAlert.toggle()
                //newValue = ""
            }
            //newValue = ""
        } label: {Text("Save new value")
            
        }
        .padding(.horizontal)
        .buttonStyle(.bordered)
        .alert(isPresented: $showAlert, content: {
            Alert(title:Text("To change \(simulator.factors[index]!.title)") ,message:Text("Please enter a numerical value between \(simulator.factors[index]!.lower,specifier:simulator.factors[index]!.format) and \(simulator.factors[index]!.upper,specifier:simulator.factors[index]!.format).  The value is unchanged.")
            )
            
        })
        
    }
    
    var cancelButton: some View {
        Button {
            newValue = ""
        } label: {Text("Cancel change")
        }.padding(.horizontal)
            .buttonStyle(.bordered)
            .disabled(newValue == "")
        
    }
    
    var revertToReferenceButton: some View {
        Button {
            simulator.changeParameterValue(key: index, value: simulator.factors[index]!.reference)
            newValue = ""
        } label: {Text("Revert to reference value")
        }.padding(.horizontal)
            .buttonStyle(.bordered)
    }
    
    var infoButton: some View {
        Button {
            showInfo.toggle()
        } label: {Text("Info")
        }.padding(.horizontal)
            .buttonStyle(.bordered)
            .disabled(simulator.factors[index]!.information == "Information")
            .sheet(isPresented: $showInfo, content:{
                infoView
            })
    }
    
    var infoView:  some View {
        VStack{
            VStack(alignment: .center){
                
                Text("\(simulator.factors[index]!.title)")
                    .font(.title)
                
                Text("\nReference value: \(simulator.factors[index]!.reference,specifier:simulator.factors[index]!.format)")
                    .font(.subheadline)
                Text("Current Value: \(simulator.factors[index]!.current,specifier: simulator.factors[index]!.format)")
                    .font(.subheadline)
            }
            
            VStack(alignment: .leading){
                Text("\nValid values for this parameter range from \(simulator.factors[index]!.lower,specifier:simulator.factors[index]!.format) to \(simulator.factors[index]!.upper,specifier:simulator.factors[index]!.format).")
                Text("\n\(simulator.factors[index]!.information)")
            }
            
            HStack(alignment: .bottom) {
                Spacer()
                Button(action: {
                    showInfo.toggle()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.largeTitle)
                        .padding(20)
                }
                )}
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
