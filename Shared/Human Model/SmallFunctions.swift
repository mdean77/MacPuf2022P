//
//  SmallFunctions.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/25/22.
//

import Foundation

extension Human {
    
    /// Calculates the pH of a relevant compartment.
    ///
    ///Standard equation.  The original FORTRAN code :
    ///
    ///     PHFNC(X,Y)=6.1+ALOG(X/(.03*Y))*.434294482
    ///
    /// - Parameters:
    ///   - bicarbonate: Bicarbonate
    ///   - CO2: pCO2
    /// - Returns: pH of the compartment.
    func calculatePh(_ bicarbonate:Double, CO2:Double) -> Double {
        return (6.1 + log10((bicarbonate)/(CO2 * 0.03)))
    }
    
    /// This function dampens changes in MacPuf to prevent oscillations or alterations that are
    /// too stark for reality.  It was originally put in the code because of long iteration intervals
    /// of 10 seconds, and I am using a 1 second interval.  This function may not be required
    /// but I have left it in place until I get everything working properly.
    ///
    /// - Parameters:
    ///   - newValue: The proposed new value, without being dampened.
    ///   - oldValue: The old value, obviousliy.
    ///   - dampConstant: The damp constant, which has been calculated based on other physiological parameters.
    ///
    /// - Returns: The new value, after dampening.
    func dampChange(_ newValue:Double, oldValue:Double, dampConstant:Double) -> Double {
        return (newValue * dampConstant + oldValue)/(dampConstant + 1)
    }
    

}
