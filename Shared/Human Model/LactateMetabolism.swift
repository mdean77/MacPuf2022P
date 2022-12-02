//
//  LactateMetabolism.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/30/22.
//

import Foundation

extension Human {
    
    mutating func lactateMetabolism(){
        //        C U REPRESENTS SPECIFIED ENERGY EXPENDITURE FROM 'METABOLIC RATE'
        //        C AS SPECIFIED BY THE OPERATOR - CHANGING C7. IN ST.NO 490 1ST TERM IS
        //        C O2 CONSUMPTION OF RESP. MUSCLES, AND 2ND O2 CONS. OF HEART.  IN
        //        C THE EVENT OF ANAEROBIC METAB., SAME ENERGY REQUIREMENTS
        //        C INVOLVE 11X NO OF MOLES OF LACTATE BEING PRODUCED
        //        C WITH OXYGEN BEING SPARED (XLACT)
        //490 U=FT*(ABS(SVENT)**C4*C5+COADJ+C7)
         U = FT * (pow(abs(SVENT),c4) * c5 + COADJ + c7)
        //        C COMPUTE NEW TISSUE GAS AMOUNTS(T-2MT)
        //500
        TO2MT=TO2MT+FTCOC*(EO2CT-TO2CT)-U+XLACT
        //        C SET LIMITS TO PREVENT ARITH.ERRORS
        if TO2MT < E {print("\nArithmetic error in lactate metabolism codeline 25. TO2MT = \(TO2MT)\n")
            print("U, FT, SVENT, c4, c5, COADJ and c7: \(U),\(FT),\(SVENT),\(c4),\(c5),\(COADJ),\(c7)\n")
            
            
        }  //MARK: Patient death needs to be handled
        //              if(TO2MT-E) 940,940,510
        //        C COMPUTE TISS. PO2, DAMPING APPROPRIATELY
        //510
        //                    TO2PR=DAMP(TO2MT*C31,TO2PR,C55)
        TO2PR = dampChange(TO2MT*c31, oldValue: TO2PR, dampConstant: c55)
         X=TO2MT-250.0
        //if(X) 530,530,520
        //        C NEXT SECTION CONCERNS LACTIC ACID METABOLISM
        //520
        if X > 0 {
            TO2PR=45.0+0.09*X}
        //        C LOCAL VARIABLE Y WILL BE USED LATER FOR CATABOLISM RELATED
        //        C TO CARDIAC OUTPUT AND METABOLISM
        //530
          Y=RLACT*c29
        //        C Z=CATABOLIC RATE FOR LACTATE
        //        C X IS THRESHOLD - WHEN TPH LESS THAN 7.0 CATABOLISM IMPAIRED
        //        C CEREB.BL.FLOW(CBF) IS USED TO GIVE APPROPRIATE CHANGES IN LACTATE
        //        C METAB. WITH LOW PCO2 OR ALKALOSIS. (CBF COMPUTED ELSEWHEREC
        //        C AND HAPPENS TO CHANGE IN THE APPROPRIATE WAY)
         W=CBF*0.019
        if W > 1 {W = 1}
        // if(W-1.0) 536,536,534
        //534
        //         W=1.
        //536
        X=TPH*10.0-69.0
        if X > W {X = W} //550,550,540
        //540
        //         X=W
        //        C 1ST TERM IS HEPATIC REMOVAL, 2ND IS RENAL REMOVAL WITH PH INFLUENCE
        //        C 3RD TERM IS BLOOD FLOW RELATED METABOLISM BY MUSCLES, MADE
        //        C DEPENDENT ON CARDIAC OUTPUT (COADJ).  WHOLE EXPRESSION IS
        //        C MULTIPLIED BY Y, A FUNCTION OF BLOOD LACTATE CONCENTRAION
        //        C+++++++++++++++++++++++++++++++++++++++++++++++++
        //        C
        //        C LACTATE CATABOLISM SPLIT INTO ORGANS AND MUSCLE CATABOLISM
        //        C (CATLIVER AND CATCIDNEY) AND CATMUS
        //550
        let CATLIV=Y*(X*0.8612)
        let CATCID=Y*(0.0232*pow(2,((8.0-TPH))*3.33))
        var ORGCAT=CATCID+CATLIV
        //        C     CATCID=CATCID/FT
        //        C     CATLIV=CATLIV/FT
        X=ORGCAT-0.3*FT/0.016667
        if X > 0 { ORGCAT=0.3000*FT/0.016667}
        X=QA/FT
        var CATOX = 0.0
        //CALL FUNCTN (X,CATOX,FUN2,10)
        CATOX = FUNCTN(X, FUN2, 10)
        //        C  CATOX IS A CATABOLISM-OXYGEN CONSUMPTION RELATION
        var CATMUS=Y*CATOX
         Z=ORGCAT+CATMUS
        CATMUS=CATMUS/FT
        //        C+++++++++++++++++++++++++++++++++++++++++++++++++++++++
        W=c70/(W+0.3)
        //        C     AFBR1=Z/FT
        //        C FITNS IS THRESHOLD FOR SWITCH TO ANAEROBIC METABOLISM
        //        C RELATED TO FITNESS
        //        C-------- ALTERS THRESHOLD FOR ANAEROBIC METAB.SWITCH, AT REST ONLY
         V=c73-TO2PR
        //        C........
        //if(V) 570,570,560
        //        C NEXT STATEMENT PROVIDES VIRTUAL TRIGGER EFFECT AND
        //        C RAPIDLY INCREASES LACTIC ACID PROD.ifTISS. PO2 LOW
        //560
        if V > 0 {
            W=W+c42*pow((V+1.0),4)
            //        C CATABOLISM(Z) FALLS ifTISS. PO2 TOO LOW
            //        C++++++++++++++++++++++++++++++++++++++++++++++++++++++
            //        C
            if TO2PR < FITNS-8.0 { Z=Z*TO2PR*0.04}
            if Z > 0.85  {Z=0.85}
        }
        //        C
        //        C++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        //        C XLACT IS O2 SPARING EFFECT OF LACTIC ACID PRODUCTION
        //        C (NOT ALLOWED TO EXCEED ACTUAL O2 CONSUMPTION)
        //570
        X=2.04*(W-c32)
        //    if(X-U) 590,590,580
        //580
        if X > U {   X=U }
        //590
        //  XLACT=DAMP(X,XLACT,C53)
        XLACT = dampChange(X, oldValue: XLACT, dampConstant: c53)
        //        C LIMIT OF RATE OF LACTATE FORM DETERMINED BY METAB. DRIVE
        //        C TO TISSUES (I.E. LEVEL OF EXERCISE),  AND TO BODY SIZE
        //  if(W-C40) 610,610,600
        //600
        if W > c40 {   W=c40}
        //        C REDUCE LACTATE CATABOLISM ifCARD.OUTPUT LESS THAN 1/3 NORMAL
        //        C TO TAKE ACCOUNT OF PROBABLE DIM.LIVER AND KIDNEY BL.FLOWS
        //610
        X=c24-COADJ
        //if(X) 630,630,620
        //620
        if X > 0 {      Z=Z*COADJ/c24 }
        //        C INCR.TOTAL LACTIC ACID BY DIFFER.BETWEEN PROD. AND CATABOLISM
        //630
        V=W-Z
        //        C     AFBR2=Z/FT
        //        C     PROD=W/FT
        TLAMT=TLAMT+V
        //RLACT=DAMP(TLAMT*C15,RLACT,COADJ*C55)
        RLACT = dampChange(TLAMT*c15, oldValue: RLACT, dampConstant: COADJ*c55)
    }
}
