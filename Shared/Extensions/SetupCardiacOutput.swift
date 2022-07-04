//
//  SetupCardiacOutput.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/30/22.
//

import Foundation

extension Human {
    
    
    mutating func setupCardiacOutput(){
        
        ///  Initial set up for Macpuf FORTRAN  lines 210 through 280
        
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
        COADJ = dampChange((c8+c9)/Y, oldValue: COADJ, dampConstant: c61)
        //        C++++++++++++++++
        //        C........
        //        C++++++++++++++++++++++++++++++++++++++++++++++++
        //        C INCORPORATION OFHEART RATE AND STROKEVOLUME
         X=(-0.3*pow(COADJ,2.0)+11.0*COADJ+30.0)
        if COADJ > 20 {X = 130}
        //               if(COADJ.GE.20.) X=130.
        //        C STRVOL IN LITERS
        STRVL=c75*X/130000.0
        HRATE=COADJ/STRVL
        //        C LIMIT CARDIAC OUTPUT THROUGH STROKE VOLUME AND HEART RATE
        //               if(HRATE.LE.C74) GOTO 242
        //               HRATE=C74
        //               COADJ=HRATE*STRVL
        //          242  CONTINUE
        if HRATE > c74 {
            HRATE = c74
            COADJ = HRATE*STRVL
        }
        
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
    }
}
