//
//  DebugConsoleOutput.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/27/22.
//

import Foundation

extension Simulator {
    func cycleReport() -> String{
        // Returns a string for single line of output
        let scale = 120.0
        let lineWidth = 72.0
        let factor = lineWidth/scale
        let po2 = human.RO2PR < scale ? Int(human.RO2PR*factor) : Int(lineWidth)
        let pco2 = human.RC2PR < scale ? Int(human.RC2PR*factor) : Int(lineWidth)
        let vent = Int(human.DVENT*factor)  // Replace with lungs.totalVentilation when I have lungs
        let rate = Int(human.RRATE*factor)  // Replace with lungs.respiratoryRate when I have lungs
        
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        var temp = String(repeating: " ", count: 73)
        
        let oxygenIndex = temp.index(temp.startIndex, offsetBy:po2)
        let carbonDioxideIndex = temp.index(temp.startIndex, offsetBy:pco2)
        let rateIndex = temp.index(temp.startIndex, offsetBy: rate)
        let ventIndex = temp.index(temp.startIndex, offsetBy: vent)
        
        temp.replaceSubrange(oxygenIndex...oxygenIndex, with:"O")
        temp.replaceSubrange(carbonDioxideIndex...carbonDioxideIndex, with:"C")
        temp.replaceSubrange(rateIndex...rateIndex, with:"F")
        temp.replaceSubrange(ventIndex...ventIndex, with:"V")
        let result = String(format:"%4d:%2d     ",minutes, seconds).appending(temp)
        return(result)
    }
    
    func runReport()->String{
        // This prints description after the iterations have been run
        let x = 10*pow(2,(8.0 - human.RPH)*3.33)
        let result = String(format:"\nFinal values for this run were...\n\n")
        let result1 = String(format:"Arterial pO2 = %6.1f              O2 Cont =%6.1f      O2 Sat = %5.1f%%\n",human.RO2PR, human.RO2CT,human.PJ)
        let result2 = String(format:"Arterial pCO2 = %5.1f              CO2 Cont =%6.1f\n",human.RC2PR,human.RC2CT)
        let result3 = String(format:"Arterial pH = %7.2f (%3.1f nm)    Arterial bicarbonate = %5.1f\n\n",human.RPH,x,human.RC3CT)
        let result4 = String(format:"Respiratory rate =  %5.1f          Tidal vol.= %6.0f ml\n", human.RRATE, human.TIDVL)
        let result5 = String(format:"Total ventilation = %5.1f l/min    Actual cardiac output = %4.1f l/min\n",human.DVENT, human.COADJ)
        let result6 = String(format:"Total dead space =   %4.0f ml       Actual venous admixture = %3.1f%%\n",human.DSPAC,human.PW)
        let result7 = String(format:"Cardiac output =    %5.1f l/min    Cerebral blood flow = %5.1f ml/100g/min\n", human.COADJ, human.CBF)
        let result8 = String(format:"Heart rate =        %5.1f          Stroke volume = %5.1f ml\n", human.HRATE, human.STRVL)
        return result + result1 + result2 + result3 + result4 + result5 + result6 + result7 + result8
    }
    
    
    func dumpFirstSixParametersReport() -> String {
        // Print out first 6 changeable parameters
        
        let result = String(format:"\nList of first six parameters:\n     Inspired O2 %%:%6.1f\n     Inspired CO2 %%:%6.2f\n     Cardiac performance %% of normal:%7.2f\n     Metabolic rate %% of normal:%7.2f\n     Extra anatomic right to left shunt:%6.2f\n     Extra dead space:%6.2f",human.FIO2,human.FIC2,human.CO,human.PD,human.FADM, human.BULLA)
        return result;
    }
    
