//
//  CalculatePh.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/25/22.
//

import Foundation

func calculatePh(_ bicarbonate:Double, CO2:Double) -> Double {
    return (6.1 + log10((bicarbonate)/(CO2 * 0.03)))
}
