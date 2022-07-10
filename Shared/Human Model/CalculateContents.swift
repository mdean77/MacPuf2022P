//
//  CalculateContents.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/25/22.
//

import Foundation
// This method replaces the MacPuf GASES subroutine.  It accepts any values of pO2, pCO2 and pH and
// works out O2 and CO2 contents and the saturation of O2.  It also needs values for temperature,
// hematocrit, hemoglobin and DPG.  Since these values are usually normal I have provided default values
// but these can be overridden if the developer allows these parameters to be changed by the user.

extension Human {
    /// This extension calculates oxygen and carbon dioxide contents from Kelman equations.
    ///
    /// The function replaces the MacPuf GASES subroutine in the original FORTRAN code.  I have written it to accept three
    /// parameters with default values for the remaining parameters.  The default parameters are mostly for testing, as the MacPuf
    /// simulation may have been significantly altered by the user.
    ///
    /// - Parameters:
    ///     - pO2: The partial pressure of O2 from the relevant compartment.
    ///     - pCO2: The partial pressure of CO2 from the relevant compartment.
    ///     - pH: The pH from the relevant compartment.
    ///     - temperature: Subject body temperature in Centigrade
    ///     - DPG: Subject DPG
    ///     - Hct: Subject Hct as a fraction less than 1.00
    ///     - Hgb: Hemoglobin in grams/deciliter
    ///
    /// - Returns:Tuple containing oxygenContent and carbonDioxideContent of the relevant compartment.
    ///
    func calculateContents(pO2:Double, pCO2:Double, pH:Double,
                           temperature:Double = 37.0, DPG:Double = 3.7843,
                           Hct:Double = 0.45, Hgb:Double = 14.8)
    ->(oxygenContent: Double, carbonDioxideContent:Double, oxygenSaturation:Double){

        // Series of constants needed for the Kelman equations
        let a1 = -8.532229E3
        let a2 = 2.121401E3
        let a3 = -6.707399E1
        let a4 = 9.359609E5
        let a5 = -3.134626E4
        let a6 = 2.396167E3
        let a7 = -6.710441E1
        
        // Original FORTRAN: X=PO2*10.**(.4*(PH-DPH)+.024*(37.-TEMP)+.026057699*(ALOG(40./PC2)))
        var dph = 7.4 + (DPG - 3.8) * 0.025
        dph = (dph > 7.58) ? 7.58 : dph
        let a = 0.4 * (pH - dph)
        let b = 0.024 * (37.0 - temperature)
        let c = 0.026057699 * (log(40.0/pCO2))
        var x = pO2 * pow(10.0,(a + b + c ))
        x = (x < 0.01) ? 0.01 : x   // Make sure x is at least greater than 0.01
        let sat = (x >= 10) ? (x * (x * (x * (x + a3) + a2) + a1))/(x * (x * (x * (x + a7) + a6) + a5) + a4) : (0.003683 + 0.000584 * x) * x
        let o2Content = Hgb * sat * 1.34 + 0.003 * pO2
        //o2Content = (o2Content < 0.001) ? 0.001 : o2Content
        let p = 7.4 - pH
        let pk = 6.086 + p * 0.042 + (38.0 - temperature) * (0.00472 + 0.00139 * p)
        let t = 37 - temperature
        let sol = 0.0307 + (0.00057 + 0.00002 * t)*t
        let dox = 0.590 + (0.2913 - 0.0844 * p) * p
        let dr = 0.664 + (0.2275 - 0.0938 * p) * p
        let cp = sol * pCO2 * (1 + pow(10, pH - pk))
        let cc = (dox + (dr - dox) * (1 - sat)) * cp
        let co2Content = (cc * (Hct) + (1 - (Hct)) * cp) * 2.22
        //co2Content = (co2Content < 0.001) ? 0.001 : co2Content
        return(o2Content, co2Content, sat)
    }
}