    func inspectionReport()->String{
        let header = String(format:"\nTime         P.Pressures     Contents cc/dl  Amounts in cc  pH    HCO3-\n%4d secs     O2     CO2      O2     CO2       O2     CO2", totalSeconds+1)
        
        let artString = String(format:"\nArterial %8.1f%8.1f%8.1f%8.1f%8.0f%8.0f%7.3f%6.1f",
                               human.RO2PR, human.RC2PR,human.RO2CT,human.RC2CT,human.RO2MT,human.RC2MT,human.RPH,human.RC3CT)
        let result1 = String(format:"\nAlv./Lung%8.1f%8.1f    (Sat = %4.1f%%) %6.0f%8.0f",human.AO2PR, human.AC2PR,human.PJ,human.AO2MT,human.AC2MT)
        let result2 = String(format:"\n(Pulm.cap)%7.1f%8.1f%8.1f%8.1f",human.AO2PR, human.AC2PR,human.PO2CT,human.PC2CT)
        let lungString = result1 + result2
        let brainString = String(format:"\nBrain/CSF%8.1f%8.1f%8.1f%8.1f%8.0f%8.0f%7.3f%6.1f",human.BO2PR, human.BC2PR,human.BO2CT, human.BC2CT,human.BO2MT,human.BC2MT,human.BPH,human.BC3CT + human.BC3AJ)
        
        let tissueString = String(format:"\nTissue/ECF%7.1f%8.1f%8.1f%8.1f%8.0f%8.0f%7.3f%6.1f",human.TO2PR, human.TC2PR,human.TO2CT, human.TC2CT,human.TO2MT, human.TC2MT*1000, human.TPH, human.TC3CT)
        let veinString = String(format:"\nMixed Ven. (same as tissue)%6.1f%8.1f%8.0f%8.0f%7.3f%6.1f",human.VO2CT, human.VC2CT, human.VO2MT, human.VC2MT, human.TPH, human.TC3CT)
        let lactateString = String(format:"\nPlasma lactate conc.= %4.2f mmol/l\n", human.RLACT)
        let inspiratoryTime = 60 * human.SPACE/human.RRATE
        let ieRatio = human.SPACE/(1 - human.SPACE)
        let ventilatorString = human.NARTI == 1 ? "" :
        String(format:"\nVentilator on. PEEP = %2.0f    Inspiratory time = %4.1f secs   I:E = %4.2f",human.PEEP, inspiratoryTime, ieRatio)
        let bagString = human.PL == 0 ? "" : String(format:"\nDouglas bag connected. Volume = %4.0f ml, O2 = %4.0f ml, CO2 = %4.0f ml\n", human.BAG, human.BAGO, human.BAGC)
        let result3 = String(format:"\nTot. vent = %4.1f  Alv. vent (BTPS) = %4.1f Resp. rate = %4.1f  Ven. admixture = %3.1f",human.DVENT, human.FVENT, human.RRATE, human.PW)
//        let result4 = String(format:"\nO2 uptake = %4.1f  CO2 output = %4.1f cc/min(STPD)   Expired R.Q. = %4.2f", human.QA/human.c17, human.QB/human.c17, human.PC)
        let result4 = String(format:"\nO2 uptake = %4.1f  CO2 output = %4.1f cc/min(STPD)   Expired R.Q. = %4.2f", human.QA/human.FT, human.QB/human.FT, human.PC)
        let result5 = String(format:"\nDead space (BTPS) = %4.1f   Tidal vol. = %5.1f  D. space/TVOL = %4.2f\n", human.DSPAC, human.TIDVL, human.DSPAC/(human.TIDVL + 0.000001))
        let result6 = String(format:"Cardiac output = %5.1f l/min    Cerebral blood flow = %5.1f ml/100g/min\n", human.COADJ, human.CBF)
        let result7 = String(format:"Heart rate =  %5.1f   Stroke volume = %5.1f ml\n", human.HRATE, human.STRVL)
        let result = header + artString + lungString + brainString + tissueString + veinString + lactateString +  ventilatorString + bagString + result4 + result3 + result5 + result6 + result7
        return(result)
    }
    func dumpAllParametersReport() -> String{
        let row1 =  String(format:"\n%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f",
               human.FIO2,human.FIC2,human.CO,human.PD,human.FADM,human.BULLA,
               human.VLUNG,human.ELAST,human.VADM,human.AZ)
        let row2 =  String(format:"\n%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f",human.BZ,human.CZ,human.BARPR,human.TEMP,human.TRQ,human.TC2MT,human.TVOL,human.HB,human.PCV,human.VBLVL)
        let row3 =  String(format:"\n%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f",human.ADDC3,human.BC3AJ,human.DPG,human.PR,human.FITNS,human.SPACE,human.COMAX,human.SHUNT,human.VC,human.PEEP)
        let row4 =  String(format:"\n%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f",human.VO2CT,human.RCOAJ,human.RPH,human.VPH,human.FVENT,human.BPH,human.BAGO,human.BAGC,human.AO2MT,human.AC2MT)
        let row5 =  String(format:"\n%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f",human.AO2PR,human.AC2PR,human.DPH,human.XLACT,human.BO2PR,human.BC2PR,human.TIDVL,human.RRATE,human.RO2CT,human.VC2MT)
        let row6 =  String(format:"\n%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f",human.DVENT,human.SVENT,human.PC2CT,human.PO2CT,human.TO2CT,human.TC2CT,human.BO2CT,human.BC2CT,human.TPH,human.RC3CT)
        let row7 =  String(format:"\n%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f",human.VC2CT,human.RO2MT,human.RC2MT,human.XRESP,human.AN2MT,human.BO2MT,human.BC2MT,human.CBF,human.PC,human.DSPAC)
        let row8 =  String(format:"\n%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f",human.REFLV,human.RO2PR,human.CONSO,human.RC2PR,human.PG,human.PJ,human.TND,human.RC2CT,human.QB,human.PW)
        let row9 =  String(format:"\n%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f",human.FT,human.CONOM,human.BUBBL,human.TC2RF,human.TC3MT,human.VC3MT,human.TC3CT,human.VC3CT,human.TLAMT,human.RLACT)
        let row10 =  String(format:"\n%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f",human.BC3CT,human.BO2AD,human.COADJ,human.EO2CT,human.TO2MT,human.TO2PR,human.TC2PR,human.VO2MT,human.AVENT,human.PL)
        let row11 =  String(format:"\n%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f",human.EC2CT,human.TN2MT,human.TN2PR,human.FEV,human.SN2PR,human.EN2CT,human.UN2MT,human.RN2MT,human.HRATE,human.STRVL)
        let row12 =  String(format:"\n%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f%8.2f",human.TC3AJ,human.SN2MT,human.QA,human.RVADM,human.XDSPA,human.BAG,human.XMALE,human.HT,human.WT,human.AGE)

        return row1+row2+row3+row4+row5+row6+row7+row8+row9+row10+row11+row12
    }
    
    func reportOut(title: String){
        print(title)
        print(runReport())
        print(inspectionReport())
        print(dumpFirstSixParametersReport())
        print(dumpAllParametersReport())
    }
    
}
