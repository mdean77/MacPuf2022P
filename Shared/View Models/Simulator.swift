//
//  Simulator.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/25/22.
//
//  This is my ViewModel class which mediates between the model (Human) and the views.

import Foundation

class  Simulator: ObservableObject {
    var iterations = 180
    var intervalFactor = 10
    var totalSeconds = 0
    struct Factor {
        let title:String
        let reference: Double
        var current:Double
    }
    var factors: [Int:Factor] = [:]
//    factors[1] = Factor("Inspired O2 (%)",20.93, human.FIO2)
//    factors[2] = Factor("Inspired CO2 (%)", 0.0, human.FIC2)
//    factors[3] = Factor("Cardiac pump performance (% normal)", 100, human.CO)
    @Published private (set) var human = Human()

    init(){
        human.getVariables()
        human.getConstants()
        loadFactorDictionary()
    }
    
    private func loadFactorDictionary(){
        factors[1] = Factor(title: "Inspired O2 (%)",reference: 20.93, current: human.FIO2)
        factors[2] = Factor(title: "Inspired CO2 (%)", reference: 0.0, current: human.FIC2)
        factors[3] = Factor(title: "Cardiac pump performance (% normal)", reference: 100, current: human.CO)
    }
    
    private func simulate(){
        // Eventually I will want to get all output removed from the simulate function
        // but for now this controls debugger output via print statements.
        iterations = iterations >= intervalFactor ? iterations : intervalFactor
        
        
        print("\n   Time     0     10    20    30    40    50    60    70    80    90   100   110   120")
        print("(Min:Secs)  .     .     .     .     .     .     .     .     .     .     .     .     .")

        for cycle in 0...iterations {
            
            human.simulate(cycle: cycle, iterations: iterations)
            totalSeconds += 1
            if cycle % intervalFactor == 0 {
                print(cycleReport())

            }
        }
        reportOut(title: "\nConditions after \(totalSeconds) seconds of simulation:")
        print(runReport)
        print(inspectionReport())

    }
    
    
    //MARK: INTENTION FUNCTIONS
    
    func startUp(){
        // Routine that will be called from Views to start new patient
        human.getVariables()
        human.getConstants()
        totalSeconds = -1
        reportOut(title:"Initial conditions before starting simulations:")
        print(inspectionReport())
        simulate()
    }
    
    func continueSubject(){
        // Routine that will be called from Views to continue the same patient
        // DO NOT re-initialize variables of old model results will be destroyed
        human.getConstants()
        totalSeconds -= 1
        simulate()
    }
    
    /// This view model function will change the value of one of the first 30 parameters.
    /// - Parameters:
    ///   - key: String to represent the variable name, i.e. TIDVL
    ///   - value: New value for the variable
    
    func changeParameterValue(key: String, value: Double)-> (){
        switch key {
        case "FIO2":
            human.FIO2 = value
            print("FiO2 changed to \(value)%.")
        case "FIC2":
            human.FIC2 = value
            print("FiCO2 changed to \(value)%.")
        case "CO":
            human.CO = value
            print("Cardiac function changed to \(value)% of normal.")
        case "PD":
            human.PD  = value
            print("Metabolic rate changed to \(value)% of normal.")
        case "FADM":
            human.FADM  = value
            print("Fixed right to left shunt  changed to \(value)% of cardiac output. Default = 0.")
        case "BULLA":
            human.BULLA  = value
            print("Added dead space changed to \(value)cc (BTPS). Default = 0.")
        case "VLUNG":
            human.VLUNG  = value
            print("Total lung volume changed to \(value)cc (BTPS). Default = 3000.")
        case "ELAST":
            human.ELAST  = value
            print("Elastance changed to \(value)cm H2O/liter. Default = 5.")
        case "VADM":
            human.VADM  = value
            print("Dynamic venous admixture changed to \(value). Default = 3.")
        case "BARPR":
            human.BARPR  = value
            print("Barometric pressure changed to \(value)mmHg.  Default = 760.")
        case "TEMP":
            human.TEMP  = value
            print("Temperature changed to \(value). Default = 37.0 C.")
            
        default: print("Error - no such variable")
        }
        

        
    }
    
    func changeDurationSeconds(duration:Int){
        iterations = duration
    }
    
    func changeReportingInterval(interval:Int){
        intervalFactor = interval
    }
}
