//
//  Simulator.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/25/22.
//

import Foundation

struct Simulator {
    var iterations = 1800
    var intervalFactor = 300
    var totalSeconds = -1
    var human = Human()
    
    func cycleReport() -> String{
        // Returns a string for single line of output
        let scale = 120.0
        let lineWidth = 72.0
        let factor = lineWidth/scale
        let po2 = human.RO2PR < scale ? Int(human.RO2PR*factor) : Int(lineWidth)
        let pco2 = human.RC2PR < scale ? Int(human.RC2PR*factor) : Int(lineWidth)
        let vent = Int(human.DVENT*factor)  // Replace with lungs.totalVentilation when I have lungs
        let rate = Int(human.RRATE*factor)  // Replace with lungs.respiratoryRate when I have lungs
        
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        var temp = String(repeating: " ", count: 73)
        
        let oxygenIndex = temp.index(temp.startIndex, offsetBy:po2)
        let carbonDioxideIndex = temp.index(temp.startIndex, offsetBy:pco2)
        let rateIndex = temp.index(temp.startIndex, offsetBy: rate)
        let ventIndex = temp.index(temp.startIndex, offsetBy: vent)
        
        temp.replaceSubrange(oxygenIndex...oxygenIndex, with:"O")
        temp.replaceSubrange(carbonDioxideIndex...carbonDioxideIndex, with:"C")
        temp.replaceSubrange(rateIndex...rateIndex, with:"F")
        temp.replaceSubrange(ventIndex...ventIndex, with:"V")
        let result = String(format:"%4d:%2d     ",minutes, seconds).appending(temp)
        return(result)
    }
    
    func runReport()->String{
        // This prints description after the iterations have been run
        let x = 10*pow(2,(8.0 - human.RPH)*3.33)
        let result = String(format:"\nFinal values for this run were...\n\n")
        let result1 = String(format:"Arterial pO2 = %6.1f              O2 Cont =%6.1f      O2 Sat = %5.1f%%\n",human.RO2PR, human.RO2CT,human.PJ)
        let result2 = String(format:"Arterial pCO2 = %5.1f              CO2 Cont =%6.1f\n",human.RC2PR,human.RC2CT)
        let result3 = String(format:"Arterial pH = %7.2f (%3.1f nm)    Arterial bicarbonate = %5.1f\n\n",human.RPH,x,human.RC3CT)
        let result4 = String(format:"Respiratory rate = %5.1f           Tidal vol.= %6.0f ml\n", human.RRATE, human.TIDVL)
        let result5 = String(format:"Total ventilation =%5.1f l/min     Actual cardiac output = %5.1f l/min\n",human.DVENT, human.COADJ)
        let result6 = String(format:"Total dead space = %4.0f ml         Actual venous admixture = %3.1f%%\n",human.DSPAC,human.PW)
        
        return result + result1 + result2 + result3 + result4 + result5 + result6
    }
    
    
    func dumpParametersReport() -> String {
        "Dump Parameters Report"
    }
    
    func inspectionReport()->String{
        "Inspection Report"
    }
    
    func reportOut(title: String){
        print(title)
        print(runReport())
        print(dumpParametersReport())
        print(inspectionReport())
    }
    
    mutating func simulate(){
        iterations = iterations >= intervalFactor ? iterations : intervalFactor
        reportOut(title:"Initial conditions before starting simulations:")
        print("\n   Time     0     10    20    30    40    50    60    70    80    90   100   110   120")
        print("(Min:Secs)  .     .     .     .     .     .     .     .     .     .     .     .     .")
        for cycle in 0..<iterations {
            human.simulate(cycle: cycle, iterations: iterations)
            totalSeconds += 1
            if cycle % intervalFactor == 0 {
                print(cycleReport())
            }
        }
        reportOut(title: "Conditions after \(iterations) seconds of simulation:")
    }
    
}
