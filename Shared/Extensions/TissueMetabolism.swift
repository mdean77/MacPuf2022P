//
//  TissueMetabolism.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/30/22.
//

import Foundation

extension Human{
    
    mutating func tissueMetabolism(){
        //    C++++++++++++++++ RELATION BETWEEN TRQ AND OXYGEN CONSUMPTION
         X=QA/FT
        //CALL FUNCTN (X,TRQ,FUN1,5)
        TRQ = FUNCTN(X,FUN1,5)
        //    C
        //    C+++++++++++++++++++
        //    C TISS. CO2 EXCHANGES; U=METAB.; .001 CONVERTS CC TO LITRES
        // U=FT*(pow(abs(SVENT),c4)*c5+COADJ+c7)  // Brought forward from previous routines where it was used
        TC2MT=TC2MT+(FTCOC*(EC2CT-TC2CT)+TRQ*U)*0.001
        //    C COMPUTE PART.PRESS. FROM TOTAL CO2 AND STAND. BICARB.
        TC2PR=(TC2MT*c30-TC3MT*c36+c33)*c43
        //    C FY STORES CHANGE IN TISS. CO2 FOR ADJUSTING TISS/. HCO3 BUFFERS
         FY=TC2PR-TC2RF
        TC2RF=TC2PR
        //    C .4 IN LINE BELOW REPRESENTS BUFFERS OF LACTIC ACID PARTLY INSIDE
        //    C CELLS, SO THAT THE DISPLACEMENT OF BICARBONATE IS LESS
        //    C THAN STRICT MOLAR EQUIVALENCE
        //    C BUFFERING EFFECT OF BICARBONATE RAISED:
        //    C+++++++++++++++++++++++++++++++++++++++++++++++++++
        //    C
        TC3MT=TC3MT+FTCOC*0.1*(VC3MT*c1-TC3MT*c13)-1.0*V
        //    C
        //    C++++++++++++++++++++++++++++++++++++++++++++++++++++
         Y=(TC2PR-40.0)*c3
        //690
        TC3CT=TC3MT*c13+Y
        //if(TC3CT) 940,940,700
        if TC3CT <= 0 {print("Patient is dead in tissue metabolism. TC3CT = \(TC3CT)")}  //MARK: Dead patient routine needed.
        TPH = calculatePh(TC3CT, CO2: TC2PR)
        // 700 TPH=PHFNC(TC3CT,TC2PR)
        //CALL GASES (TO2PR,TC2PR,TO2CT,TC2CT,TPH,SAT)
        (TO2CT, TC2CT, SAT) = calculateContents(pO2: TO2PR, pCO2: TC2PR, pH: TPH, temperature: TEMP, DPG: DPG, Hct: PCV/100, Hgb: HB)
        //    C AMTS OF GASES IN VENOUS POOL INC.BY ARRIVING BLOOD FROM
        //    C TISSUES AND DECREMENTED BY BLOOD GOING TO LUNGS. SAME FOR
        //    C BICARBONATE. CONTENTS V-2CT THEN DETERMINED
        X=c69*COADJ*FTCO
        VC2MT=VC2MT+FTCOC*TC2CT-FTCO*(VC2CT*c14-RC2CT*SHUNT)+X*EC2CT
        VO2MT=VO2MT+FTCOC*TO2CT-FTCO*(VO2CT*c14-RO2CT*SHUNT)+X*EO2CT
        VC3MT=VC3MT+FTCOC*0.1*(TC3MT*c13-VC3MT*c1)+ADDC3
        X=TC3AJ*c10
        TC3AJ=TC3AJ-ADDC3+V-X
        TC3MT=TC3MT-FY*c64+X*0.67
        VO2CT=VO2MT*c2
        VC2CT=VC2MT*c2
    }
}
