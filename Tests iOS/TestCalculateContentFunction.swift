//
//  TestCalculateContentFunction.swift
//  Tests iOS
//
//  Created by J Michael Dean on 6/25/22.
//

import XCTest
@testable import MacPuf2022P

/// This class contains tests for the GASES routine from the MacPuf program.
///
/// The gold standard for assertions is the original FORTRAN executable, which may
/// not represent the best real-world accuracy.
class TestCalculateContentFunction: XCTestCase {
    var human = Human()

    /// This tests the oxygen content calculation routine in isolation of the rest of the MacPuf simulation.  I am using output from
    /// the FORTRAN version last edited by George Havenith (version 17 December 1981.
    ///
    ///The accuracy of the function is limited in the steepest part of the oxyhemoglobin dissociation curve but is still reasonable.
    ///In the normal physiologic range, it is accurate to within 0.01.
    func test_Contents_pO2() throws {
        
        var o2Content = human.calculateContents(pO2: 94.2, pCO2: 39.9, pH: 7.398).oxygenContent
        XCTAssertEqual(o2Content, 19.5, accuracy: 0.1)
        
        o2Content = human.calculateContents(pO2: 94.5, pCO2: 40.1, pH: 7.3999).oxygenContent
        XCTAssertEqual(o2Content, 19.5, accuracy: 0.1)
        
        o2Content = human.calculateContents(pO2: 52.3, pCO2: 36.4, pH: 7.419).oxygenContent
        XCTAssertEqual(o2Content, 17.5, accuracy: 0.1)
        
        o2Content = human.calculateContents(pO2: 48.5, pCO2: 35.2, pH: 7.428).oxygenContent
        XCTAssertEqual(o2Content, 17.0, accuracy: 0.1)

        o2Content = human.calculateContents(pO2: 33.7, pCO2: 42.5, pH: 7.401).oxygenContent
        XCTAssertEqual(o2Content, 12.7, accuracy: 0.1)
        
        o2Content = human.calculateContents(pO2: 28.7, pCO2: 52.8, pH: 7.335).oxygenContent
        XCTAssertEqual(o2Content, 9.99, accuracy: 0.1)
        
        o2Content = human.calculateContents(pO2: 28.72, pCO2: 52.84, pH: 7.331).oxygenContent
        XCTAssertEqual(o2Content, 9.99, accuracy: 0.15)
        
        o2Content = human.calculateContents(pO2: 23.0, pCO2: 52.6, pH: 7.335).oxygenContent
        XCTAssertEqual(o2Content, 7.5, accuracy: 0.1)
        
        o2Content = human.calculateContents(pO2: 24.3, pCO2: 52.5, pH: 7.335).oxygenContent
        XCTAssertEqual(o2Content, 8.1, accuracy: 0.1)
        
        o2Content = human.calculateContents(pO2: 17.8, pCO2: 52.9, pH: 7.339).oxygenContent
        XCTAssertEqual(o2Content, 5.1, accuracy: 0.1)
    }

    func test_Saturations() throws {
        var saturation = human.calculateContents(pO2: 94.2, pCO2: 39.9, pH: 7.40).oxygenSaturation
        XCTAssertEqual(saturation, 0.97, accuracy: 0.01)
        saturation = human.calculateContents(pO2: 83.3, pCO2: 39.5, pH: 7.40).oxygenSaturation
        XCTAssertEqual(saturation, 0.96, accuracy: 0.01)
        saturation = human.calculateContents(pO2: 80.6, pCO2: 39.2, pH: 7.40).oxygenSaturation
        XCTAssertEqual(saturation, 0.96, accuracy: 0.01)
        saturation = human.calculateContents(pO2: 69.0, pCO2: 38.1, pH: 7.41).oxygenSaturation
        XCTAssertEqual(saturation, 0.94, accuracy: 0.01)
        saturation = human.calculateContents(pO2: 67.6, pCO2: 37.7, pH: 7.412).oxygenSaturation
        XCTAssertEqual(saturation, 0.94, accuracy: 0.01)
        saturation = human.calculateContents(pO2: 35.7, pCO2: 34, pH: 7.44).oxygenSaturation
        XCTAssertEqual(saturation, 0.70, accuracy: 0.01)
        saturation = human.calculateContents(pO2: 27.2, pCO2: 32, pH: 7.45).oxygenSaturation
        XCTAssertEqual(saturation, 0.54, accuracy: 0.01)
        saturation = human.calculateContents(pO2: 443, pCO2: 32, pH: 7.40).oxygenSaturation
        XCTAssertEqual(saturation, 1.0, accuracy: 0.01)
    }
    
    /// This tests the content calculation routine in isolation of the rest of the MacPuf simulation.  I am using output from
    /// the FORTRAN version last edited by George Havenith (version 17 December 1981.
    ///
    ///The accuracy of the function is limited in the upper ranges of CO2 values.  This makes sense upon examining the curves
    ///in the boook on page 35.  The accuracy is certainly sufficient for our purposes.
    func test_Contents_pCO2() throws {

        var co2Content = human.calculateContents(pO2: 94.2, pCO2: 39.9, pH: 7.398).carbonDioxideContent
        XCTAssertEqual(co2Content, 47.3, accuracy: 0.1)
        
        co2Content = human.calculateContents(pO2: 94.5, pCO2: 40.1, pH: 7.3999).carbonDioxideContent
        XCTAssertEqual(co2Content, 47.5, accuracy: 0.3)
        
        co2Content = human.calculateContents(pO2: 52.3, pCO2: 36.4, pH: 7.419).carbonDioxideContent
        XCTAssertEqual(co2Content, 45.3, accuracy: 0.2)
        
        co2Content = human.calculateContents(pO2: 48.5, pCO2: 35.2, pH: 7.428).carbonDioxideContent
        XCTAssertEqual(co2Content, 44.6, accuracy: 0.3)

        co2Content = human.calculateContents(pO2: 33.7, pCO2: 42.5, pH: 7.401).carbonDioxideContent
        XCTAssertEqual(co2Content, 50.5, accuracy: 1)
        
        co2Content = human.calculateContents(pO2: 28.7, pCO2: 52.8, pH: 7.331).carbonDioxideContent
        XCTAssertEqual(co2Content, 56.7, accuracy: 1.5)
        
        co2Content = human.calculateContents(pO2: 23.0, pCO2: 52.6, pH: 7.335).carbonDioxideContent
        XCTAssertEqual(co2Content, 56.8, accuracy: 1.5)
    }
    
}
