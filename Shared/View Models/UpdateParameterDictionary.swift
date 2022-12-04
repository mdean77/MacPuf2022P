//
//  UpdateParameterDictionary.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 12/4/22.
//

import Foundation

extension Simulator {
    /// This dictionary is necessary beause otherwise the user cannot tell the program which variables he or she wants
    /// to follow during simulations.  For normal users, this is not needed, but if someone wants to follow changes in
    /// specific components of the model, there needs to be a way to SELECT these.  In the original FORTRAN, the
    /// parameters were stored in a COMMON block that was accessible by index numbers, but this is not the case
    /// for the Swift implementation.  Recall that each entry is a Parameter:
    ///
    ///     struct Parameter {
    ///         let abbreviation:String
    ///         let title:String
    ///         let current:Double
    ///         let Format:String
    ///
    /// The abbreviation is the FORTRAN name of the variable and will be printed at the top;  we need some way
    /// to print out these values in a succinct manner, and also have a way to potentially export these values into
    /// CSV format with labels at the top.
    ///
    /// The title is the description that the user will normally see and will describe what the parameter is.
    ///
    /// The current field is the value and this is what gets updated on every cycle of the simulation.  The format
    /// string is what is used to print out the value in repiorts.
    func updateParameterDictionary(){
        
    }
}
