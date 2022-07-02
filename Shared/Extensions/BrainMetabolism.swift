//
//  BrainMetabolism.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/30/22.
//

import Foundation

extension Human {
    
    mutating func brainMetabolism(){
        //        C NEXT DETERMINES CEREBRAL BLOOD FLOW ADJUSTMENTS IN
        //        C RELATION TO CARDIAC OUTPUT AND BRAIN PH(PCO2 SENSITIVE)
         Z=sqrt(COADJ)*0.5
        if Z <= 1 {Z = 1}
        //              if(Z-1.) 970,970,960
        //          960 Z=1.
        Y=(7.4-BPH)*(BC2PR*0.0184-BC3AJ*0.1)
        //              if(Y) 990,990,980
        //          980 Y=300.*Y**2
        if Y > 0 {Y = 300.0*pow(Y,2)}
        //          990 if(Y-4.4) 1010,1010,1000
        //         1000 Y=4.4
        if Y > 4.4 {Y = 4.4}
        //1010 CBF=DAMP((Y-.12)*42.5*Z,CBF*Z,C55)
        CBF = dampChange((Y - 0.12)*42.5*Z, oldValue: CBF*Z, dampConstant: c55)
        //        C COMP.BRAIN GAS AMTS.BY METAB.ASSUMING RQ OF .98 AND
        //        C ALLOWING FOR DIFFERENT AMTS.SUPPLIED IN ART.BLOOD AND
        //        C LEAVING IN VENOUS BLOOD. CHECK FOR ARITH.ERRORS
        //        C THEN CALC. BRAIN GAS TENSIONS FROM GUESTIMATED DISSOC. CURVES
        Y=CBF*c39
        X=c41*(BO2AD+0.25)
        Z=X
        //              if(BO2PR-18.) 1020,1020,1040
        //         1020 Z=X*(BO2PR*.11-1.)
        //              X=X*(19.-BO2PR)
        if BO2PR <= 18 {
            Z=X*(BO2PR*0.11-1.0)
            X=X*(19.0-BO2PR)
            if Z < 0 {Z = 0}
        }
        //              if(Z) 1030,1040,1040
        //         1030 Z=0.
          BO2MT=BO2MT+Y*(RO2CT-BO2CT)-2.0*Z*(BO2AD+0.1)
        if BO2MT <= 0 {BO2MT = 0.1}

          BC2MT=BC2MT+Y*(RC2CT-BC2CT)+2.15*X
              BO2PR=BO2MT*1.6
              BC2PR=BC2MT*0.078
               W=BC2PR-40.0
              Y=BC3CT+BC3AJ+0.2*W
//        C A SMALL PROPORTION OF ADDED BICARBONATE IS ADDED ALSO
//        C TO CSF, THUS AFFECTING BREATHING APPROPRIATELY
              BC3AJ=BC3AJ+((RC3CT-24.0)*0.3-BC3AJ)*c42
//        C ADJ.BICARB.TO PCO2 THEN CALC.'BRAIN PH'IE.PH AT
//        C RECEPTOR. THEN PROCEED TO DETERMINE CONTENTS OF O2
//        C AND CO2 IN BLOOD LEAVING BRAIN
              //X=PHFNC(2.*Y+RC3CT,2.*BC2PR+RC2PR)
        X = calculatePh(2.0*Y+RC3CT, CO2: 2.0*BC2PR+RC2PR)
              //Z=((ABS(X-BPH)+E)*100.)**2+.04
        Z = pow((abs(X - BPH) + E)*100,2)+0.04
        if Z > c17 {Z = c17}
//              if(Z-C17) 1080,1080,1070
//         1070 Z=C17
//        C RESTRICT RATE OF CHANGE OF BRAIN RECEPTOR PH
//                BPH=DAMP(X,BPH,Z)
        BPH = dampChange(X, oldValue: BPH, dampConstant: Z)
//              Z=PHFNC(VC3MT*C1+(BC2PR-40.)*C3,BC2PR)
        Z = calculatePh(VC3MT*c1+(BC2PR-40)*c3, CO2: BC2PR)
        //              CALL GASES (BO2PR,BC2PR,BO2CT,BC2CT,Z,SAT)
        (BO2CT, BC2CT, SAT) = calculateContents(pO2: BO2PR, pCO2: BC2PR, pH: Z, temperature: TEMP, DPG: DPG, Hct: PCV/100, Hgb: HB)
        //        C NOW FOLLOW VENTILATION CALCULATIONS, STARTING WITH
        //        C NARTI=0 WHICH IS ARTIFICIAL VENT.  COMPUTE TOTAL DEAD
        //        C SPACE, ANAT + PHYSIOL., THEN ALV.VENT.(AVENT)
        // if(NARTI) 1090,1090,1100
        if NARTI == 0 { DVENT = c51}  // artificial ventilation
        //        C NAT.VENT.CONTROLS. TOTL.VENT(U AND SVENT)=SUM OF CENTRAL CO2(PH)
        //        C CHEMORECEPTOR DRIVE(SLOPE X,INTERCEPT Z)  O2 LACK
        //        C RECEPTOR(SLOPE Y)  CENTRAL NEUROGENIC DRIVE(PROPNL. TO
        //        C O2 CONSUMPTION C7, + CONSTANT ETC.). AZ ETC. ARE
        //        C FOR MANUAL ADJUSTMENTS OF VENTILATORY CONTROLS
        Y=(118.0-PJ)*0.05
        Z=Y*0.002
        X=(c65+Z-BPH)*1000.0*Y
        if X < 0 {X = 0}
        W=(c66+Z-BPH)*150.0*Y
        //        C HIGH BRAIN PH OR LOW PCO2 ONLY INHIBITS VENT.ifLEARNT
        //        C INTRINSIC DRIVE (CZ) IS REDUCED OR ABSENT
        //              if(W) 1130,1150,1150
        //         1130 if(C67) 1150,1150,1140
        //         1140 W=0.
        if W < 0 {
            if c67 > 0 {
                W = 0
            }
        }
        //1150
        Z=(BC2PR-120.0)*0.25
        if Z < 0 {Z = 0}

             Y=(98.0-PJ)*(RC2PR-25.0)*0.12
        if Y < 0 {Y = 0}
//            if(Y) 1180,1190,1190
//            1180 Y=0.
            //        C BO2AD IS INDEX OF BRAIN OXYGENATION ADEQUACY
            //        C AND LOWERS AND EVENTUALLY STOPS BREATHING ifTOO LOW
            //        C-------- CHANGE IN BRAIN HYPOXIA THRESHOLD DESIGNATION
            //1190
        U=BO2MT-10.0
        U = U < 0 ? 0 : 1
//            if(U) 1210,1200,1200
//            1200 U=1.
//            GO TO 1220
//            1210 U=0.
            //1220 BO2AD=DAMP(U,BO2AD,C63)
        BO2AD = dampChange(U, oldValue: BO2AD, dampConstant: c63)
    }
}
