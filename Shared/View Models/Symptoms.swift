//
//  Symptoms.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 12/1/22.
//  This extension observes the model variables to determine if death
//  or symptoms occur.  Arithmetic error also will force a restart
//  of the simulation but won't count as death.
//

import Foundation

extension Simulator {
    /// Observes the human model for fatal parameter values and changes the alive flag to false.
    /// Also provides information for the view to update by appending to the consoleContentString that
    /// the patient has died..
    ///

    func observeForDeath() {
        if human.TPH < 6.63  {
            outputResults(additionToString: "\nYour patient has died ...\n")
            alive = false        }
    if human.TPH > 7.8 {
        
    }
        // This is temporary - need to handle additional variables
    }
    
    /// Observes the human model for parameter values that should lead to patient symptoms,
    /// and appends these symptoms to the consoleContentString. There is no return parameter.
    ///
    func observeForSymptoms(){
        
    }
    
    /// Observes the human model for arithmetic errors and changes the alive flag to false.  However
    /// it reports in the consoleContentString that there has been an arithmetic error, rather than telling
    /// the user that the patient has died.
    ///
    /// Checks RC3CT, TC3CT, VC3CT, TO2MT, AO2PR, and AC2PR.
    ///
    func observeForArithmeticError(){
        let paramsToCheck:[(param:Double,desc:String)] =
        [(human.RC3CT, "\n\nRC3CT - arterial bicarbonate content "),
         (human.TC3CT,"\n\nTC3CT - tissue bicarbonate content "),
         (human.VC3CT, "\n\nVC3CT - venous bicarbonate content "),
         (human.TO2MT, "\n\nTO2MT - tissue oxygen amount "),
         (human.AO2PR, "\n\nAO2PR - arterial pO2 "),
         (human.AC2PR, "\n\nAC2PR - arterial pCO2 ")]
        for parameter in paramsToCheck {
            if parameter.param < 0.001 {
                alive = false
                outputResults(additionToString:"\(parameter.desc) has gone negative.  Cannot continue simulation.")
            }
        }
    
    }
}
