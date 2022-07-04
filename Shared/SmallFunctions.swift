//
//  SmallFunctions.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/25/22.
//

import Foundation

extension Human {
    
    func calculatePh(_ bicarbonate:Double, CO2:Double) -> Double {
        return (6.1 + log10((bicarbonate)/(CO2 * 0.03)))
        
        // FORTRAN CODE: PHFNC(X,Y)=6.1+ALOG(X/(.03*Y))*.434294482
    }
    
    func dampChange(_ newValue:Double, oldValue:Double, dampConstant:Double) -> Double {
        return (newValue * dampConstant + oldValue)/(dampConstant + 1)
    }
    

}
