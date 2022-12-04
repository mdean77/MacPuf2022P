//
//  ChangeVariableValues.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 7/11/22.
//

import Foundation

extension Simulator {
    /// This view model function will change the value of one of the first 30 parameters.
    /// - Parameters:
    ///   - key: Integer that indicates index into the dictionary
    ///   - value: New value for the variable
    
    func changeParameterValue(key: Int, value: Double)-> (){
        
        func printString()->(){
            outputResults(additionToString: "\n\(factors[key]!.title) changed from \(factors[key]!.current) to \(value).\n")
        }
        
        func updateFactorDictionary()->(){
            factors[key]!.current = value
        }
        
        switch key {
        case 1:
            printString()
            human.FIO2 = value
            updateFactorDictionary()
        case 2:
            printString()
            human.FIC2 = value
            updateFactorDictionary()
        case 3:
            printString()
            human.CO = value
            updateFactorDictionary()
        case 4:
            printString()
            human.PD  = value
            updateFactorDictionary()
        case 5:
            printString()
            human.FADM  = value
            updateFactorDictionary()
        case 6:
            printString()
            human.BULLA  = value
            updateFactorDictionary()
        case 7:
            printString()
            human.VLUNG  = value
            updateFactorDictionary()
        case 8:
            printString()
            human.ELAST  = value
            updateFactorDictionary()
        case 9:
            printString()
            human.VADM  = value
            updateFactorDictionary()
        case 10:
            printString()
            human.AZ  = value
            updateFactorDictionary()
        case 11:
            printString()
            human.BZ  = value
            updateFactorDictionary()
        case 12:
            printString()
            human.CZ  = value
            updateFactorDictionary()
        case 13:
            printString()
            human.BARPR  = value
            updateFactorDictionary()
        case 14:
            printString()
            human.TEMP  = value
            updateFactorDictionary()
        case 15:
            printString()
            human.TRQ  = value
            updateFactorDictionary()
        case 16:
            printString()
            human.TC2MT  = value
            updateFactorDictionary()
        case 17:
            printString()
            human.TVOL  = value
            updateFactorDictionary()
        case 18:
            printString()
            human.HB  = value
            updateFactorDictionary()
        case 19:
            printString()
            human.PCV  = value
            updateFactorDictionary()
        case 20:
            printString()
            human.VBLVL  = value
            updateFactorDictionary()
        case 21:
            printString()
            human.ADDC3  = value
            updateFactorDictionary()
        case 22:
            printString()
            human.BC3AJ  = value
            updateFactorDictionary()
        case 23:
            printString()
            human.DPG  = value
            updateFactorDictionary()
        case 24:
            printString()
            human.PR  = value
            updateFactorDictionary()
        case 25:
            printString()
            human.FITNS  = value
            updateFactorDictionary()
        case 26:
            printString()
            human.SPACE  = value
            updateFactorDictionary()
        case 27:
            printString()
            human.COMAX  = value
            updateFactorDictionary()
        case 28:
            printString()
            human.SHUNT  = value
            updateFactorDictionary()
        case 29:
            printString()
            human.VC  = value
            updateFactorDictionary()
        case 30:
            printString()
            human.PEEP  = value
            updateFactorDictionary()
            
        default: print("Error - no such variable")
        }
        
        
    }
}
