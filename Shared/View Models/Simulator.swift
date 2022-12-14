//
//  Simulator.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/25/22.
//  Extensive revisions November 28, 2022.
//
//  This is my ViewModel class which mediates between the model (Human) and the views.

import Foundation

class  Simulator: ObservableObject {
    @Published var iterations = 60
    @Published var intervalFactor = 6
    var totalSeconds = 0
    var patientStarted = false
    var alive = false
    
    /// Factors are changeable by the user and are not recalculated during the simulation.
    /// The lower and upper bounds restrict the changes that will be permitted.
    struct Factor {
        let title:String
        let reference: Double
        var current:Double
        var format:String
        var lower:Double        //Lower acceptable limit for changed parameter
        var upper:Double        //Upper acceptable limit for changed parameter
        var information:String
    }
    
    /// Parameters are changed continuously during the simulation.  It would not make sense
    /// for a user to change any of these, but it is important to be able to report on any of them.
    struct Parameter {
        let abbreviation:String
        let title:String
        let current:Double
        let Format:String
    }
    
    enum OutputFormats:String, CaseIterable, Equatable {
        case GraphsOnly = "Graphs Only"
        case GraphsAndTables = "Graphs and Tables"
        case SelectedVariables = "Selected Parameters"
    }
    
    @Published var outputFormat:OutputFormats = .GraphsAndTables

    var human = Human()
    var factors:[Int:Factor] = [:]
    var parameters:[Int:Parameter] = [:]
    
    @Published var consoleContentString:String = ""
    var introduction:String = "                               Welcome to MacPuf.\n\nMacPuf is a model of the human respiratory system designed at McMaster University\nMedical School, Canada, and St. Bartholomew's Hospital Medical College, England, \nby Drs. CJ Dickinson, EJM Campbell, AS Rebuck, NL Jones, D Ingram, and K Ahmed.  \nMacPuf was created to study gas transport and exchange.  MacPuf contains simulated \nlungs, circulating blood, and tissues.  Initially MacPuf breathes at a rate and depth \ndetermined by known influences upon ventilation.\n\nEnjoy yourself and try not to hurt your new experimental volunteer (or patient!)\n"

    
    init(){
        human.setVariables()
        human.setConstants()
        loadFactorDictionary()
        outputResults(additionToString: introduction)
    }
    
    fileprivate func cycleReportOutput(addition:String) {
        for cycle in 0...iterations {
            if alive {
                human.simulate(cycle: cycle, iterations: iterations)
                totalSeconds += 1
                if cycle % intervalFactor == 0 {
                    outputResults(additionToString: addition)
                }
                observeForArithmeticError()
            }
        }
    }
    
    private func simulate(){
        iterations = iterations >= intervalFactor ? iterations : intervalFactor
        switch outputFormat{
        case .GraphsAndTables:
                    outputResults(additionToString: dumpFirstSixParametersReport())
            
                    outputResults(additionToString:"\n   Time     0     10    20    30    40    50    60    70    80    90   100   110   120\n")
                    outputResults(additionToString:"(Min:Secs)  .     .     .     .     .     .     .     .     .     .     .     .     .")
            for cycle in 0...iterations {
                if alive {
                    human.simulate(cycle: cycle, iterations: iterations)
                    totalSeconds += 1
                    if cycle % intervalFactor == 0 {
                        outputResults(additionToString: cycleReport())
                    }
                    observeForArithmeticError()
                }
            }
            //cycleReportOutput(addition: cycleReport())
                    outputResults(additionToString: runReport())
        
        case .GraphsOnly:
            
                    outputResults(additionToString:"\n   Time     0     10    20    30    40    50    60    70    80    90   100   110   120\n")
                    outputResults(additionToString:"(Min:Secs)  .     .     .     .     .     .     .     .     .     .     .     .     .")
                   // cycleReportOutput(addition: cycleReport())
                    for cycle in 0...iterations {
                        if alive {
                            human.simulate(cycle: cycle, iterations: iterations)
                            totalSeconds += 1
                            if cycle % intervalFactor == 0 {
                                outputResults(additionToString: cycleReport())
                            }
                            observeForArithmeticError()
                        }
                    }

        
        case .SelectedVariables:
            outputResults(additionToString: selectedVariablesHeader())
//            cycleReportOutput(addition: selectedVariablesValues())
            for cycle in 0...iterations {
                if alive {
                    human.simulate(cycle: cycle, iterations: iterations)
                    totalSeconds+=1
                    if cycle % intervalFactor == 0 {
                        outputResults(additionToString: selectedVariablesValues())
                    }
                    observeForArithmeticError()
                }
            }
        }


    }
    
    //MARK: INTENTION FUNCTIONS
    
    func startUp(){
        // Routine that will be called from Views to start new patient
        consoleContentString = ""
        human.setVariables()
        human.setConstants()
        loadFactorDictionary()
        totalSeconds = -1
        outputResults(additionToString: introduction)
        patientStarted = true
        alive = true
        simulate()
    }
    
    func continueSubject(){
        // Routine that will be called from Views to continue the same patient
        // DO NOT re-initialize variables of old model results will be destroyed
        human.setConstants()
        totalSeconds -= 1
        simulate()
    }
    
    func inspectSubject(){
        outputResults(additionToString: inspectionReport())
    }
    
    func dumpParameters(){
        outputResults(additionToString: dumpAllParametersReport())
    }
    
    func changeDurationSeconds(duration:Int){
        iterations = duration
    }
    
    func changeReportingInterval(interval:Int){
        intervalFactor = interval
    }
    
    func outputResults(additionToString:String){
        // Print statements send output to debugger, not to the app screens on the phone.
        // The consoleContentString contains what should be displayed in the text editor
        // that forms the main simulation view.  So I append to that string, the string
        // is changed, and binding changes what is shown in the view automatically.

        print(additionToString)
        consoleContentString.append(additionToString)
    }
}
