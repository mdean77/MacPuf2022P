//
//  Simulator.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/25/22.
//
//  This is my ViewModel class which mediates between the model (Human) and the views.

import Foundation

class  Simulator: ObservableObject {
    var iterations = 30
    var intervalFactor = 1
    var totalSeconds = 0
    
    struct Factor {
        let title:String
        let reference: Double
        var current:Double
        var format:String
        var lower:Double        //Lower acceptable limit for changed parameter
        var upper:Double        //Upper acceptable limit for changed parameter
    }
    
    @Published var human = Human()
    @Published var factors:[Int:Factor] = [:]
    
    init(){
        human.setVariables()
        human.setConstants()
        loadFactorDictionary()
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
        human.setVariables()
        human.setConstants()
        loadFactorDictionary()
        totalSeconds = -1
        reportOut(title:"Initial conditions before starting simulations:")
        print(inspectionReport())
        simulate()
    }
    
    func continueSubject(){
        // Routine that will be called from Views to continue the same patient
        // DO NOT re-initialize variables of old model results will be destroyed
        human.setConstants()
        totalSeconds -= 1
        simulate()
    }
    
    /// This view model function will change the value of one of the first 30 parameters.
    /// - Parameters:
    ///   - key: Integer that indicates index into the dictionary
    ///   - value: New value for the variable
    /// func changeParameterValue(key: Int, value: Double)-> (){
    /// THIS IS AN EXTENSION OF SIMULATOR.
    /// SOURCE IN A DIFFERENT FILE.
    
    
    
    func changeDurationSeconds(duration:Int){
        iterations = duration
    }
    
    func changeReportingInterval(interval:Int){
        intervalFactor = interval
    }
}
