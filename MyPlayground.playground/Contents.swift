import Foundation
func calculateContents(pO2:Double, pCO2:Double, pH:Double,
                       temperature:Double = 37.0, DPG:Double = 3.7843,
                       Hct:Double = 45.0, Hgb:Double = 14.8)
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
    var o2Content = Hgb * sat * 1.34 + 0.003 * pO2
    o2Content = (o2Content < 0.001) ? 0.001 : o2Content
    let p = 7.4 - pH
    let pk = 6.086 + p * 0.042 + (38.0 - temperature) * (0.00472 + 0.00139 * p)
    let sol = 0.0307 + (0.00057 + 0.00002 * (37.0 - temperature)) * (37.0 - temperature)
    let dox = 0.590 + (0.2913 - 0.0844 * p) * p
    let dr = 0.664 + (0.2275 - 0.0938 * p) * p
    let cp = sol * pCO2 * (1 + pow(10, pH - pk))
    let cc = (dox + (dr - dox) * (1 - sat)) * cp
    var co2Content = (cc * (Hct * 0.01) + (1 - (Hct * 0.01)) * cp) * 2.22
    co2Content = (co2Content < 0.001) ? 0.001 : co2Content
    return(o2Content, co2Content, sat)

}

calculateContents(pO2: 99, pCO2: 52.79, pH: 7.34, temperature: 37, DPG: 3.8, Hct: 0.45, Hgb: 14.8)
calculateContents(pO2: 90, pCO2: 52.79, pH: 7.33, temperature: 37, DPG: 3.8, Hct: 0.45, Hgb: 14.8)
calculateContents(pO2: 75, pCO2: 52.79, pH: 7.32, temperature: 37, DPG: 3.8, Hct: 0.45, Hgb: 14.8)
calculateContents(pO2: 60, pCO2: 52.79, pH: 7.31, temperature: 37, DPG: 3.8, Hct: 0.45, Hgb: 14.8)
calculateContents(pO2: 45, pCO2: 52.79, pH: 7.30, temperature: 37, DPG: 3.8, Hct: 0.45, Hgb: 14.8)
calculateContents(pO2: 30, pCO2: 52.79, pH: 7.29, temperature: 37, DPG: 3.8, Hct: 0.45, Hgb: 14.8)


//struct MacPuf  {
//    var pH = 7.40
//    var po2 = 90.0
//    var pco2 = 40.0
//    var o2Content = 0.0
//    var co2Content = 0.0
//
//    mutating func simulate(){
//        o2Content = calculateContents(pO2: po2, pCO2: pco2, pH: pH).oxygenContent
//        co2Content = calculateContents(pO2: po2, pCO2: pco2, pH: pH).carbonDioxideContent
//    }
//
//}
//
//var puf = MacPuf()
//puf.simulate()

