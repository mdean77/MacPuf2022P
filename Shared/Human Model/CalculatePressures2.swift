//
//  CalculatePressures2.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 7/3/22.
//

import Foundation

/// CALL GSINV (RO2PR,RC2PR,RO2CT,RC2CT,RPH,SAT)
extension Human {
    mutating func calculatePressures2(O2CT:Double, CO2CT:Double, pH:Double, temperature:Double = 37.0, DPG:Double = 3.7842, Hct:Double = 45.0,
                                      Hgb: Double = 14.8) -> (pO2:Double, pCO2:Double){
        
        // sign(f,g) = sgn(g) * abs(f)
        func sign(_ op1:Double, _ op2:Double) -> Double {
            return op2 < 0 ? -abs(op1) : abs(op1)
        }
        
        let err = 0.01
        var (ICH1, ICH2, ICH3, ICH4) = (1,1,1,1)
        var (D1Z, D2Z) = (2.0, 2.0)
        var (D1, D2, DS) = (0.0,0.0, 0.0)
        var (X,Y) = (0.0,0.0)
        
        var po2 = RO2PR
        var pc2 = RC2PR
        
    outerLoop: while ICH1 + ICH2 != 0 {
        // 100 CALL GASES(PO2,PC2,X,Y,PH,SAT)
        (X, Y,  _ ) = calculateContents(pO2: po2, pCO2: pc2, pH: RPH, temperature: TEMP, DPG: DPG, Hct: PCV/100, Hgb: HB)
        
        var XX2 = X - RO2CT
        print("RO2CT = \(RO2CT)  RO2PR = \(RO2PR)  Returned content \(X)")
        var YY2 = Y - RC2CT
        print("RC2CT = \(RC2CT)  RC2PR = \(RC2PR)  Returned content \(Y)")
        if XX2 == 0 {XX2 = 0.001}
        if YY2 == 0 {YY2 = 0.001}
        
        var XP2 = po2
        var YP2 = pc2
        
        if ICH3 == 1 {
            ICH3 = 0
            D1 = sign(D1Z, -XX2)
        }
        if ICH4 == 1 {
            ICH4 = 0
            D2 = sign(D2Z, -YY2)
        }
        
        if abs(XX2) < err {
            ICH1 = 0  // Oxygen is adequately estimated
        }
        
        if abs(YY2) < err {
            ICH2 = 0 // CO2 is adequately estimated
        }
        
        if ICH1 + ICH2 == 0 {
            print("Returned from initial estimates")
            return (po2, pc2)
        }
        
    innerLoop: while  ICH3 + ICH4 < 1 {  // LINE 210
        DS=D1*Double(ICH1)
        X=po2+DS-po2 * 0.25
        if X < 0 {
            DS = -po2 * 0.75
        }
        po2 = po2 + DS
        
        DS=D2*Double(ICH2)
        X=pc2+DS-pc2*0.25
        if X < 0 {
            DS = -pc2 * 0.75
        }
        pc2 = pc2 + DS
        
        if po2 < 0.1 { po2 = 0.1}
        if pc2 < 0.1 { pc2 = 0.1}
        
        // 290 CALL GASES(PO2,PC2,X,Y,PH,SAT)
        (X, Y,  _ ) = calculateContents(pO2: po2, pCO2: pc2, pH: RPH, temperature: TEMP, DPG: DPG, Hct: PCV/100, Hgb: HB)
        
        let XX1 = XX2
        XX2 = X - RO2CT
        let XP1 = XP2
        XP2 = po2
        let YY1=YY2
        YY2 = Y - RC2CT
        let YP1 = YP2
        YP2 = pc2
        
        // check O2 discrepancy
        if abs(XX2) < err {
            ICH1 = 0  // Oxygen is adequately estimated
        } else {
            if XX2*D1 < 0 {
                if XP2 == XP1 {
                    D1=sign(D1Z,-XX2)
                } else {
                    D1=(XP2-XP1)*abs(XX2)/(abs(XX2-XX1))
                }
            }  else if XX2*D1 > 0 {
                ICH3=1
                po2=XP1+(XP2-XP1)*abs(XX1)/(abs(XX2)+abs(XX1))
                D1Z=D1Z/2.0
            }
        }
        // SHOULD BE LINE 360
        // check CO2 discrepancy
        if abs(YY2) < err {
            ICH2 = 0  // Oxygen is adequately estimated
        } else {
            if YY2*D2 < 0 {
                if YP2 == YP1 {
                    D2=sign(D2Z,-YY2)
                } else {
                    D2=(YP2-YP1)*abs(YY2)/(abs(YY2-YY1))
                }
            }  else if YY2*D2 > 0 {
                ICH4=1
                pc2=YP1+(YP2-YP1)*abs(YY1)/(abs(YY2)+abs(YY1))
                D2Z=D2Z/2.0
            }
        }
        if ICH1 + ICH2 == 0 {
            print("Returned from inner loop")
                  return(po2, pc2)}
        
    }  // inner loop ending
    }  // outer loop ending
        print("Reached the return from outer loop")
        return(po2, pc2)
    }
}


