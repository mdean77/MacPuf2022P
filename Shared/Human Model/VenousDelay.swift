//
//  VenousDelay.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/30/22.
//

import Foundation

extension Human {
    
    mutating func venousDelay(){
        //        C*** LOCAL ARRANGEMENTS
        //        C+++ S/R DELAY CAN BE OMITTED WITH LOSS OF ACCURACY ONLY
        //        C+++ WHEN USING SHORT ITERATION INTERVALS
        //          CALL DELAY
        
        
        let NFT = max(Int(32.2 * FT * sqrt(COADJ)),20)
        
        //if(NFT-20) 110,110,100
        // 100 NFT=20
        let M=INDEX+NFT-1
        // DO 140 I=INDEX,M
        for i in INDEX...M {
            var N = i
            if N > 20 {N = N - 20}
            //120 N=N-20
            TDLAY[N]=VO2CT
            TDLAY[N+20]=VC2CT
            TDLAY[N+40]=VC3MT
            TDLAY[N+60]=TC2PR
        }
        var N=INDEX+NFT
        if N > 20 {N = N - 20}
        
        VO2CT=TDLAY[N]
        VC2CT=TDLAY[N+20]
        VC3MT=TDLAY[N+40]
        TC2PR=TDLAY[N+60]
        INDEX=N
        
        VC3CT=VC3MT*c1+Y
        if VC3CT <= 0 {print("The patient is dead in venousDelay. VC3CT = \(VC3CT)")} //MARK: Dead patient again
        VPH = calculatePh(VC3CT, CO2: TC2PR)
            
    }
}
