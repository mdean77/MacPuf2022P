//
//  Human.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/25/22.
//

import Foundation

struct Human {
    //MARK: Initialization
    // New organization - returning to original FORTRAN variables and initialization
       var FIO2 = 20.93000                         // MacPuf variable FIO2   Factor 1
       var FIC2 = 0.0300                           // MacPuf variable FIC2   Factor 2
       var CO = 100.000                            // MacPuf variable CO        Factor 3
       var PD = 100.0                              // PD  Factor 4
       var FADM = 0.0                              // MacPuf variable FADM        Factor 5
       var BULLA = 0.0000                          // MacPuf variable BULLA  Factor 6
       var VLUNG = 3000.000                        // MacPuf variable VLUNG  Factor 7
       var ELAST = 5.0000                          // MacPuf variable ELAST  Factor 8
       var VADM = 3.0                              // MacPuf variable VADM        Factor 9
       var AZ = 100.000                            // MacPuf variable      Factor 10
       var BZ = 100.000                            // MacPuf variable BZ      Factor 11
       var CZ = 100.000                            // MacPuf variable CZ     Factor 12
       var BARPR = 760.0                           // BARPR  Factor 13
       var TEMP = 37.0                             // TEMP Factor 14
       var TRQ = 0.8000                            // TRQ   Factor 15
       var TC2MT = 13.3736                         // TC2MT Factor 16
       var TVOL = 12.0000                          // TVOL Factor 17
       var HB = 14.8                               // HB  Factor 18
       var PCV = 45.0                              // PCV Factor 19
       var VBLVL = 3000.00                         // MacPuf variable VBLVL  Factor 20
       var ADDC3 = 0.0                             // MacPuf variable ADDC3  Factor 21
       var BC3AJ = 0.0                             //BC3AJ Factor 22
       var DPG = 3.8                               // DPG Factor 23
       var PR = 100.0                              //  PR  Factor 24  - same as ventilatory coupling
       var FITNS = 33.0                            // FITNS  Factor 25
       var SPACE = 0.4000                          // % of respiratory cycle spent in inspiration SPACE Factor 26
       var COMAX = 35.0000                         // MacPuf variable COMAX    Factor 27
       var SHUNT = 0.0                             // MacPuf variable SHUNT    Factor 28
       var VC = 5.0000                             // MacPuf variable VC     Factor 29
       var PEEP = 0.0                              // PEEP  Factor 30
       var VO2CT = 14.56                           // VO2CT  Factor 31
       var RCOAJ = 100.0                           // Factor 32
       var RPH = 7.4                               // MacPuf variable RPH    Factor 33
       var VPH = 7.37                              // VPH Factor 34
       var FVENT = 4.26                            // MacPuf variable FVENT  Factor 35
       var BPH = 7.33                              // BPH  Factor 36
       var BAGO = 0.0                              // MacPuf variable BAGO  Factor 37
       var BAGC = 0.0                              // MacPuf variable BAGC  Factor 38
       var AO2MT = 348.1                           // MacPuf variable AO2MT  Factor 39
       var AC2MT = 143.3                           // MacPuf variable AC2MT  Factor 40
       var AO2PR = 101.9                           // MacPuf variable AO2PR  Factor 41
       var AC2PR = 39.75                           // MacPuf variable AC2PR  Factor 42
       var DPH = 7.40                              // DPH Factor 43
       var XLACT = 0.0                             // XLACT Factor 44
       var BO2PR = 28.89                           // BO2PR  Factor 45
       var BC2PR = 52.8                            // BC2PR  Factor 46
       var TIDVL = 461.9                           // MacPuf variable TIDVL  Factor 47
       var RRATE = 12.82                           // MacPuf variable RRATE  Factor 48
       var RO2CT = 19.54                           // MacPuf variable RO2CT  Factor 49
       var VC2MT = 1540.0                          // VC2MT  Factor 50
       var DVENT = 5.92                            // MacPuf variable DVENT  Factor 51
       var SVENT = 5.92                            // MacPuf variable SVENT  Factor 52
       var PC2CT = 47.25                           // MacPuf variable PC2CT  Factor 53
       var PO2CT = 19.66                           // MacPuf variable PO2CT  Factor 54
       var TO2CT = 14.47                           // TO2CT Factor 55
       var TC2CT = 51.4                            // TC2CT Factor 56
       var BO2CT = 10.05                           // BO2CT  Factor 57
       var BC2CT = 56.62                           // BC2CT  Factor 58
       var TPH = 7.37                              // TPH Factor 59
       var RC3CT = 23.82                           // MacPuf variable RC3CT  Factor 60
       var VC2CT = 51.33                           // VC2CT  Factor 61
       var RO2MT = 195.44                          // MacPuf variable RO2MT  Factor 62
       var RC2MT = 473.5                           // MacPuf variable RC2MT  Factor 63
       var XRESP = 10.99                           // XRESP Factor 64
       var AN2MT = 1987.0                          // MacPuf variable AN2MT  Factor 65
       var BO2MT = 18.06                           // BO2MT  Factor 66
       var BC2MT = 677.0                           // BC2MT  Factor 67
       var CBF = 51.94                             // CBF   Factor 68
       var PC  = 0.80                              // PC Factor 69 0.7993?
       var DSPAC = 129.2                           // MacPuf variable DSPAC  Factor 70
       var REFLV = 3000.000                        // MacPuf variable REFLV  Factor 71
       var RO2PR = 94.18                           // MacPuf variable RO2PR  Factor 72
       var CONSO = 240.000                         // CONSO Factor 73
       var RC2PR = 39.9                            // MacPuf variable RC2PR  Factor 74
       var PG = 0.0                                // PG Factor 75 0.00?
       var PJ = 97.13                              // PJ Factor 76 97.0730 ??
       var TND = -10.0                             // TND Factor 77 0.0851 ??   MARK: 0.0851  was in new version
       var RC2CT = 47.35                           // MacPuf variable RC2CT  Factor 78
       var QB = 33.29                              // QB Factor 79   MARK: 199.5492 in old version
       var PW = 2.3618                             // MacPuf variable PW        Factor 80
       var FT = 0.016667                           // FT Factor 81 = 1/60
       var CONOM = 4.6000                          // MacPuf variable CONOM    Factor 82
       var BUBBL = 0.000                           // BUBBL Factor 83
       var TC2RF = 45.43                           // TC2RF Factor 84
       var TC3MT = 318.0                           // TC3MT Factor 85
       var VC3MT = 71.55                           // VC3MT  Factor 86
       var TC3CT = 25.48                           // TC3CT Factor 87
       var VC3CT = 25.48                           // VC3CT  Factor 88
       var TLAMT = 34.63                           // TLAMT  Factor 89
       var RLACT = 0.99                            // MacPuf variable RLACT  Factor 90
       var BC3CT = 22.7000                         // BC3CT   Factor 91
       var BO2AD = 1.0                             // BO2AD  Factor 92  var oxygenationIndex = 1.000 ???
       var COADJ = 5.01                            // MacPuf variable COADJ    Factor 93
       var EO2CT = 19.54                           // MacPuf variable EO2CT  Factor 94
       var TO2MT = 178.4                           // TO2MT Factor 95
       var TO2PR = 40.13                           // TO2PR Factor 96
       var TC2PR = 45.43                           // TC2PR Factor 97
       var VO2MT = 437.0                           // VO2MT  Factor 98
       var AVENT = 710.8                           // AVENT Factor 99  MARK: old value 366.3107
       var PL = 0.0                                // PL Factor 100
       var EC2CT = 47.35                           // MacPuf variable EC2CT  Factor 101
       var TN2MT = 76.07                           // TN2MT - Amount in fast Factor 102
       var TN2PR = 571.1                           // TN2PR - Fast equilibrating store Factor 103
       var FEV = 4.0                               // MacPuf variable FEV      Factor 104
       var SN2PR = 564.0                           // SN2PR - Slow equilibraint store Factor 105
       var RN2CT = 0.73                            // MacPuf same as EN2CT Factor  Factor 106
       var UN2MT = 0.0                             // UN2MT Factor 107
       var RN2MT = 7.26                            // MacPuf variable RN2MT  Factor 108
       var HRATE = 70.0                            // HRATE Factor 109  Heart rate
       var STRVL = 70.0                            // STRVL Factor 110  Stroke Volume
       var TC3AJ = -0.03                           // TC3AJ Factor 111
       var SN2MT = 967.0                           // SN2MT - Amount in slow Factor 112
       var QA = 41.61                              // QA Factor 113
       var RVADM = 0.000                           // RVADM used only when using PFT (see end of Clin2) Factor 114
       var XDSPA = 0.000                           // MacPuf variable XDSPA  Factor Factor 115
       var BAG = 0.0                               // MacPuf variable BAG   Factor 116
       var XMALE = 1.0                             // XMALE Factor 117
       var HT = 178.0                              // HT  Factor 118
       var WT = 70.0                               // WT  Factor 119
       var AGE = 40.0                              // AGE Factor 120
        
    mutating func simulate(cycle:Int, iterations:Int){
        
        
        if cycle == iterations {
            ADDC3 = 0
        }
    }
}
