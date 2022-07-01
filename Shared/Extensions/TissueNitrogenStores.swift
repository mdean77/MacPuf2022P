//
//  TissueNitrogenStores.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/30/22.
//

import Foundation

extension Human {
    
    mutating func tissueNitrogenStores(){
        
        //        C NEXT IS FOR NITROGEN STORES IN TISSUES
        //        C MOVE N2 BETWEEN FAST(T) AND SLOW(S) TISSUE COMPARTMENTS
        //        C ACCORDING TO P.PRESS. DIFFS.
        //          640
        let X=(TN2PR-SN2PR)*c60
        TN2MT=TN2MT+FTCOC*(EN2CT-TN2PR*0.00127)-X
        SN2MT=SN2MT+X
        //        C TEST ifSLOW SPACE SUPERSATURATED
        var  Y=(SN2MT*c26-c11)*c27
        //if(Y) 650,650,660
        //        C ifSO, AUGMENT U AND DECREMENT S, OR VICE VERSA IF
        //        C AMBIENT PRESSURE RELATIVELY HIGHER
        //          650
        if Y <= 0  {Y=Y*0.3}
        //  if(UN2MT) 670,670,660  I interpret this to mean if it is greater than zero
        //          660
        if UN2MT > 0 {  SN2MT=SN2MT-Y
            //        C BUBBL IS ARBIT.INDEX OF BUBBLE SYMPTS,TAKING INTO ACCOUNT
            //        C BTPS VOLUME AND LOADING BY NUMBER OF MOLECULES OF GAS
            //        C+++ N.B. 'BUBBL' IS ONLY A ROUGH INDEX - PROGRAMME UNDER DEVELOPMENT
            BUBBL=pow(UN2MT,1.2)*c23
            UN2MT=UN2MT+Y
        }
        //        C COMPUTE PARTIAL PRESSURES
        //          670
        SN2PR=SN2MT*c26
        TN2PR=TN2MT*c28
        
    }
}
