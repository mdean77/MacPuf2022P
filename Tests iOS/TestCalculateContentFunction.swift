//
//  TestCalculateContentFunction.swift
//  Tests iOS
//
//  Created by J Michael Dean on 6/25/22.
//

import XCTest
@testable import MacPuf2022P

class TestCalculateContentFunction: XCTestCase {
    
    func test_Contents_pO2() throws {
        /// This unit test is testing the routine IN ISOLATION of the rest of the MacPuf simulation, and I have used output from MacPuf
        /// as the so-called gold standard for the correct answers.  For this reason, I have adjusted the required accuracy for passing
        /// these tests, given that when I stick this function into the main runtime, the integration tests might reveal why there are some
        /// differences.
        ///
        var o2Content = calculateContents(pO2: 94.2, pCO2: 39.9, pH: 7.40).oxygenContent  // 1    19.5
        XCTAssertEqual(o2Content, 19.5, accuracy: 0.2, "Case 1 oxygen content failed.")
        o2Content = calculateContents(pO2: 107.5, pCO2: 35.1, pH: 7.40).oxygenContent     // 2    19.8
        XCTAssertEqual(o2Content, 19.8, accuracy: 0.2, "Case 2 oxygen content failed.")
        o2Content = calculateContents(pO2: 29.0, pCO2: 52.8, pH: 7.33).oxygenContent      // 3    10.1
        XCTAssertEqual(o2Content, 10.1, accuracy: 0.2, "Case 3 oxygen content failed.")
        o2Content = calculateContents(pO2: 83.3, pCO2: 39.5, pH: 7.40).oxygenContent      // 4    19.3
        XCTAssertEqual(o2Content, 19.3, accuracy: 0.2, "Case 4 oxygen content failed.")
        o2Content = calculateContents(pO2: 28.0, pCO2: 52.8, pH: 7.332).oxygenContent     // 5    9.7
        XCTAssertEqual(o2Content, 9.7, accuracy: 0.2, "Case 5 oxygen content failed.")
        o2Content = calculateContents(pO2: 39.6, pCO2: 45.0, pH: 7.375).oxygenContent     // 6    14.4
        XCTAssertEqual(o2Content, 14.4, accuracy: 0.2, "Case 6 oxygen content failed.")
        o2Content = calculateContents(pO2: 80.6, pCO2: 39.2, pH: 7.40).oxygenContent      // 7    19.3
        XCTAssertEqual(o2Content, 19.3, accuracy: 0.2, "Case 7 oxygen content failed.")
        o2Content = calculateContents(pO2: 69.0, pCO2: 38.1, pH: 7.41).oxygenContent      // 8    18.9
        XCTAssertEqual(o2Content, 18.9, accuracy: 0.2, "Case 8 oxygen content failed.")
        o2Content = calculateContents(pO2: 25.7, pCO2: 52.6, pH: 7.334).oxygenContent     // 9    8.7
        XCTAssertEqual(o2Content, 8.7, accuracy: 0.2, "Case 9 oxygen content failed.")
        o2Content = calculateContents(pO2: 38.3, pCO2: 44.6, pH: 7.375).oxygenContent     // 10   14.3
        XCTAssertEqual(o2Content, 14.3, accuracy: 0.35, "Case 10 oxygen content failed.")
        o2Content = calculateContents(pO2: 67.6, pCO2: 37.7, pH: 7.412).oxygenContent     // 11   18.8
        XCTAssertEqual(o2Content, 18.8, accuracy: 0.2, "Case 11 oxygen content failed.")
        o2Content = calculateContents(pO2: 24.3, pCO2: 52.5, pH: 7.335).oxygenContent     // 12   8.1
        XCTAssertEqual(o2Content, 8.1, accuracy: 0.2, "Case 12 oxygen content failed.")
        o2Content = calculateContents(pO2: 37.7, pCO2: 43.8, pH: 7.379).oxygenContent     // 13   14.1
        XCTAssertEqual(o2Content, 14.1, accuracy: 0.3, "Case 13 oxygen content failed.")
    }
    
