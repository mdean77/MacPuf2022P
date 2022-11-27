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
    var patientStarted = false
    
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
    var consoleContentString:String = ""
    var introduction:String = "                               Welcome to MacPuf.\n\nMacPuf is a model of the human respiratory system designed at McMaster University\nMedical School, Canada, and St. Bartholomew's Hospital Medical College, England, \nby Drs. CJ Dickinson, EJM Campbell, AS Rebuck, NL Jones, D Ingram, and K Ahmed.  \nMacPuf was created to study gas transport and exchange.  MacPuf contains simulated \nlungs, circulating blood, and tissues.  Initially MacPuf breathes at a rate and depth \ndetermined by known influences upon ventilation.\n\nEnjoy yourself and try not to hurt your new experimental volunteer (or patient!)\n"

    
    init(){
        human.setVariables()
        human.setConstants()
        loadFactorDictionary()
        outputResults(additionToString: introduction)
    }
    
    private func simulate(){
        // Eventually I will want to get all output removed from the simulate function
        // but for now this controls debugger output via print statements.
        iterations = iterations >= intervalFactor ? iterations : intervalFactor
        
       
//        print("\n   Time     0     10    20    30    40    50    60    70    80    90   100   110   120")
//        print("(Min:Secs)  .     .     .     .     .     .     .     .     .     .     .     .     .")

        outputResults(additionToString:"\n   Time     0     10    20    30    40    50    60    70    80    90   100   110   120\n")
        outputResults(additionToString:"(Min:Secs)  .     .     .     .     .     .     .     .     .     .     .     .     .")
       // consoleContentString.append(inspectionReport())
        
        for cycle in 0...iterations {
            
            human.simulate(cycle: cycle, iterations: iterations)
            totalSeconds += 1
            if cycle % intervalFactor == 0 {
               // print(cycleReport())
                outputResults(additionToString: cycleReport())
            }
        }
//        print("\nConditions after \(totalSeconds) seconds of simulation:")
//        print(runReport)
//        print(inspectionReport())
        outputResults(additionToString: "\nConditions after \(totalSeconds) seconds of simulation:")
        outputResults(additionToString: runReport())
        outputResults(additionToString: inspectionReport())
    }
    
    
    //MARK: INTENTION FUNCTIONS
    
    func startUp(){
        // Routine that will be called from Views to start new patient
        human.setVariables()
        human.setConstants()
        loadFactorDictionary()
        totalSeconds = -1
       // reportOut(title:"Initial conditions before starting simulations:")
      //  print(inspectionReport())
        //outputResults(additionToString: consoleContentString)
        outputResults(additionToString: introduction)
        simulate()
    }
    
    func continueSubject(){
        // Routine that will be called from Views to continue the same patient
        // DO NOT re-initialize variables of old model results will be destroyed
        human.setConstants()
        totalSeconds -= 1
        simulate()
    }
    
    func changeDurationSeconds(duration:Int){
        iterations = duration
    }
    
    func changeReportingInterval(interval:Int){
        intervalFactor = interval
    }
    
    func outputResults(additionToString:String){
        print(additionToString)
        consoleContentString.append(additionToString)
    }
}
