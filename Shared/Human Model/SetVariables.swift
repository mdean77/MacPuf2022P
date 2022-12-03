//
//  SetVariables.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/26/22.  Revised November 27, 2022
//

import Foundation

extension Human {
    mutating func setVariables(){
         FIO2 = 20.93000          // MacPuf variable FIO2   Factor 1
         FIC2 = 0.0300            // MacPuf variable FIC2   Factor 2
         CO = 100.000             // MacPuf variable CO        Factor 3
         PD = 100.0               // PD  Factor 4
         FADM = 0.0               // MacPuf variable FADM        Factor 5
         BULLA = 0.0000           // MacPuf variable BULLA  Factor 6
         VLUNG = 3000.000         // MacPuf variable VLUNG  Factor 7
         ELAST = 5.0000           // MacPuf variable ELAST  Factor 8
         VADM = 3.0               // MacPuf variable VADM        Factor 9
         AZ = 100.000             // MacPuf variable      Factor 10
         BZ = 100.000             // MacPuf variable BZ      Factor 11
         CZ = 100.000             // MacPuf variable CZ     Factor 12
         BARPR = 760.0            // BARPR  Factor 13
         TEMP = 37.0              // TEMP Factor 14
         TRQ = 0.8000             // TRQ   Factor 15
         TC2MT = 13.38            // TC2MT Factor 16
         TVOL = 12.0000           // TVOL Factor 17
         HB = 14.8                // HB  Factor 18
         PCV = 45.0               // PCV Factor 19
         VBLVL = 3000.00          // MacPuf variable VBLVL  Factor 20
         ADDC3 = 0.0              // MacPuf variable ADDC3  Factor 21
         BC3AJ = 0.0              //BC3AJ Factor 22
         DPG = 3.7843                // DPG Factor 23
         PR = 100.0               //  PR  Factor 24  - same as ventilatory coupling
         FITNS = 33.0             // FITNS  Factor 25
         SPACE = 0.4000           // % of respiratory cycle spent in inspiration SPACE Factor 26
         COMAX = 35.0000          // MacPuf variable COMAX    Factor 27
         SHUNT = 0.0              // MacPuf variable SHUNT    Factor 28
         VC = 5.0000              // MacPuf variable VC     Factor 29
         PEEP = 0.0               // PEEP  Factor 30
        
         VO2CT = 14.56            // VO2CT  Factor 31
         RCOAJ = 100.0            // Factor 32
         RPH = 7.4                // MacPuf variable RPH    Factor 33
         VPH = 7.37               // VPH Factor 34
         FVENT = 4.26             // MacPuf variable FVENT  Factor 35
         BPH = 7.33               // BPH  Factor 36
         BAGO = 0.0               // MacPuf variable BAGO  Factor 37
         BAGC = 0.0               // MacPuf variable BAGC  Factor 38
         AO2MT = 348.1            // MacPuf variable AO2MT  Factor 39
         AC2MT = 143.3            // MacPuf variable AC2MT  Factor 40
         AO2PR = 101.9            // MacPuf variable AO2PR  Factor 41
         AC2PR = 39.75            // MacPuf variable AC2PR  Factor 42
         DPH = 7.40               // DPH Factor 43
         XLACT = 0.0              // XLACT Factor 44
         BO2PR = 28.89            // BO2PR  Factor 45
         BC2PR = 52.8             // BC2PR  Factor 46
         TIDVL = 461.9            // MacPuf variable TIDVL  Factor 47
         RRATE = 12.82            // MacPuf variable RRATE  Factor 48
         RO2CT = 19.54            // MacPuf variable RO2CT  Factor 49
         VC2MT = 1540.0           // VC2MT  Factor 50
         DVENT = 5.92             // MacPuf variable DVENT  Factor 51
         SVENT = 5.92             // MacPuf variable SVENT  Factor 52
         PC2CT = 47.25            // MacPuf variable PC2CT  Factor 53
         PO2CT = 19.66            // MacPuf variable PO2CT  Factor 54
         TO2CT = 14.47            // TO2CT Factor 55
         TC2CT = 51.4             // TC2CT Factor 56
         BO2CT = 10.05            // BO2CT  Factor 57
         BC2CT = 56.62            // BC2CT  Factor 58
         TPH = 7.37               // TPH Factor 59
         RC3CT = 23.82            // MacPuf variable RC3CT  Factor 60
         VC2CT = 51.33            // VC2CT  Factor 61
         RO2MT = 195.44           // MacPuf variable RO2MT  Factor 62
         RC2MT = 473.5            // MacPuf variable RC2MT  Factor 63
         XRESP = 10.99            // XRESP Factor 64
         AN2MT = 1987.0           // MacPuf variable AN2MT  Factor 65
         BO2MT = 18.06            // BO2MT  Factor 66
         BC2MT = 677.0            // BC2MT  Factor 67
         CBF = 51.94              // CBF   Factor 68
         PC  = 0.80               // PC Factor 69 0.7993?
         DSPAC = 129.2            // MacPuf variable DSPAC  Factor 70
         REFLV = 3000.000         // MacPuf variable REFLV  Factor 71
         RO2PR = 94.18            // MacPuf variable RO2PR  Factor 72
         CONSO = 240.000          // CONSO Factor 73
         RC2PR = 39.9             // MacPuf variable RC2PR  Factor 74
         PG = 0.0                 // PG Factor 75 0.00?
         PJ = 97.13               // PJ Factor 76 97.0730 ??
         TND = -10.0              // TND Factor 77 0.0851 ??  Minutes that brain has been deprived of O2
         RC2CT = 47.35            // MacPuf variable RC2CT  Factor 78
//         QB = 33.29               // QB Factor 79   Net CO2 output per unit time interval
         QB = 3.329                // Adjusting for time interval
         PW = 2.3618              // MacPuf variable PW        Factor 80
         FT = 0.016667            // FT Factor 81 = 1/60
         CONOM = 4.6000           // MacPuf variable CONOM    Factor 82
         BUBBL = 0.000            // BUBBL Factor 83
         TC2RF = 45.43            // TC2RF Factor 84
         TC3MT = 318.0            // TC3MT Factor 85
         VC3MT = 71.55            // VC3MT  Factor 86
         TC3CT = 25.48            // TC3CT Factor 87
         VC3CT = 25.48            // VC3CT  Factor 88
         TLAMT = 34.63            // TLAMT  Factor 89
         RLACT = 0.99             // MacPuf variable RLACT  Factor 90
         BC3CT = 22.7000          // BC3CT   Factor 91
         BO2AD = 1.0              // BO2AD  Factor 92  var oxygenationIndex = 1.000 ???
         COADJ = 5.01             // MacPuf variable COADJ    Factor 93
         EO2CT = 19.54            // MacPuf variable EO2CT  Factor 94
         TO2MT = 178.4            // TO2MT Factor 95
         TO2PR = 40.13            // TO2PR Factor 96
         TC2PR = 45.43            // TC2PR Factor 97
         VO2MT = 437.0            // VO2MT  Factor 98
         //AVENT = 710.8            // AVENT Factor 99 Value reflects original 10 sec FT
         AVENT = 71.08
         PL = 0                   // PL Factor 100
         EC2CT = 47.35            // MacPuf variable EC2CT  Factor 101
         TN2MT = 76.07            // TN2MT - Amount in fast Factor 102
         TN2PR = 571.1            // TN2PR - Fast equilibrating store Factor 103
         FEV = 4.0                // MacPuf variable FEV      Factor 104
         SN2PR = 564.0            // SN2PR - Slow equilibraint store Factor 105
         EN2CT = 0.73             // MacPuf same as EN2CT Factor  Factor 106
         UN2MT = 0.0              // UN2MT Factor 107
         RN2MT = 7.26             // MacPuf variable RN2MT  Factor 108
         HRATE = 70.0             // HRATE Factor 109  Heart rate
         STRVL = 70.0             // STRVL Factor 110  Stroke Volume
         TC3AJ = -0.03            // TC3AJ Factor 111
         SN2MT = 967.0            // SN2MT - Amount in slow Factor 112
         //QA = 41.61               // QA Factor 113 O2 uptake per unit time interval
         QA = 4.161               // QA Factor 113 O2 uptake per unit time interval

         RVADM = 0.000            // RVADM used only when using PFT (see end of Clin2) Factor 114
         XDSPA = 0.000            // MacPuf variable XDSPA  Factor Factor 115
         BAG = 0.0                // MacPuf variable BAG   Factor 116
         XMALE = 1.0              // XMALE Factor 117
         HT = 178.0               // HT  Factor 118
         WT = 70.0                // WT  Factor 119
         AGE = 40.0               // AGE Factor 120
        
        for i in 1...20 {
            TDLAY[i]=VO2CT
            TDLAY[i+20]=VC2CT
            TDLAY[i+40]=VC3MT
            TDLAY[i+60]=TC2PR
        }
    }
}
