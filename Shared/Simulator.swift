//
//  Simulator.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/25/22.
//
//  This is my ViewModel class which mediates between the model (Human) and the views.

import Foundation

class  Simulator {
    var iterations = 4
    var intervalFactor = 1
    var totalSeconds = -1
    var human = Human()
    
    
    private func simulate(){
        // Eventually I will want to get all output removed from the simulate function
        // but for now this controls debugger output via print statements.
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
        //print(dumpAllParametersReport())
    }
    
    
    //MARK: INTENTION FUNCTIONS
    
    func startUp(){
        // Routine that will be called from Views to start new patient
        human.getVariables()
        human.getConstants()
        //print(dumpAllParametersReport())
        simulate()
    }
    
    func continueSubject(){
        // Routine that will be called from Views to continue the same patient
        // DO NOT re-initialize variables of old model results will be destroyed
        human.getConstants()
        //print(dumpAllParametersReport())
        simulate()
    }
}
