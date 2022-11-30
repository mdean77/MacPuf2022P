MacPUF: A Simulation of Human Respiration, Gas Exchange and Control

This project is an adaptation of MacPUF, originally published in 1977 by C.J. Dickinson.  This was a FORTRAN program used by medical students and physiology researchers to simulate human respiration, gas exchange and control on a time sharing computer system.  I translated this program into BASIC in 1980, and subsequently had the ambition to translate it into C to make it able to run on early Macintosh computers.  I subsequently translated the main model into Objective C, targeting the Macintosh (iOS did not exist at that time in 2001 - 2004).  Alas, for time reasons, this project has been delayed until the present, when I have successfully ported the program to run on iOS platforms using SwiftUI. My goal is for the application to run on iOS and MacOS.

To preserve the legacy of this program, I have included the original FORTRAN source code for the reader's interest.

The current (November 2022) code base successfully executes on iPhones;  I have not fleshed out the iPad platform and have not begun work on the MacOS version.

The evolution of computer performance is astounding.  The original program processed 10 iterations per second on a PDP 11/45 with a floating point processor in 1977;  my iPhone processes 100,000 iterations per second.  I may institute a time delay in the output because part of the charm of the educational experience was to see the effects of user interactions play out through the teletype machines;  the iPhone version is instantaneous and the user may not realize that the simulator has executed their intervention! 
