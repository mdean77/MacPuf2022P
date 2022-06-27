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
        let result4 = String(format:"Respiratory rate =  %5.1f          Tidal vol.= %6.0f ml\n", human.RRATE, human.TIDVL)
        let result5 = String(format:"Total ventilation = %5.1f l/min    Actual cardiac output = %4.1f l/min\n",human.DVENT, human.COADJ)
        let result6 = String(format:"Total dead space =   %4.0f ml       Actual venous admixture = %3.1f%%\n",human.DSPAC,human.PW)
        let result7 = String(format:"Cardiac output =    %5.1f l/min    Cerebral blood flow = %5.1f ml/100g/min\n", human.COADJ, human.CBF)
        let result8 = String(format:"Heart rate =        %5.1f          Stroke volume = %5.1f ml\n", human.HRATE, human.STRVL)
        return result + result1 + result2 + result3 + result4 + result5 + result6 + result7 + result8
    }
    
    
    func dumpParametersReport() -> String {
        // Print out first 6 changeable parameters
        
        let result = String(format:"\nList of first six parameters:\n     Inspired O2 %%:%6.1f\n     Inspired CO2 %%:%6.2f\n     Cardiac performance %% of normal:%7.2f\n     Metabolic rate %% of normal:%7.2f\n     Extra anatomic right to left shunt:%6.2f\n     Extra dead space:%6.2f",human.FIO2,human.FIC2,human.CO,human.PD,human.FADM, human.BULLA)
        return result;
    }
    
    func inspectionReport()->String{
        let header = String(format:"\nTime         P.Pressures     Contents cc/dl  Amounts in cc  pH    HCO3-\n%4d secs     O2     CO2      O2     CO2       O2     CO2", totalSeconds+1)
        
        let artString = String(format:"\nArterial %8.1f%8.1f%8.1f%8.1f%8.0f%8.0f%7.3f%6.1f",
                               human.RO2PR, human.RC2PR,human.RO2CT,human.RC2CT,human.RO2MT,human.RC2MT,human.RPH,human.RC3CT)
        let result1 = String(format:"\nAlv./Lung%8.1f%8.1f    (Sat = %4.1f%%) %6.0f%8.0f",human.AO2PR, human.AC2PR,human.PJ,human.AO2MT,human.AC2MT)
        let result2 = String(format:"\n(Pulm.cap)%7.1f%8.1f%8.1f%8.1f",human.AO2PR, human.AC2PR,human.PO2CT,human.PC2CT)
        let lungString = result1 + result2
        let brainString = String(format:"\nBrain/CSF%8.1f%8.1f%8.1f%8.1f%8.0f%8.0f%7.3f%6.1f",human.BO2PR, human.BC2PR,human.BO2CT, human.BC2CT,human.BO2MT,human.BC2MT,human.BPH,human.BC3CT + human.BC3AJ)

        let tissueString = String(format:"\nTissue/ECF%7.1f%8.1f%8.1f%8.1f%8.0f%8.0f%7.3f%6.1f",human.TO2PR, human.TC2PR,human.TO2CT, human.TC2CT,human.TO2MT, human.TC2MT*1000, human.TPH, human.TC3CT)
        let veinString = String(format:"\nMixed Ven. (same as tissue)%6.1f%8.1f%8.0f%8.0f%7.3f%6.1f",human.VO2CT, human.VC2CT, human.VO2MT, human.VC2MT, human.TPH, human.TC3CT)
        let lactateString = String(format:"\nPlasma lactate conc.= %4.2f mmol/l", human.RLACT)
        let inspiratoryTime = 60 * human.SPACE/human.RRATE
        let ieRatio = human.SPACE/(1 - human.SPACE)
        let ventilatorString = human.NARTI == 1 ? "" :
        String(format:"\nVentilator on. PEEP = %2.0f    Inspiratory time = %4.1f secs   I:E = %4.2f",human.PEEP, inspiratoryTime, ieRatio)
        let bagString = human.PL == 0 ? "" : String(format:"\nDouglas bag connected. Volume = %4.0f ml, O2 = %4.0f ml, CO2 = %4.0f ml", human.BAG, human.BAGO, human.BAGC)
        let result = header + artString + lungString + brainString + tissueString + veinString + lactateString +  ventilatorString + bagString
        return(result)
    }
    
    func reportOut(title: String){
        print(title)
        print(runReport())
        print(inspectionReport())
        print(dumpParametersReport())
    }
    
    mutating func simulate(){
        human.getConstants()    // only happens once per run instead of every iteration
        iterations = iterations >= intervalFactor ? iterations : intervalFactor
        reportOut(title:"Initial conditions before starting simulations:")
        print("\n   Time     0     10    20    30    40    50    60    70    80    90   100   110   120")
        print("(Min:Secs)  .     .     .     .     .     .     .     .     .     .     .     .     .")
        for cycle in 0...iterations {
            human.simulate(cycle: cycle, iterations: iterations)
            totalSeconds += 1
            if cycle % intervalFactor == 0 {
                print(cycleReport())
            }
        }
        reportOut(title: "\nConditions after \(iterations) seconds of simulation:")
    }
    
}
