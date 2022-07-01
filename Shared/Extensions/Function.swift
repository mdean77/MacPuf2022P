//
//  Function.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 6/30/22.
//

import Foundation

//SUBROUTINE FUNCTN(EN,OU,FUN,NBP)
//C+
//C+
//C THIS SUBROUTINE,CREATES AN OU=F(EN) FUNCTION OUT OF A NUMBER OF NBP
//C POINTS WHICH ARE INITIALIZED IN DATASET FUN IN THE MAIN PROGRAM
//C+
//C+
//DIMENSION FUN(20)
//NL0=NBP-1
//NL1=NBP*2-1
//NL2=NBP*2
//if(EN.LT.FUN(1)) GO TO 30
//if(EN.GE.FUN(NL1)) GO TO 40
//DO 10 I=1,NL0
//   L = 2*I-1
//   if(EN.GE.FUN(L) .AND. EN.LT.FUN(L+2))GO TO 20
//10 CONTINUE
//20 OU = FUN(L+1) + ( (FUN(L+3)-FUN(L+1)) / (FUN(L+2)-FUN(L)) )*(EN-FUN(L)
//X )
//GO TO 50
//30 OU = FUN(2)
//GO TO 50
//40 OU = FUN(NL2)
//50 CONTINUE
//RETURN
//END

///  This routine accepts an array of x,y variables in FUN and then checks the low and high X values
///  and returns the corresponding y.  If x is intermediate then it does an extrapolation.
///  FUN may be one of three different arrays of values that were experimentally obtained:
///  FUN1 is for tissue RQ calculations
///  FUN2 is used for muscle lactate catabolism
///  FUN3 is for work rate-efficiency relationship.
///  VERIFIED correctness in a Playground.
///
extension Human {
    func FUNCTN(_ EN:Double, _ FUN:[Double], _ NBP:Int) -> Double{
        let NL0 = NBP - 1
        let NL1 = NBP * 2 - 1
        let NL2 = NBP * 2
        if EN < FUN[1] {
            return FUN[2]
        }
        if EN > FUN[NL1] {
            return FUN[NL2]
        }
        for i in 1...NL0 {
            if EN >= FUN[2 * i - 1] && EN < FUN[2 * i + 1]{
                let L = 2 * i - 1
                return FUN[L+1] + (FUN[L+3]-FUN[L+1])/(FUN[L+2]-FUN[L])*(EN-FUN[L])
            }
        }
        print("Error in function FUNCTN")
        return 0
    }
}
