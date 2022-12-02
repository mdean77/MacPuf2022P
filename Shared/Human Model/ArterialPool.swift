//
//  ArterialPool.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/30/22.
//

import Foundation

extension Human{
    mutating func arterialPool(){

        //var results:(pO2: Double, pCO2:Double)
        //        C O2 CONT.O PRESS. INFLUENCES VEN. ADMIXTURE AND (V.SLOWLY) 2,3-DPG
        //        C-------- C71-72 NEW PARAMETERS, AMENDING RATE OF CHANGE OF 2,3-DPG
        DPG=DPG+(c71-RO2CT-DPG)*c72
        //        C........
         X=AO2PR
        if X < 200 {X = 200}
        //              if(X-200.) 300,300,290
        //          290 X=200.
        //        C INCREASE EFF.VEN.ADM.ifALV.PO2 VERY HIGH
         Y=AO2PR
        if Y > 600  {Y = 600}
        //              if(Y-600.) 320,320,310
        //          310 Y=600.
        if AO2PR > 400 { X=X-(Y-400.0)*0.3 }
        //          320 if(AO2PR-400.) 340,340,330
        //          330 X=X-(Y-400.)*.3
        if X < 55 {X=55}
        //          340 if(X-55.) 350,350,360
        //          350 X=55.
        //        C PW=EFFECTIVE VENOUS ADMIXTURE, AFFECTED BY PEEP, ALV.PO2, ETC
        //        C AND ALSO INCORPORATING A FIXED SHUNT COMPONENT, FADM
        //          360 PW=(C18/X+C19)*C21+FADM
        
        PW=(c18/X+c19)*c21+FADM
        //        C LIMIT RIDICULOUS ADMIXTURES EXCEEDING 100
        if PW > 100 {PW = 100}
        //              if(PW-100.) 380,380,370
        //          370 PW=100.
        X = PW / 100
        PC = 1 - X
        //          380 X=PW*.01
        //              PC=1.-X
        //
        RN2MT=RN2MT+FTCO*((X*TN2PR+PC*(c11-AO2PR-AC2PR))*0.00127-EN2CT)
         U=X*VC2CT+PC*PC2CT
         V=X*VO2CT+PC*PO2CT
        RC2MT=RC2MT+FTCO*(U-EC2CT)
        RO2MT=RO2MT+FTCO*(V-EO2CT)
        //        C CONTENTS PASSING TO TISSUES AFFECTED BY RATES OF BLOOD FLOW
         W=c22/COADJ
        //        C ifHEART STOPPED PREVENT CHANGES IN ART.BLOOD COMPOSITION
        // Interesting trick = if heart stopped then this is nearly diviison by zero and makes
        // W very large and then it gets set to zero to kill the damp function.
        if W > 100 {W = 0}
        //              if(W-100.) 400,400,390
        //          390 W=0.
        //          400 EO2CT=DAMP(RO2MT*.1,EO2CT,W)
        EO2CT=dampChange(RO2MT*0.1, oldValue: EO2CT, dampConstant: W)
        EC2CT=dampChange(RC2MT*0.1, oldValue: EC2CT, dampConstant: W)
        EN2CT=dampChange(RN2MT*0.1, oldValue: EN2CT, dampConstant: W)
        //              EC2CT=DAMP(RC2MT*.1,EC2CT,W)
        //              EN2CT=DAMP(RN2MT*.1,EN2CT,W)
        let Z=COADJ*c17
        //        C R-2CT IS CONTENT OF BLOOD REACHING CHEMORECEPTORS
        RO2CT = dampChange(V, oldValue: RO2CT, dampConstant:  Z)
        RC2CT = dampChange(U, oldValue: RC2CT, dampConstant:  Z)
        //              RO2CT=DAMP(V,RO2CT,Z)
        //              RC2CT=DAMP(U,RC2CT,Z)
        //        C O2CON AND C2CON ARE USED EVERY TIME FOR ENTERING S/R GASES. BEFORE
        //        C ENTERING S/R GASES (DISSOC.CURVES) SET CONTENTS OF O2 + CO2 FOR ART.
        //        C BLOOD, SAME FOR BICARB.(HCO3),WHICH HAS TO TAKE ACCOUNT OF IN VITRO
        //        C INFLUENCE OF ART.PCO2 ON BICARB.CONC. SO THAT PH CAN BE CALCULATED.
        //        C LIMITS SET TO PREVENT ARITHMETIC ERRORS
        RC3CT=c3*(RC2PR-40.0)+VC3MT*c1
        //              if(RC3CT) 940,940,410
        if RC3CT <= 0 {print("\nArithmetic error in arterialPool codeline 79. RC3CT = \(RC3CT)\n")}
        // MARK: We must take care of death.
        //        C ENTER ART.BICARB.,CALC.PH AND ENTER VALUE INTO RPH (ART. PH)
        //          410 RPH=PHFNC(RC3CT,RC2PR)
        RPH = calculatePh(RC3CT, CO2: RC2PR)
        //        C USE TEST ROUTINE GSINV TO INVERT GASES
        //        C+++ (REPLACES ITERATIVE REVERSAL ROUTINE IN PREVIOUS VERSIONS)
        //              CALL GSINV (RO2PR,RC2PR,RO2CT,RC2CT,RPH,SAT)
//        print("RO2PR before calling calcPressures in arterial pool is \(RO2PR).")
        (RO2PR, RC2PR) = calculatePressures4(O2CT: RO2CT, CO2CT: RC2CT, pH: RPH, temperature: TEMP, DPG: DPG, Hct: PCV/100, Hgb: HB)
        //RO2PR = results.pO2
        //RC2PR = results.pCO2
//        print("RO2PR after calling calcPressures in arterial pool is \(RO2PR).")
        // This is a very awkward way to get the saturation.   I am going to call the GASES
        // equivalent instead of going through GSINV.  We are only after the saturation here.
        //SAT = 0.0
        (X, Y,  SAT ) = calculateContents(pO2: RO2PR, pCO2: RC2PR, pH: RPH, temperature: TEMP, DPG: DPG, Hct: PCV/100, Hgb: HB)
        //        C STORE ARTERIAL SATN. AS PERCENTAGE

        PJ=SAT*100.0
        
    }
}
