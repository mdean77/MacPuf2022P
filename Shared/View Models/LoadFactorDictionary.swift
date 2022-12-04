//
//  LoadFactorDictionary.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 7/9/22.
//

import Foundation

extension Simulator {
    
    func loadFactorDictionary(){
        factors[1] = Factor(title: "Inspired O2 (%)",reference: 20.93, current: human.FIO2,format: "%.2f", lower:0, upper:100
                            , information: """
                            Decrease to simulate anoxic conditions and increase to administer supplemental \
                            oxygen, as perhaps in a clinical setting.  Setting this value to 8% will rapidly drop \
                            the pO2 from around 94 to 26, the respiratory rate will increase, and lactic acid will begin \
                            to accumulate.
                            """)
        factors[2] = Factor(title: "Inspired CO2 (%)", reference: 0.03, current: human.FIC2,format: "%.2f", lower:0, upper:100
                            , information: """
                            Increase to simulate rebreathing or situations where CO2 accumulates in the inspired gas. \
                            Setting this to 5% will result in an elevated pCO2, significantly increase respiratory rate \
                            and total ventilation, increased cerebral blood flow, and higher pO2 because of the increased ventilation.
                            """)
        factors[3] = Factor(title: "Cardiac pump performance (% normal)", reference: 100, current: human.CO,format: "%.0f", lower:0, upper:16000
                            , information: """
                            This is percentage of whatever would be normal;  decrease to simulate cardiac failure or even cardiac arrest. \
                            Increase to indicate better performance.  You may want to combine increasing this value with other parameters \
                            of exercise fitness or with conditions that increase metabolic rate.
                            """)
        factors[4] = Factor(title: "Metabolic rate, % normal",reference: 100, current: human.PD,format: "%.0f", lower:0, upper:16000
                            , information: """
                            "Increase to simulate exercise, for example, and decrease to simulate clinical interventions such as \
                            anesthesia, barbiturate coma, etc.
                            """)
        factors[5] = Factor(title: "Extra R-->L shunt, % cardiac output", reference: 0.0, current: human.FADM,format: "%.0f", lower:0, upper:90
                            , information: """
                            Fixed shunt, such as occurs with cyanotic congenital heart conditions.
                            """)
        factors[6] = Factor(title: "Extra dead space above normal, ml", reference: 0, current: human.BULLA,format: "%.0f", lower:-200, upper:1000
                            , information: "Adjust this parameter as desired to change extra dead space.  Particularly useful when combined with artificial ventilation.")
        factors[7] = Factor(title: "Lung volume (end expiratory), ml",reference: 3000, current: human.VLUNG,format: "%.0f", lower:0, upper:6000
                            , information: "Information")
        factors[8] = Factor(title: "Lung elastance, cm H20/liter", reference: 5, current: human.ELAST,format: "%.1f", lower:1, upper:90
                            , information: "Information")
        factors[9] = Factor(title: "Venous admixture effect, %cardiac output", reference: 3, current: human.VADM,format: "%.0f", lower:0, upper:90
                            , information: "Information")
        factors[10] = Factor(title: "Vent response to CO2 or H+, % normal",reference: 100, current: human.AZ,format: "%.0f", lower:0, upper:500
                             , information: "Information")
        factors[11] = Factor(title: "Vent response to hypoxia, % normal", reference: 100, current: human.BZ,format: "%.0f", lower:0, upper:500
                             , information: "Information")
        factors[12] = Factor(title: "Central neurogenic vent drive, % normal", reference: 100, current: human.CZ,format: "%.0f", lower:0, upper:500
                             , information: "Information")
        factors[13] = Factor(title: "Total barometric pressure, mm Hg",reference: 760, current: human.BARPR,format: "%.0f", lower:0, upper:3500
                             , information: "Information")
        factors[14] = Factor(title: "Body temperature, degrees Centigrade", reference: 37, current: human.TEMP,format: "%.1f", lower:25, upper:44
                             , information: "Information")
        factors[15] = Factor(title: "Tissue respiratory quotient (RQ)", reference: 0.8, current: human.TRQ,format: "%.2f", lower:0, upper:15
                             , information: "Information")
        factors[16] = Factor(title: "Tissue CO2 stores, liters STPD",reference: 13.38, current: human.TC2MT,format: "%.2f", lower:5, upper:50
                             , information: "Information")
        factors[17] = Factor(title: "Tissue ECF distribution volume, liters", reference: 12, current: human.TVOL,format: "%.1f", lower:5, upper:50
                             , information: "Information")
        factors[18] = Factor(title: "Haemoglobin, g/100 ml blood", reference: 14.8, current: human.HB,format: "%.1f", lower:0, upper:25
                             , information: "Information")
        factors[19] = Factor(title: "Hematocrit (packed cell volume) (%)",reference: 45, current: human.PCV,format: "%.1f", lower:0, upper:80
                             , information: "Information")
        factors[20] = Factor(title: "Venous blood volume, ml", reference: 3000, current: human.VBLVL,format: "%.0f", lower:500, upper:10000
                             , information: "Information")
        factors[21] = Factor(title: "Added bicarbonate(+) or acid(-), mmol", reference: 0, current: human.ADDC3,format: "%.1f", lower:-300, upper:300
                             , information: "Information")
        factors[22] = Factor(title: "Brain bicarb (+/-) from normal, mmol/l", reference: 0, current: human.BC3AJ,format: "%.3f", lower:-15, upper:20
                             , information: "Information")
        factors[23] = Factor(title: "2,3 DPG concentration in RBC, mmol/l",reference: 3.7843, current: human.DPG,format: "%.3f", lower:1, upper:15
                             , information: "Information")
        factors[24] = Factor(title: "Breathing capacity, % normal", reference: 100, current: human.PR,format: "%.0f", lower:0, upper:16
                             , information: "Information")
        factors[25] = Factor(title: "Index of state of fitness", reference: 33, current: human.FITNS,format: "%.0f", lower:27, upper:43
                             , information: "Information")
        factors[26] = Factor(title: "Inspiratory time / total breath time",reference: 0.4, current: human.SPACE,format: "%.2f", lower:0, upper:1
                             , information: "Information")
        factors[27] = Factor(title: "Maximum cardiac output, liters/min", reference: 35, current: human.COMAX,format: "%.0f", lower:0, upper:50
                             , information: "Information")
        factors[28] = Factor(title: "Extra L-->R shunt, % cardiac output", reference: 0, current: human.SHUNT,format: "%.0f", lower:0, upper:5
                             , information: "Information")
        factors[29] = Factor(title: "Vital capacity, liters BTPS",reference: 5, current: human.VC,format: "%.1f", lower:0, upper:10
                             , information: "Information")
        factors[30] = Factor(title: "Positive end-expiratory pressure, cm H2O", reference: 0.0, current: human.PEEP,format: "%.0f", lower:0, upper:50
                             , information: "Information")

    }
    
}
