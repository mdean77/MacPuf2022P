//
//  Human.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/25/22.
//
//  This is my MODEL.  It will be created by my VIEWMODEL which is called Simulator.

import Foundation

struct Human {

    static let zeroes = (0.0, 0.0, 0.0, 0.0,0.0, 0.0, 0.0, 0.0,0.0,0.0)
    // Initialize parameter variables with zero values
    var (FIO2,FIC2,CO,PD,FADM,BULLA,VLUNG,ELAST,VADM,AZ) = zeroes
    var (BZ,CZ,BARPR,TEMP,TRQ,TC2MT,TVOL,HB,PCV,VBLVL) = zeroes
    var (ADDC3,BC3AJ,DPG,PR,FITNS,SPACE,COMAX,SHUNT,VC,PEEP) = zeroes
    var (VO2CT,RCOAJ,RPH,VPH,FVENT,BPH,BAGO,BAGC,AO2MT,AC2MT) = zeroes
    var (AO2PR,AC2PR,DPH,XLACT,BO2PR,BC2PR,TIDVL,RRATE,RO2CT,VC2MT) = zeroes
    var (DVENT,SVENT,PC2CT,PO2CT,TO2CT,TC2CT,BO2CT,BC2CT,TPH,RC3CT) = zeroes
    var (VC2CT,RO2MT,RC2MT,XRESP,AN2MT,BO2MT,BC2MT,CBF,PC,DSPAC) = zeroes
    var (REFLV,RO2PR,CONSO,RC2PR,PG,PJ,TND,RC2CT,QB,PW) = zeroes
    var (FT,CONOM,BUBBL,TC2RF,TC3MT,VC3MT,TC3CT,VC3CT,TLAMT,RLACT) = zeroes
    var (BC3CT,BO2AD,COADJ,EO2CT,TO2MT,TO2PR,TC2PR,VO2MT,AVENT,PL) = zeroes
    var (EC2CT,TN2MT,TN2PR,FEV,SN2PR,EN2CT,UN2MT,RN2MT,HRATE,STRVL) = zeroes
    var (TC3AJ,SN2MT,QA,RVADM,XDSPA,BAG,XMALE,HT,WT,AGE) = zeroes
    
    // Initialize constants with zero values
    var (c1, c2, c3, c4, c5, c6, c7, c8, c9, c10) = zeroes
    var (c11, c12, c13, c14, c15, c16, c17, c18, c19, c20) = zeroes
    var (c21, c22, c23, c24, c25, c26, c27, c28, c29, c30) = zeroes
    var (c31, c32, c33, c34, c35, c36, c37, c38, c39, c40) = zeroes
    var (c41, c42, c43, c44, c45, c46, c47, c48, c49, c50) = zeroes
    var (c51, c52, c53, c54, c55, c56, c57, c58, c59, c60) = zeroes
    var (c61, c62, c63, c64, c65, c66, c67, c68, c69, c70) = zeroes
    var (c71, c72, c73, c74, c75) = (0.0, 0.0, 0.0, 0.0, 0.0)
    
    // Data sets for FUNCTN calls
    // FUN1 for tissue RQ, FUN2 for muscle lactate catabolism, FUN3 for work rate-efficiency relation
    let FUN1:[Double] = [0.0, 250.0,0.80,450.0, 0.86, 1320.0, 0.87, 2100.0,0.90, 3150.0,1.00]
    let FUN2:[Double] = [0.0, 450.0,0.27,578.0,0.280, 626.0,0.402, 730, 1.99,734,2,860,8,1010,14,1130,23.5,2500,5.5, 3500,0.35]
    let FUN3:[Double] = [0,3,2,15,6.7,30,11.5,45,14.5,75,18,90,19.3,120,20.7,150,20.9,225, 22.5,300,20.5]
    
    // Venous pool delay arrays
    var TDLAY = [Double](repeating:0.0, count:81)
 
    var NARTI = 1
    var SIMLT = 1.0
    let E = 0.0000001
    var (FTCO, FTCOC, U, V,Y, X,W,Z, SAT, FY) = zeroes
    var INDEX:Int = 1
    var macpufDead = false
    
    mutating func simulate(cycle:Int, iterations:Int){
        if PL > 1.5 {
            print("CALL BAGER") //200 CALL BAGER (2,C12,C12,C12,SIMLT)
        }
        
        setupCardiacOutput()
        arterialPool()
        lactateMetabolism()
        tissueNitrogenStores()
        tissueMetabolism()
        venousDelay()
        lungMetabolism2()
        brainMetabolism()
        ventilation()
        
        if cycle == iterations {
            ADDC3 = 0
        }
    }
}