    func test_Saturations() throws {
        var saturation = calculateContents(pO2: 94.2, pCO2: 39.9, pH: 7.40).oxygenSaturation  // 1    97
        XCTAssertEqual(saturation, 0.97, accuracy: 0.01, "Case 1 saturation failed.")
        saturation = calculateContents(pO2: 83.3, pCO2: 39.5, pH: 7.40).oxygenSaturation      // 4    96
        XCTAssertEqual(saturation, 0.96, accuracy: 0.01, "Case 4 saturation failed.")
        saturation = calculateContents(pO2: 80.6, pCO2: 39.2, pH: 7.40).oxygenSaturation      // 7    96
        XCTAssertEqual(saturation, 0.96, accuracy: 0.01, "Case 7 saturation failed.")
        saturation = calculateContents(pO2: 69.0, pCO2: 38.1, pH: 7.41).oxygenSaturation      // 8    94
        XCTAssertEqual(saturation, 0.94, accuracy: 0.01, "Case 8 saturation failed.")
        saturation = calculateContents(pO2: 67.6, pCO2: 37.7, pH: 7.412).oxygenSaturation     // 11   94
        XCTAssertEqual(saturation, 0.94, accuracy: 0.01, "Case 11 saturation failed.")
        saturation = calculateContents(pO2: 35.7, pCO2: 34, pH: 7.44).oxygenSaturation
        XCTAssertEqual(saturation, 0.70, accuracy: 0.01, "Case 35.7 saturation failed.")
        saturation = calculateContents(pO2: 27.2, pCO2: 32, pH: 7.45).oxygenSaturation
        XCTAssertEqual(saturation, 0.54, accuracy: 0.01, "Case 27.2 saturation failed.")
        saturation = calculateContents(pO2: 443, pCO2: 32, pH: 7.40).oxygenSaturation
        XCTAssertEqual(saturation, 1.0, accuracy: 0.01, "Case 443 saturation failed.")
    }
    func test_Contents_pCO2() throws {
        /// This unit test is testing the routine IN ISOLATION of the rest of the MacPuf simulation, and I have used output from MacPuf
        /// as the so-called gold standard for the correct answers.  For this reason, I have adjusted the required accuracy for passing
        /// these tests, given that when I stick this function into the main runtime, the integration tests might reveal why there are some
        /// differences.
        ///
        var pco2Content = calculateContents(pO2: 94.2, pCO2: 39.9, pH: 7.40).carbonDioxideContent  // 1    47.3
        XCTAssertEqual(pco2Content, 47.3, accuracy: 2.0, "Case 1 carbon dioxide content failed.")
        pco2Content = calculateContents(pO2: 107.5, pCO2: 35.1, pH: 7.40).carbonDioxideContent     // 2    44.3
        XCTAssertEqual(pco2Content, 44.3, accuracy: 3.0, "Case 2 carbon dioxide content failed.")
        pco2Content = calculateContents(pO2: 29.0, pCO2: 52.8, pH: 7.33).carbonDioxideContent      // 3    56.6
        XCTAssertEqual(pco2Content, 56.6, accuracy: 2.0, "Case 3 carbon dioxide content failed.")
        pco2Content = calculateContents(pO2: 83.3, pCO2: 39.5, pH: 7.40).carbonDioxideContent      // 4    47.1
        XCTAssertEqual(pco2Content, 47.1, accuracy: 2.0, "Case 4 carbon dioxide content failed.")
        pco2Content = calculateContents(pO2: 28.0, pCO2: 52.8, pH: 7.332).carbonDioxideContent     // 5    56.7
        XCTAssertEqual(pco2Content, 56.7, accuracy: 2.0, "Case 5 carbon dioxide content failed.")
        pco2Content = calculateContents(pO2: 39.6, pCO2: 45.0, pH: 7.375).carbonDioxideContent     // 6    51.3
        XCTAssertEqual(pco2Content, 51.3, accuracy: 2.0, "Case 6 carbon dioxide content failed.")
        pco2Content = calculateContents(pO2: 80.6, pCO2: 39.2, pH: 7.40).carbonDioxideContent      // 7    46.9
        XCTAssertEqual(pco2Content, 46.9, accuracy: 2.0, "Case 7 carbon dioxide content failed.")
        pco2Content = calculateContents(pO2: 69.0, pCO2: 38.1, pH: 7.41).carbonDioxideContent      // 8    46.3
        XCTAssertEqual(pco2Content, 46.3, accuracy: 2.0, "Case 8 carbon dioxide content failed.")
        pco2Content = calculateContents(pO2: 25.7, pCO2: 52.6, pH: 7.334).carbonDioxideContent     // 9    56.7
        XCTAssertEqual(pco2Content, 56.7, accuracy: 2.0, "Case 9 carbon dioxide content failed.")
        pco2Content = calculateContents(pO2: 38.3, pCO2: 44.6, pH: 7.375).carbonDioxideContent     // 10   51.1
        XCTAssertEqual(pco2Content, 51.1, accuracy: 2.0, "Case 10 carbon dioxide content failed.")
        pco2Content = calculateContents(pO2: 67.6, pCO2: 37.7, pH: 7.412).carbonDioxideContent     // 11   46.1
        XCTAssertEqual(pco2Content, 46.1, accuracy: 2.0, "Case 11 carbon dioxide content failed.")
        pco2Content = calculateContents(pO2: 24.3, pCO2: 52.5, pH: 7.335).carbonDioxideContent     // 12   56.7
        XCTAssertEqual(pco2Content, 56.7, accuracy: 2.0, "Case 12 carbon dioxide content failed.")
        pco2Content = calculateContents(pO2: 37.7, pCO2: 43.8, pH: 7.379).carbonDioxideContent     // 13   50.9
        XCTAssertEqual(pco2Content, 50.9, accuracy: 2.0, "Case 13 carbon dioxide content failed.")
    }
    
}
