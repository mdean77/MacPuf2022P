//
//  GetConstants.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/25/22.
//

import Foundation

extension Human {
    mutating func setConstants() {
        //var constants = [Double](repeating:0, count: 71)
        c1 = 1000.0/VBLVL
        c2 = 100.0/VBLVL
        c3 = 0.0203*HB
        c4 = (ELAST+105.0)*0.01
        //           C(5)=2.7/(VC+.4)
        //           C(6)=FEV*25.+29.
        //           C(7)=CONSO*PD*.00081*(TEMP-26.)**1.05
        //           C(8)=(30.-PEEP*5./ELAST)*.0016*CONOM*(TEMP-12.2)
        //           C(9)=(C(7)-CONSO)*.01
        //           C(10)=FT*.005
        //           C(11)=BARPR/SIMLT-1.2703*TEMP
        //           C(12)=C(11)*.003592/(273.+TEMP)
        //           C(13)=.9/TVOL
        //           C(14)=SHUNT+1.
        //           C(15)=2./WT
        //           C(16)=CO*.01
        //           C(17)=FT*10.
        //           C(18)=VADM*80.
        //           C(19)=(PD-90.)*RVADM*.05
        //           IF (C(19).LT.-1.) C(19)=-1.
        //           C(20)=650.*VC
        //           IF (BULLA.GT.0.) C(20)=C(20)+SQRT(BULLA)*15.
        //           C(21)=(40.-PEEP)*.025
        //           C(22)=4.5/FT
        //           C(23)=20.*SIMLT/BARPR
        //           C(24)=CONOM*.3
        //           C(25)=100.*C(12)
        //           C(26)=7./TVOL
        //           C(27)=FT*.1
        //           C(28)=30000./(VBLVL+1000.)
        //           C(29)=FT*.0039*WT**.425*HT**.725
        //           C(30)=520./TVOL
        //           C(31)=2.7/TVOL
        //           C(32)=C(29)+.0000001
        //           C(33)=C(3)*308.-TVOL*.65*C(30)
        //           C(34)=.004/(C(12)*FT)
        //           C(35)=.01/C(12)
        //           C(36)=7.7*C(13)
        //           C(37)=SPACE/FT
        //           C(38)=20./VLUNG
        //           C(39)=FT*.127
        //           C(40)=C(29)*(PD-25.)*1.3
        //           C(41)=FT*(TEMP-24.5)*1.82
        //           C(42)=.003*C(29)
        //           C(43)=1./(1.+7.7*C(3))
        //           X=(PD*.01)**.8*VC*.2
        //           C(44)=AZ*X*.0132
        //           C(45)=BZ*X*.008
        //           C(46)=CZ*.78*((C(7)*.00051)**.97+.01)
        //           X=.5+356./C(11)
        //           IF (X.GT.1.) X=1.
        //           C(47)=PR*.000214*(TEMP-29.)**1.5*X
        //           C(48)=.04*(TEMP-26.)*VC
        //           C(49)=9.+SQRT(ELAST*1.25)
        //           C(50)=(150.+PR)*.0275*(TEMP-17.)
        //           C(51)=RRATE*TIDVL*.001
        //           C(52)=VLUNG*.03-20.+BULLA
        //           C(53)=.8/FT
        //           C(54)=XDSPA*.001
        //           C(55)=.1/FT
        //           C(56)=.001/FT
        //           C(57)=FT*60.
        //           C(58)=FT*1.27
        //           C(59)=FT*.3
        //           C(60)=FT*.008
        //           C(61)=.22/FT
        //           C(62)=FT*240000./(CZ+300.)
        //           C(63)=FT*C(7)*.12
        //           C(64)=.01488*HB*(TVOL+VBLVL*.001)
        //           C(65)=7.324-CZ*.00005
        //           C(66)=C(65)-.002
        //           C(67)=CZ-30.
        //           C(68)=FT*3000./(PD+200.)
        //           C(69)=(FITNS-20.)*.00035
        //           C(70)=C(29)*1.3
        //return constants
    }
    
}
