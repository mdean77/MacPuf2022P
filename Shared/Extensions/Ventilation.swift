//
//  Ventilation.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/30/22.
//

import Foundation

extension Human {
    
    mutating func ventilation(){
//        C PREVENT IMMEDIATE CHANGES IN SPECIFIED VENT. CAPACITY
              //XRESP=DAMP(C46,XRESP,C68)
        XRESP = dampChange(c46, oldValue: XRESP, dampConstant: c68)
//        C COMPUTE TOTAL ADDITIVE EFFECTS OF VENT. STIMULI
              U=(c44*(X+W)+c45*Y+XRESP-Z)*c47
//        C RESTRICT TO MAX. VALUE, PREDICTED OR ASSUMED
//              if(U-C6) 1240,1240,1230
//         1230 U=C6
                    if U > c6 {U = c6}
//        C DAMP SPEED OF RESPONSE ACCORDING TO CARD.OUTPUT AND DEPTH
//        C OF BREATHING, INCLD. BRAIN OXYGENATION INDEX
         //1240
        X=(COADJ+5.0)*c62/(TIDVL+400.0)
              //SVENT=BO2AD*DAMP(U,SVENT,X)
        SVENT = BO2AD * dampChange(U, oldValue: SVENT, dampConstant: X)
              //if(PL) 1280,1250,1250
//        C ifVENT. STIMULI INADEQUATE, =APNOEA
        if PL >= 0 {
            if SVENT <= c48 {
                if NARTI == 1 {
                    DVENT = E
                    RRATE = 0.0001
                    // goto 1350
                }
            }
            
            //         1250 if(SVENT-C48) 1260,1260,1290
            //         1260 if(NARTI) 1290,1290,1280
            //         1280 DVENT=E
            //              RRATE=.0001
            //              GO TO 1350
            //        C RESP.RATE CALC.FROM CONSTANT + ELASTANCE +TOTAL VENTN.+ART PO2
            //        C ALLOWING FOR MANUAL ADJUSTMT.OF BREATHING CAP(PR)
        } else {
            if NARTI == 1 {
                DVENT = SVENT
                RRATE=(c49+pow(DVENT,0.865)*0.370)*c50/(PJ+40.0)
            }
//            1290 if(NARTI) 1320,1320,1300
//                    1300 DVENT=SVENT
//                    RRATE=(C49+DVENT**.865*.370)*C50/(PJ+40.)
            if RRATE > 1 {
                if COADJ > 0.5 {
                    U = AO2PR * 0.15
                    if U > 70 {U = 70}
                    DSPAC = dampChange((C52+DVENT*100./RRATE**1.12+20.*DVENT/(COADJ+
                                                                              X5.)+U+FY+C54*(TIDVL+500.)), oldValue: DSPAC, dampConstant: c55)
                }
            }
//                    if(RRATE-1.) 1350,1350,1310
//                    1310 if(COADJ-.5) 1350,1350,1320
//                    //        C CALC DYNAMIC DEAD SPACE AS SUM OF ANAT.FACTORS + THOSE
//                    //        C DEPENDENT ON VENTN. AND PERFUSION, THEN CALC.ALV.VENTN.
//                    1320 U=AO2PR*.15
//                    if(U-70.) 1340,1340,1330
//                    1330 U=70.
//                    1340 DSPAC=DAMP((C52+DVENT*100./RRATE**1.12+20.*DVENT/(COADJ+
//                                                                           X5.)+U+FY+C54*(TIDVL+500.)),DSPAC,C55)
        }
         1350 TIDVL=DVENT*1000./RRATE
         1360 AVENT=(TIDVL-DSPAC)*RRATE*FT
//        C RESTRICT TIDAL VOL. TO MAXIMUM(C20), THEN ifNECESSARY GO
//        C BACK TO RECOMPUTE RESP. RATE, PROVIDING ARTIF.VENT. NOT IN USE
              if(NARTI) 1380,1380,1365
         1365 X=TIDVL-C20
              if(X) 1380,1380,1370
         1370 TIDVL=C20
              RRATE=DVENT*1000./TIDVL
              GO TO 1360
         1380 if(AVENT) 1390,1390,1400
         1390 AVENT=E
         1400 FVENT=AVENT*C56
//        C TND,J3,ND CONCERNED WITH TIMING MARKS. PG IS INDEX OF TIME
//        C BRAIN HAS BEEN DEPRIVED OF OXYGEN.  ifTOO GREAT DEATH RESULTS
              TND=TND+C57
              if(BO2AD-.3) 1410,1410,1420
         1410 PG=PG-(BO2AD-1.)*C58
              GO TO 1430
         1420 PG=PG-BO2AD*C59
         1430 if(TND-60.) 1450,1440,1440
         1440 TND=TND-60.
              J3=J3+1
         1450 ND=INT(TND)
//        C TEST FOR DEATH, OR GIVE ERROR MESSAGE ifLL5 = -1
         1455 CALL DEATH (LL1,LL5)
              if(LL1-2) 1457,1600,1600
        C OUTPUT SUPPRESSION INSTRUCTIONS
         1457 if(NB-1) 1470,1590,1460
         1460 if(MORAN-NREPT) 1590,1500,1590
         1470 if(ISPAR-2) 1500,1480,1490
//        C-------- PREVENTS TIME SCALE ERRORS AFTER BACKTRACK
         1480 if(LL4-6) 1590,1500,1500
         1490 if(LL4-30) 1590,1500,1500
//        C........
//        C RESET LOOP COUNTER
         1500 LL4=0
//        C CHOOSE TYPE OF DISPLAY
//        C------- NPRT=0 SUPRESSES THE PRINTOUT
              if(NPRT) 1590,1590,1505
         1505 if(NC-3) 1510,1515,1515
//        C..........
         1510 CALL BRETH
              GO TO 1590
//        C CONVERT ALL PRESSURES IN MM HG TO SI UNITS ifPREVIOUSLY SPECIFIED
//        C BEFORE OUTPUT
         1515 CALL UNITS(1,SIMLT)
              IF(NC-3) 1540,1540,1520
         1520 WRITE (KL,1530) T
         1530 format(1X,10F7.2)
              GO TO 1580
         1540 DO 1550 J=1,8
              JOKE=NE(J)
         1550 TJJ(J)=T(JOKE)
              WRITE (KL,1560) J3,ND,(TJJ(J),J=1,8)
         1560 format(1X,I3,1H.,I2,2F8.3,6F8.1)
//        C CONVERT ALL PRESSURE UNITS BACK TO MM HG BEFORE GOING ON
         1580 CALL UNITS(2,SIMLT)
         1590 CONTINUE

    }
}
