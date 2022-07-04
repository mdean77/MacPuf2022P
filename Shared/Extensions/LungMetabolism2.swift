//
//  LungMetabolism2.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 7/2/22.
//

import Foundation

extension Human {
    
    mutating func lungMetabolism2(){
        //740
        PC=FTCO*c14*PC
       // print("AVENT in lung metabolism line 740 = \(AVENT).")
        X=AVENT*c12
       // print("In lung metabolism line 740 X = \(X).")
        U=X*FIO2
      //  print("In lung metabolism line 740 U = \(U).")
        V=X*FIC2
        AO2MT=AO2MT+U
        AC2MT=AC2MT+V
        Z=100.0-FIO2-FIC2
        AN2MT=AN2MT+X*Z
        W=AO2MT+AC2MT+AN2MT
        X=c11/W
        AO2PR=AO2MT*X
        AC2PR=AC2MT*X
        AO2MT=AO2MT+PC*(VO2CT-PO2CT)
        AC2MT=AC2MT+PC*(VC2CT-PC2CT)
        AN2MT=AN2MT+PC*(TN2PR*0.00127-EN2CT)
        PC=AO2MT+AC2MT+AN2MT
        
        // Just before line 750 and complex logic
        // PL is normally zero and will be that value
        // until I add Bag related options.  So we will ignore PL conditional
        // testing just to get this working.
        // MARK: WHEN I ADD BAG EXPERIMENTS I MUST FIX THIS CODE
        if AVENT < 20 {
            FY = 0
        } else {
            FY = (PC-W)*c34/RRATE
        }
        // 800
        let XVENT=PC*c35-VLUNG
        if XVENT >= 0 {
            // 810
            X=XVENT*c25
            DVENT=X/PC
            X=X/c11
            Y=X*AO2PR
            Z=X*AC2PR
            PC=X*(c11-AO2PR-AC2PR)
            QA=U-Y
            QB=Z-V
            if AVENT > E {
                //840
                AO2MT=AO2MT-Y
                AC2MT=AC2MT-Z
                AN2MT=AN2MT-PC
            } else {
                // NEED TO ADD CODE HERE
                // TO COVER IF AVENT IS NOT GREATER THAN E
                QA = 0.001
                QB = E
                AO2MT=AO2MT-Y
                AC2MT=AC2MT-Z
                AN2MT=AN2MT-PC
            }
        } else { // XVENT less than zero
            let FD=XVENT*c12
            AO2MT=AO2MT-FD*FIO2
            AC2MT=AC2MT-FD*FIC2
            AN2MT=AN2MT-FD*Z
        }
        //850
        U=c11/(AO2MT+AN2MT+AC2MT)
        V = c37/RRATE
        if V > 4 {
            V = 4
        }
        if AVENT < 20 {
            V = 0
        }
        X=(TIDVL+100.0)*c38
        Y=AO2MT*U
        Z=AC2MT*U
        //AO2PR=DAMP((Y+(PO2-Y)*V),AO2PR,X)
        AO2PR = dampChange(Y+(AO2PR-Y)*V, oldValue: AO2PR, dampConstant: X)
        //AC2PR=DAMP((Z+(PC2-Z)*V),AC2PR,X)
        AC2PR = dampChange(Z+(AC2PR-Z)*V, oldValue: AC2PR, dampConstant: X)
        if AO2PR < 0 || AC2PR < 0 {
            print("We have negative pressures in the lungs, patient dead.")
        }
        PC = QB/QA
        X = VC3MT*c1+c3*(AC2PR - 40.0)
        Y = calculatePh(X, CO2: AC2PR)
        (PO2CT, PC2CT, SAT) = calculateContents(pO2: AO2PR, pCO2: AC2PR, pH: TPH, temperature: TEMP, DPG: DPG, Hct: PCV/100, Hgb: HB)
        
    }
}
