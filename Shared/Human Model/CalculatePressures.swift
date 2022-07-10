//
//  CalculatePressures.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/25/22.
//

import Foundation

//struct GasValues {
//    var pO2:Double
//    var pCO2:Double
//    var contO2:Double
//    var contCO2:Double
//}

extension Human {
    mutating func calculatePressures(O2CT:Double, CO2CT:Double, pH:Double, temperature:Double = 37.0, DPG:Double = 3.7842, Hct:Double = 45.0,
                                     Hgb: Double = 14.8) -> (pO2:Double, pCO2:Double){
        
        // sign(f,g) = sgn(g) * abs(f)
        func sign(_ op1:Double,  op2:Double) -> Double {
            return op2 < 0 ? -abs(op1) : abs(op1)
        }
        
        let err = 0.01
        var (trialO2Content, trialCO2Content) = (0.0, 0.0)
        var (deltaOxygen1, deltaOxygen2, deltaCarbonDioxide1, deltaCarbonDioxide2) = (0.0,0.0,0.0,0.0)
        var (guessOxygen1, guessOxygen2, guessCarbonDioxide1, guessCarbonDioxide2) = (0.0,0.0,0.0,0.0)
        var pO2=0.0, pCO2=0.0
        
        
        // Flags to track status of iterators
        //    ICH3 is a flag that indicates a bracket is being pursued for pO2
        //    ICH1 is a flag that indicates if pO2 is adequately approximated (ICH1 = 0)
        //    ICH4 is a flag that indicates a bracket is being pursued for pCO2
        //    ICH2 is a flag that indicates if pCO2 is adequately approximated (ICH2 = 0)
        var (ich1, ich2, ich3, ich4) = (1,1,1,1)
        
        // Magnitudes of iterative change
        var (D1Z, D2Z, D1, D2, DS) = (2.0, 2.0, 0.0, 0.0, 0.0)
        var x = 0.0
        pO2 = RO2PR
        pCO2 = RC2PR
        repeat {
//            pO2 = RO2PR
//            pCO2 = RC2PR
            //        trial = calculateTrialContents(trialGases: trial)
            //            trialO2Content = trial.contO2
            //            trialCO2Content = trial.contCO2
            
            (trialO2Content, trialCO2Content,  SAT ) = calculateContents(pO2: pO2, pCO2: pCO2, pH: RPH, temperature: TEMP, DPG: DPG, Hct: PCV/100, Hgb: HB)
            
            // Calculate the delta, but must be non-zero or we will get division by zero error later
            deltaOxygen2 = (trialO2Content - RO2CT) == 0 ?  0.001 : trialO2Content - RO2CT
            
            deltaCarbonDioxide2 = (trialCO2Content - RC2CT) == 0 ? 0.001 : trialCO2Content - RC2CT
            
            guessOxygen2 = pO2
            guessCarbonDioxide2 = pCO2
            
            if (ich3 == 1) {
                ich3 = 0
                D1 = sign(D1Z, op2: -deltaOxygen2)
            }
            
            if (ich4 == 1) {
                ich4 = 0
                D2 = sign(D2Z, op2: -deltaCarbonDioxide2)
            }
            // check for convergence
            if (abs(deltaOxygen2) < err) {
                ich1 = 0
            }
            if (abs(deltaCarbonDioxide2) < err) {
                ich2 = 0
            }
            if ((ich1 + ich2) == 0) {
                return (pO2, pCO2)
            }
            
            DS = D1 * Double(ich1)        // clever way to suppress further changes if already converged
            x = pO2 + DS - pO2 * 0.25;
            if (x<0) {
                DS = -pO2 * 0.75;
            }
            pO2 = pO2 + DS;        // new pO2 value to try.  This directly changes the object pO2.
            
            DS = D2 * Double(ich2)
            x = pCO2 + DS - pCO2 * 0.25;
            if (x<0) {
                DS = -pCO2 * 0.75;
            }
            pCO2 = pCO2 + DS;        // new pCO2 value to try.  This directly changes the object pCO2.
            
            if (pO2 < 0.1) {
                pO2 = 0.1;
            }
            if (pCO2 < 0.1) {
                pCO2 = 0.1;
            }
            
            //            trial.pO2 = pO2
            //            trial.pCO2 = pCO2
            //            trial = calculateTrialContents(trialGases: trial)
            //            trialO2Content = trial.contO2
            //            trialCO2Content = trial.contCO2
            (trialO2Content, trialCO2Content,  SAT ) = calculateContents(pO2: pO2, pCO2: pCO2, pH: RPH, temperature: TEMP, DPG: DPG, Hct: PCV/100, Hgb: HB)
            // Calculate the delta, but must be non-zero or we will get division by zero error later
            deltaOxygen1 = deltaOxygen2
            deltaOxygen2 = (trialO2Content - RO2CT) == 0 ?  0.001 : trialO2Content - RO2CT
            
            deltaCarbonDioxide1 = deltaCarbonDioxide2
            deltaCarbonDioxide2 = (trialCO2Content - RC2CT) == 0 ? 0.001 : trialCO2Content - RC2CT
            
            guessOxygen1 = guessOxygen2
            guessOxygen2 = pO2
            guessCarbonDioxide1 = guessCarbonDioxide2
            guessCarbonDioxide2 = pCO2
            
            // Check the oxygen content results for suitability
            ich1 = 0;
            if (abs(deltaOxygen2) > err) {
                ich1 = 1;        // Not done
                
                if ((deltaOxygen2 * D1) > 0) {
                    ich3 = 1;
                    pO2 = guessOxygen1 + (guessOxygen2 - guessOxygen1)*abs(deltaOxygen1)/(abs(deltaOxygen2)+abs(deltaOxygen1));
                    D1Z = D1Z * 0.5;
                }
                
                if ((deltaOxygen2 * D1) < 0) {
                    D1 = (guessOxygen2 == guessOxygen1) ? sign(D1Z, op2: -deltaOxygen2) : (guessOxygen2 - guessOxygen1)*abs(deltaOxygen2)/abs(deltaOxygen2 - deltaOxygen1);
                }
            }
            
            // Check the carbon dioxide content results for suitability
            ich2 = 0;
            if (abs(deltaCarbonDioxide2) > err) {
                ich2 = 1;
                
                if ((deltaCarbonDioxide2 * D2) > 0) {
                    ich4 = 1;
                    pCO2 = guessCarbonDioxide1 + (guessCarbonDioxide2 - guessCarbonDioxide1)*abs(deltaCarbonDioxide1)/(abs(deltaCarbonDioxide2)+abs(deltaCarbonDioxide1));
                    D2Z = D2Z * 0.5;
                }
                
                if ((deltaCarbonDioxide2 * D2) < 0) {
                    D2 = (guessCarbonDioxide2 == guessCarbonDioxide1) ? sign(D2Z, op2: -deltaCarbonDioxide2) : (guessCarbonDioxide2 - guessCarbonDioxide1)*abs(deltaCarbonDioxide2)/abs(deltaCarbonDioxide2 - deltaCarbonDioxide1);
                }
            }
        } while (ich1 + ich2) != 0
        return (pO2, pCO2)
    }
}
