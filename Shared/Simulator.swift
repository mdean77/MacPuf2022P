//
//  Simulator.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/25/22.
//
//  This is my ViewModel class which mediates between the model (Human) and the views.

import Foundation

class  Simulator {
    var iterations = 1800
    var intervalFactor = 300
    var totalSeconds = -1
    var human = Human()
    
    func simulate(){
        human.getVariables()    // Initialization once - these are recalculated during simulation
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
