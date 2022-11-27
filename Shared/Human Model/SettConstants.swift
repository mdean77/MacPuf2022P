//
//  GetConstants.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/25/22.
//

import Foundation

extension Human {
    mutating func setConstants() {
        c1 = 1000.0/VBLVL
        c2 = 100.0/VBLVL
        c3 = 0.0203*HB
        c4 = (ELAST+105.0)*0.01
        c5 = 2.7/(VC+0.4)
        c6 = FEV*25.0+29.0
        //c7 = CONSO*PD*0.00081*(TEMP-26.0)**1.05
        c7 = CONSO * PD * 0.00081 * pow(TEMP-26.0, 1.05)
        c8 = (30.0-PEEP*5.0/ELAST)*0.0016*CONOM*(TEMP-12.2)
        c9 = (c7-CONSO)*0.0067
        c10 = FT*0.005
        c11 = BARPR/SIMLT - 0.03 * TEMP * TEMP - 5.92
        c12 = c11*0.003592/(273.0+TEMP)
        c13 = 0.9/TVOL
        c14 = SHUNT+1.0
        c15 = 2.0/WT
        c16 = CO*0.01
        c17 = FT*10.0
        c18 = VADM*80.0
        c19 = (PD-90.0)*RVADM*0.05
        //IF (c19.LT.-1.0) c19 = -1.0
        if c19 < -1.0 {c19 = -1.0}
        c20 = 650.0*VC
        //IF (BULLA.GT.0.0) c20 = c20+SQRT(BULLA)*15.0
        if BULLA > 0.0 {c20 = c20 + sqrt(BULLA) * 15.0}
        c21 = (40.0-PEEP)*0.025
        c22 = 4.5/FT
        c23 = 20.0*SIMLT/BARPR
        c24 = CONOM*0.3
        c25 = 100.0*c12
        c26 = 7.0/TVOL
        c27 = FT*0.1
        c28 = 30000.0/(VBLVL+1000.0)
        //c29 = FT*0.0039*WT**0.425*HT**0.725
        c29 = FT * 0.0039 * pow(WT, 0.425) * pow(HT, 0.725)
        c30 = 520.0/TVOL
        c31 = 2.7/TVOL
        c32 = c29+0.0000001
        c33 = c3*308.0-TVOL*0.65*c30
        c34 = 0.004/(c12*FT)
        c35 = 0.01/c12
        c36 = 7.7*c13
        c37 = SPACE/FT
        c38 = 20.0/VLUNG
        c39 = FT*0.127
        c40 = c29*(PD-25.0)*1.3
        c41 = FT*(TEMP-24.5)*1.82
        c42 = 0.003*c29
        c43 = 1.0/(1.0+7.7*c3)
        // X=(PD*0.01)**0.8*VC*0.2
        var X = pow(PD * 0.01,0.8) * VC * 0.2
        c44 = AZ*X*0.0132
        c45 = BZ*X*0.008
        //c46 = CZ*0.78*((c7*0.00051)**0.97+0.01)
        c46 = CZ * 0.78 * (pow(c7 * 0.00051, 0.97) + 0.01)
        X=0.5+356.0/c11
        //IF (X.GT.1.0) X = 1.0
        if X > 1.0 {X = 1.0}
        //c47 = PR*0.000214*(TEMP-29.0)**1.5*X
        c47 = PR * 0.000214 * pow(TEMP - 29.0, 1.5) * X
        c48 = 0.04*(TEMP-26.0)*VC
        c49 = 9.0+sqrt(ELAST*1.25)
        c50 = (150.0+PR)*0.0275*(TEMP-17.0)
        c51 = RRATE*TIDVL*0.001
        c52 = VLUNG*0.03-20.0+BULLA
        c53 = 0.8/FT
        c54 = XDSPA*0.001
        c55 = 0.1/FT
        c56 = 0.001/FT
        c57 = FT*60.0
        c58 = FT*1.27
        c59 = FT*0.3
        c60 = FT*0.008
        X = pow(PD * 0.01, 1.45)
        if X > 12.0 { X = 12.0}
        c61 = 0.00025 * RCOAJ/(FT * X)
        c62 = FT*240000.0/(CZ+300.0)
        c63 = FT*c7*0.12
        c64 = 0.01488*HB*(TVOL+VBLVL*0.001)
        c65 = 7.324-CZ*0.00005
        c66 = c65-0.002
        c67 = CZ-30.0
        c68 = FT*1500.0/(PD+200.0)
        c69 = (FITNS-20.0)*0.00035
        c70 = c29*1.3
        c71 = 21.7 + XMALE * 1.6
        c72 = FT * 0.002
        X = (PD * 1.5 - 150.0) * 0.02 - 7.0
        if X < -7.0 {X = -7.0}
        if X > 0 {X = 0}
        c73 = FITNS + X
        c74 = 210.0 - 0.65 * AGE
        c75 = (1.5 + XMALE * 0.2 + (33.0 - FITNS)/10.0) * WT * c16
    }
}
