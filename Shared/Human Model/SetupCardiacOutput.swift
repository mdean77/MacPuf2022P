//
//  SetupCardiacOutput.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/30/22.
//

import Foundation

extension Human {
    
    
    mutating func setupCardiacOutput(){
//        print("Stroke volume going in to cardiac output is \(STRVL).")
//        print("Cardiac output going in to cardiac output is \(COADJ).")
        ///  Initial set up for Macpuf FORTRAN  lines 210 through 280  This is change.
        
        //        C NEXT AUTOMATICALLY INCREASES CARDIAC OUTPUT ifO2 SUPPLIED IS LOW
         Y=RO2CT*0.056
        //        C-------- REDUCES CARDIAC OUTP. INC. WITH HYPOXIA - PREV. TOO BIG
        if Y < 0.4 {Y = 0.4}
        //          220 if(Y-.4) 230,240,240
        //          230 Y=.4
        //        C COADJ IS ADJUSTED CARD.OUTPUT,USED MAINLY AS INDEX FTCO
        //        C WHICH TAKES ACCOUNT OF CARD.OUTPUT PER UNIT TIME.
        //        C OUTPUT GOES UP AS TOTAL O2 CONSUMPTION INCREASES.
        //        C+++++++++++++++++++++++ CO TRANSFERRED TO INFLUENCE STOKEVOL.
        //          240 COADJ=DAMP(((C8+C9)/Y),COADJ,C61)
//        print("Cardiac output before damp change in cardiac output is \(COADJ).")
        COADJ = dampChange((c8+c9)/Y, oldValue: COADJ, dampConstant: c61)
//        print("Cardiac output after damp change to cardiac output is \(COADJ).")
        //        C++++++++++++++++
        //        C........
        //        C++++++++++++++++++++++++++++++++++++++++++++++++
        //        C INCORPORATION OFHEART RATE AND STROKEVOLUME
         X=(-0.3*pow(COADJ,2.0)+11.0*COADJ+30.0)
        if COADJ > 20 {X = 130}
        //               if(COADJ.GE.20.) X=130.
        //        C STRVOL IN LITERS
        //print("COADJ is \(COADJ), HRATE IS \(HRATE) and STRVL is \(STRVL) initially.")
        //print("X factor is \(X) and calculation factor is \(c75*X/130000)")
       // STRVL=c75*X/130000.0  // This was dividing stroke volume every cycle
        STRVL = c75*X/130.0
        HRATE=COADJ*1000/STRVL
        //        C LIMIT CARDIAC OUTPUT THROUGH STROKE VOLUME AND HEART RATE
        //               if(HRATE.LE.C74) GOTO 242
        //               HRATE=C74
        //               COADJ=HRATE*STRVL
        //          242  CONTINUE
        if HRATE > c74 {
            HRATE = c74
            COADJ = HRATE*STRVL/1000
        }
       // print("COADJ is \(COADJ), HRATE IS \(HRATE) and STRVL is \(STRVL) after calculations..")
        
        //        C++++++++++++++++++++++++++++++++++++++++++++++++++++
        //              if(CO-3.) 250,260,260
        //        C ifHEART STOPPED MAKE OUTPUT AT ONCE ZERO TO STOP ARTERIAL
        //        C COMPOSITION CHANGING - 'E' IS A VERY SMALL NUMBER(DATA)
        //          250 COADJ=E
        //        C+++++++++++++ ifHEART STOPS, HRATE=0
        //              HRATE=E
        //              GO TO 280
        //        C++++++++++++++++++++++++++++++++++++++++++++++++++
        //        CCARDIACOUTPUT NOW LIMITED THROUGH STROKEVOLUME
        //          260  CONTINUE
        //          270  CONTINUE
        //        C++++++++++++++++++
        if CO < 3 {
            COADJ = E
            HRATE = E
        } else {
            if COADJ > COMAX {COADJ = COMAX}
        }
        //        C LIMIT MAXIMUM CARDIAC OUTPUT
        //        C 260 if(COADJ-COMAX) 280,280,270
        //        C 270 COADJ=COMAX
        //        C FTCO IS NO. OF 100 ML PORTIONS OF BLOOD CIRCULATING PER FRACTIONAL
        //        C TIME INTERVAL
        FTCO=c17*COADJ
        FTCOC=FTCO*(1.0-c69*COADJ)
//        print("Stroke volume coming out of cardiac output is \(STRVL).")
//        print("Cardiac output coming out of cardiac output is \(COADJ).")
    }
}
