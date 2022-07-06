//
//  CalculatePressures4.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 7/4/22.
//

import Foundation
/// CALL GSINV (RO2PR,RC2PR,RO2CT,RC2CT,RPH,SAT)
extension Human {
    /// CALL GSINV (RO2PR,RC2PR,RO2CT,RC2CT,RPH,SAT)
    ///         // 100 CALL GASES(PO2,PC2,X,Y,PH,SAT)
    /// (X, Y,  _ ) = calculateContents(pO2: po2, pCO2: pc2, pH: RPH, temperature: TEMP, DPG: DPG, Hct: PCV/100, Hgb: HB)
    mutating func calculatePressures4(O2CT:Double, CO2CT:Double, pH:Double, temperature:Double = 37.0, DPG:Double = 3.7842, Hct:Double = 45.0,
                                      Hgb: Double = 14.8) -> (pO2:Double, pCO2:Double){
        
        // sign(f,g) = sgn(g) * abs(f)
        func sign(_ op1:Double, _ op2:Double) -> Double {
            return op2 < 0 ? -abs(op1) : abs(op1)
        }
        
        let err = 0.01
        var (ich1, ich2, ich3, ich4) = (1,1,1,1)
        var (D1Z, D2Z) = (2.0, 2.0)
        var (D1, D2, DS) = (0.0,0.0, 0.0)
        var (x,y) = (0.0,0.0)
        var (xx1,xx2,yy1,yy2,xp1,xp2,yp1,yp2) = (0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0)
        var convergeCount = 0
        var trial:(pO2:Double, pCO2:Double, contO2:Double, contCO2:Double) = (0.0,0.0,0.0,0.0)
        var pO2 = RO2PR  // holds current candidate value
        var pCO2 = RC2PR // holds current candidate value
        let oxygenContent = RO2CT         // Target values
        let carbonDioxideContent = RC2CT  // Target values
        var finished: Bool = false
        
        // start:                // FORTRAN line 100
        
        func start(){
            trial.pO2 = pO2
            trial.pCO2 = pCO2
            // trial = [self calcTrialContents:temperature:Hct:Hgb:DPG:trial];
            (trial.contO2, trial.contCO2,  _ ) = calculateContents(pO2: trial.pO2, pCO2:trial.pCO2, pH: RPH, temperature: TEMP, DPG: DPG, Hct: PCV/100, Hgb: HB)
            x = trial.contO2
            y = trial.contCO2
            xx2 = x - oxygenContent
            if (xx2 == 0) {xx2 = 0.001}
            yy2 = y - carbonDioxideContent;
            if (yy2 == 0) {yy2 = 0.001}
            xp2 = pO2
            yp2 = pCO2
            
            if (ich3 == 1) {
                ich3 = 0
                D1 = sign(D1Z, -xx2)
            }
            
            if (ich4 == 1) {
                ich4 = 0
                D2 = sign(D2Z, -yy2)
            }
            // check for convergence
            if (abs(xx2) < err) {
                ich1 = 0
            }
            if (abs(yy2) < err) {
                ich2 = 0
            }
            if ((ich1 + ich2) == 0) {
                // return (pO2, pCO2)
                finished = true
            }
        }
        // I am assuming that I can just return because the object's pO2 and pCO2 have already been
        // directly changed in calcTrialContents.
        
        //    middle:
        func middle() {// FORTRAN line 210
            //     NSLog(@"Middle");
            DS = D1 * Double(ich1);        // clever way to suppress further changes if already converged
            x = pO2 + DS - pO2 * 0.25
            if (x<0) {
                DS = -pO2 * 0.75
            }
            pO2 = pO2 + DS       // new pO2 value to try.  This directly changes the object pO2.
            
            DS = D2 * Double(ich2);
            x = pCO2 + DS - pCO2 * 0.25
            if (x<0) {
                DS = -pCO2 * 0.75
            }
            pCO2 = pCO2 + DS        // new pCO2 value to try.  This directly changes the object pCO2.
            
            if (pO2 < 0.1) {
                pO2 = 0.1
            }
            if (pCO2 < 0.1) {
                pCO2 = 0.1
            }
            
            trial.pO2 = pO2
            trial.pCO2 = pCO2
            (trial.contO2, trial.contCO2,  _ ) = calculateContents(pO2: trial.pO2, pCO2:trial.pCO2, pH: RPH, temperature: TEMP, DPG: DPG, Hct: PCV/100, Hgb: HB)
            x = trial.contO2
            y = trial.contCO2
            
            xx1 = xx2
            xx2 = x - oxygenContent
            xp1 = xp2
            xp2 = pO2
            yy1 = yy2
            yy2 = y - carbonDioxideContent
            yp1 = yp2
            yp2 = pCO2
            
            // Check the oxygen content results for suitability
            ich1 = 0
            if (abs(xx2) > err) {
                ich1 = 1;      // Not done
                
                if ((xx2 * D1) > 0) {
                    ich3 = 1
                    pO2 = xp1 + (xp2 - xp1)*abs(xx1)/(abs(xx2)+abs(xx1))
                    D1Z = D1Z * 0.5
                }
                
                if ((xx2 * D1) < 0) {
                    D1 = (xp2 == xp1) ? sign(D1Z, -xx2) : (xp2 - xp1)*abs(xx2)/abs(xx2 - xx1)
                }
            }
            
            // Check the carbon dioxide content results for suitability
            ich2 = 0
            if (abs(yy2) > err) {
                ich2 = 1
                
                if ((yy2 * D2) > 0) {
                    ich4 = 1
                    pCO2 = yp1 + (yp2 - yp1)*abs(yy1)/(abs(yy2)+abs(yy1))
                    D2Z = D2Z * 0.5
                }
                
                if ((yy2 * D2) < 0) {
                    D2 = (yp2 == yp1) ? sign(D2Z, -yy2) : (yp2 - yp1)*abs(yy2)/abs(yy2 - yy1);
                }
            }
            if ((ich1 + ich2) == 0) {
                finished = true
            }
        }
        //after middle
        
        repeat{
            start()
            middle()
            if (ich3 + ich4 - 1) < 0 {
                middle()
            } else {
                convergeCount += 1
                start()
                middle()
            }
        } while !finished
        //print(convergeCount)
        return (pO2, pCO2)
        
    }
}



