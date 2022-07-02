//
//  LungMetabolism.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/30/22.
//

//import Foundation

//extension Human {
//
//    mutating func lungMetabolism(){
//
//        //  C NEXT LONG SECTION CONCERNS GAS EXCH.IN LUNGS.PC IS FRACTION OF
//        //  C CARD.OUTPUT PERFECTLY MIXED WITH ALVE0LAR GASES.U AND V=AMTS OF
//        //  C EACH GAS TAKEN IN PER UNIT FRACT TIME(FT)
//        PC=FTCO*c14*PC
//        X=AVENT*c12
//        U=X*FIO2
//        V=X*FIC2
//        //  C NEXT 3 STS.COMPUTE NEW AMTS.OF EACH GAS IN LUNGS. W IS VOLUME
//        //  C AT END OF NOMINAL 'INSPIRATION'
//        AO2MT=AO2MT+U
//        AC2MT=AC2MT+V
//         Z=100.0-FIO2-FIC2
//        //  C-------- ECONOMISES
//        AN2MT=AN2MT+X*Z
//        //  C........
//        let W=AO2MT+AC2MT+AN2MT
//        //  C NOW CALC.ALVEOLAR PARTIAL PRESSURES
//        X=c11/W
//        let PO2=AO2MT*X
//        let PC2=AC2MT*X
//        //  C CHANGE ALV.GAS AMTS.IN ACCORDANCE WITH BLOOD GAS CONTENTS
//        //  C ENTERING(V-2CT) AND LEAVING(P-2CT) THE LUNGS.
//        //  C PC=FINAL NEW AMT OF TOTAL GAS AT END OF ALL
//        AO2MT=AO2MT+PC*(VO2CT-PO2CT)
//        AC2MT=AC2MT+PC*(VC2CT-PC2CT)
//        AN2MT=AN2MT+PC*(TN2PR*0.00127-EN2CT)
//        PC=AO2MT+AC2MT+AN2MT
//        //  C FY BECOMES + ONLY ifMORE GAS GOES OUT THAN IN, IN WHICH CASE FY
//        //  C IS LATER BROUGHT INTO THE CALCULATION OF EFFECTIVE DEAD SPACE
//        //        if(PL-2.) 750,770,750
//        //            750 if(AVENT-20.) 770,760,760
//        //            760 FY=(PC-W)*C34/RRATE
//        //            GO TO 780
//        //            770 FY=0.
//        //            780 if(PL) 790,800,800
//        //            790 CALL BAGER (5,PC,X,C12,SIMLT)
//        if PL != 2.0 {
//            if AVENT < 20 {
//                 FY = 0.0
//            } else {
//                 FY = (PC-W)*c34/RRATE
//            }
//        }
//        if PL < 0 {print("CALL BAGER")} // 790 CALL BAGER (5,PC,X,C12,SIMLT)
//
//        //  C XVENT IS VOL.EXHALED IN NOM.TIME (FT) DOWN TO RESTING LUNG VOL.
//        //  C ifTHIS IS NEG.THERE IS SOME DIFFUSION RESP.IN WHICH CASE GO BACK
//        let XVENT=PC*c35-VLUNG
//
//        if XVENT >= 0 {
//            X=XVENT*c25
//            DVENT=X/PC
//            X=X/c11
//            Y=X*AO2PR
//            Z=X*AC2PR
//            PC=X*(c11-AO2PR-AC2PR)
//            QA = U - Y
//            QB = Z - V
//
//            if PL > 0.5 {print("CALL BAGER") //  820 CALL BAGER (4,XVENT,DVENT,C12,SIMLT)
//                if DVENT < -9000 {print("Patient is dead in lung with DVENT = \(DVENT).")}
//            }
//
//            if AVENT <= E {
//                QA = 0.001
//                QB = E
//            }
//
//            AO2MT=AO2MT-Y
//            AC2MT=AC2MT-Z
//            AN2MT=AN2MT-PC
//        } else {   // XVENT less than zero and we have DIFFUSION RESPIRATION
//            let FD=XVENT*c12
//            AO2MT=AO2MT-FD*FIO2
//            AC2MT=AC2MT-FD*FIC2
//            AN2MT=AN2MT-FD*Z
//        }
////            if(XVENT) 720,810,810
////            //            C THIS  SECTION - RARELY NEEDED - IS FOR DIFFUSION RESPIRATION
////            720 FD=XVENT*C12
////            AO2MT=AO2MT-FD*FIO2
////            AC2MT=AC2MT-FD*FIC2
////            AN2MT=AN2MT-FD*Z
////            GO TO 850
////            //  C+++++++++++++++++++++++++++++++++++++++++++++++++++
////            //  CHANGE  TO LET PC2PR OBEY RESPIRATORY FORMULA
////            //  C NOW DR. DICKINSONS VERSION USED
////            //  C--------- IMPROVES COMPUTED EXPIRED GAS QUANTITIES
////            810 X=XVENT*C25
////            DVENT=X/PC
////            X=X/C11
////            Y=X*AO2PR
////            Z=X*AC2PR
////            PC=X*(C11-AO2PR-AC2PR)
////            //  C...........
////            //  C+++++++++++++++++++++++++++++++++++++++++++++++++++
////            //  C U=O2, V=CO2 UPTAKE IN FT TIME, Y,Z,PC=GAS OUTPUTS
////            //  C ALGEBRAIC SUMMING OF INTAKE AND OUTPUT OF O2 AND CO2
////            QA=U-Y
////            QB=Z-V
////            if(PL-.5) 830,830,820
////            820 CALL BAGER (4,XVENT,DVENT,C12,SIMLT)
////            if(DVENT+9000.) 940,830,830
////            830 if(AVENT-E) 730,730,840
////            //            C PREVENT LATER DIVISION ERRORS ifGAS EXCHANGE ZERO
////            730 QA=.001
////            QB=E
////            GO TO 840
////            //  C SET NEW AMTS.OF EACH GAS, THEN CAL.PARTIAL PRESSURES
////            840 AO2MT=AO2MT-Y
////            AC2MT=AC2MT-Z
////            AN2MT=AN2MT-PC
//
//            //850
//        U=c11/(AO2MT+AN2MT+AC2MT)
//            //  C TAKE ACCOUNT OF INSP/EXP DURATION RATIO
//            V=c37/RRATE
//        if V > 4.0 {V = 4.0}
//
////            if(V-4.) 870,870,860
////            860 V=4.
//        if AVENT < 20 {V = 0}
////            870 if(AVENT-20.) 880,890,890
////            880 V=0.
//            //  C SPEED OF CHANGE OF ALV. GAS TENSIONS(X)= FUNCT. OF TIDAL VOL.
//            //890
//        X=(TIDVL+100.0)*c38
//            //  C COMPUTE END-'EXPIRATORY' PARTIAL PRESSURES
//            Y=AO2MT*U
//            Z=AC2MT*U
//            //  C DAMP FUNCTION USED TO PREVENT OSCILLATORY SWINGS
//            //  C OF ALVEOLAR GAS PRESSURES
//            //AO2PR=DAMP((Y+(PO2-Y)*V),AO2PR,X)
//        AO2PR = dampChange(Y + (PO2-Y)*V, oldValue: AO2PR, dampConstant: X)
//            //AC2PR=DAMP((Z+(PC2-Z)*V),AC2PR,X)
//        AC2PR = dampChange(Z+(PC2-Z)*V, oldValue: AC2PR, dampConstant: X)
//        if AO2PR <= E {
//            print("Patient is dead in lungs with AO2PR = \(AO2PR).")
//        }
//        if AC2PR <= E {
//            print("Patient is dead in lungs with AC2PR = \(AC2PR).")
//        }
//            //  C DETERM.EXPIRED RQ(PC)THEN ALV.GAS TENSIONS, AND EVENTUALLY
//            //  C CONTENTS OF CO2 + O2 IN PULM.CAP.BLOOD(P-2CT)
////            910 if(QA) 920,930,920
////            920 PC=QB/QA
//        if QA != 0 { PC = QB/QA}
//             X=VC3MT*c1+c3*(AC2PR-40.0)
//        if X < E {
//            print("Patient is dead in lungs with VC3MT = \(VC3MT) and AC2PR = \(AC2PR).")
//        }
////            if(X-E) 940,950,950
////            940 LL5=-1
////            GO TO 1455
//             //Y=PHFNC(X,AC2PR)
//        Y = calculatePh(X, CO2: AC2PR)
//            //CALL GASES (AO2PR,AC2PR,PO2CT,PC2CT,Y,SAT)
//        (PO2CT, PC2CT, SAT) = calculateContents(pO2: AO2PR, pCO2: AC2PR, pH: TPH, temperature: TEMP, DPG: DPG, Hct: PCV/100, Hgb: HB)
//    }
//
//}
