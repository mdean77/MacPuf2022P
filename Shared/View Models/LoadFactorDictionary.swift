//
//  LoadFactorDictionary.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 7/9/22.
//

import Foundation

extension Simulator {
    
    func loadFactorDictionary(){
        factors[1] = Factor(title: "Inspired O2 (%)",reference: 20.93, current: human.FIO2,format: "%.2f", lower:0, upper:100)
        factors[2] = Factor(title: "Inspired CO2 (%)", reference: 0.03, current: human.FIC2,format: "%.2f", lower:0, upper:100)
        factors[3] = Factor(title: "Cardiac pump performance (% normal)", reference: 100, current: human.CO,format: "%.0f", lower:0, upper:16000)
        factors[4] = Factor(title: "Metabolic rate, % normal",reference: 100, current: human.PD,format: "%.0f", lower:0, upper:16000)
        factors[5] = Factor(title: "Extra R-->L shunt, % cardiac output", reference: 0.0, current: human.FADM,format: "%.0f", lower:0, upper:90)
        factors[6] = Factor(title: "Extra dead space above normal, ml", reference: 0, current: human.BULLA,format: "%.0f", lower:-200, upper:16000)
        factors[7] = Factor(title: "Lung volume (end expiratory), ml",reference: 3000, current: human.VLUNG,format: "%.0f", lower:0, upper:16000)
        factors[8] = Factor(title: "Lung elastance, cm H20/liter", reference: 5, current: human.ELAST,format: "%.1f", lower:1, upper:90)
        factors[9] = Factor(title: "Venous admixture effect, %cardiac output", reference: 3, current: human.VADM,format: "%.0f", lower:0, upper:90)
        factors[10] = Factor(title: "Vent response to CO2 or H+, % normal",reference: 100, current: human.AZ,format: "%.0f", lower:0, upper:16000)
        factors[11] = Factor(title: "Vent response to hypoxia, % normal", reference: 100, current: human.BZ,format: "%.0f", lower:0, upper:16000)
        factors[12] = Factor(title: "Central neurogenic vent drive, % normal", reference: 100, current: human.CZ,format: "%.0f", lower:0, upper:16000)
        factors[13] = Factor(title: "Total barometric pressure, mm Hg",reference: 760, current: human.BARPR,format: "%.0f", lower:0, upper:16000)
        factors[14] = Factor(title: "Body temperature, degrees Centigrade", reference: 37, current: human.TEMP,format: "%.1f", lower:25, upper:44)
        factors[15] = Factor(title: "Tissue respiratory quotient (RQ)", reference: 0.8, current: human.TRQ,format: "%.2f", lower:0, upper:15)
        factors[16] = Factor(title: "Tissue CO2 stores, liters STPD",reference: 13.38, current: human.TC2MT,format: "%.2f", lower:5, upper:50)
        factors[17] = Factor(title: "Tissue ECF distribution volume, liters", reference: 12, current: human.TVOL,format: "%.1f", lower:5, upper:50)
        factors[18] = Factor(title: "Haemoglobin, g/100 ml blood", reference: 14.8, current: human.HB,format: "%.1f", lower:0, upper:25)
        factors[19] = Factor(title: "Hematocrit (packed cell volume) (%)",reference: 45, current: human.PCV,format: "%.1f", lower:0, upper:80)
        factors[20] = Factor(title: "Venous blood volume, ml", reference: 3000, current: human.VBLVL,format: "%.0f", lower:500, upper:10000)
        factors[21] = Factor(title: "Added bicarbonate(+) or acid(-), mmol", reference: 0, current: human.ADDC3,format: "%.1f", lower:-300, upper:300)
        factors[22] = Factor(title: "Brain bicarb (+/-) from normal, mmol/l", reference: 0, current: human.BC3AJ,format: "%.3f", lower:-15, upper:20)
        factors[23] = Factor(title: "2,3 DPG concentration in RBC, mmol/l",reference: 3.7843, current: human.DPG,format: "%.3f", lower:1, upper:15)
        factors[24] = Factor(title: "Breathing capacity, % normal", reference: 100, current: human.PR,format: "%.0f", lower:0, upper:16)
        factors[25] = Factor(title: "Index of state of fitness", reference: 33, current: human.FITNS,format: "%.0f", lower:27, upper:43)
        factors[26] = Factor(title: "Inspiratory time / total breath time",reference: 0.4, current: human.SPACE,format: "%.2f", lower:0, upper:1)
        factors[27] = Factor(title: "Maximum cardiac output, liters/min", reference: 35, current: human.COMAX,format: "%.0f", lower:0, upper:50)
        factors[28] = Factor(title: "Extra L-->R shunt, % cardiac output", reference: 0, current: human.SHUNT,format: "%.0f", lower:0, upper:5)
        factors[29] = Factor(title: "Vital capacity, liters BTPS",reference: 5, current: human.VC,format: "%.1f", lower:0, upper:10)
        factors[30] = Factor(title: "Positive end-expiratory pressure, cm H2O", reference: 0.0, current: human.PEEP,format: "%.0f", lower:0, upper:50)

    }
    
}
