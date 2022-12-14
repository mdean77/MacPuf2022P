//
//  PDFExtensions.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 12/7/22.
//

import SwiftUI
import UIKit

extension String {
    /// stringToFind must be at least 1 character.
    func countInstances(of stringToFind: String) -> Int {
        assert(!stringToFind.isEmpty)
        var count = 0
        var searchRange: Range<String.Index>?
        while let foundRange = range(of: stringToFind, options: [], range: searchRange) {
            count += 1
            searchRange = Range(uncheckedBounds: (lower: foundRange.upperBound, upper: endIndex))
        }
        return count
    }
    
    
    func findNthOccurrence(of substring: String, in string: String, n: Int) -> Int? {
        let range = string.range(of: substring, options: .caseInsensitive)
        guard let firstOccurrence = range?.lowerBound else { return nil }
        
        let offset = string.distance(from: string.startIndex, to: firstOccurrence)
        let nextOccurrenceIndex = string.index(firstOccurrence, offsetBy: (n - 1) * substring.count)
        
        return string.distance(from: string.startIndex, to: nextOccurrenceIndex)
    }
}
//let string = "hello, world, hello!"
//let substring = "hello"
//let n = 2
//
//if let index = findNthOccurrence(of: substring, in: string, n: n) {
//    print("The index of the 2nd occurrence of 'hello' in 'hello, world, hello!' is: \(index)")
//}
//
//The index of the 2nd occurrence of 'hello' in 'hello, world, hello!' is: 14

//extension View {
    /// Export a SwiftUI view to PDF document
//    func exportToPDF() -> URL {
//
//        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let outputFileURL = documentDirectory.appendingPathComponent("SwiftUI.pdf")
//
//        //Normal with
//        let width: CGFloat = 8.5 * 72.0
//        //Estimate the height of your view
//        let height: CGFloat = 1000
//        //let charts = ConsoleView()
//
//        let pdfVC = UIHostingController(rootView: self)
//        pdfVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
//
//        //Render the view behind all other views
//        //let rootVC = UIApplication.shared.windows.first?.rootViewController
//        //let rootVC = UIWindowScene.window.first?.rootViewController
//        //let rootVC = pdfVC.windowScene.keyWindow.rootViewController
//        //pdfVC.view
//        //rootVC?.addChild(pdfVC)
//        //  rootVC?.view.insertSubview(pdfVC.view, at: 0)
//
//        //Render the PDF
//        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 8.5 * 72.0, height: height))
//        DispatchQueue.main.async {
//            do {
//                try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
//                    context.beginPage()
//                    pdfVC.view.layer.render(in: context.cgContext)
//                })
//                print("wrote file to: \(outputFileURL.path)")
//            } catch {
//                print("Could not create PDF file: \(error.localizedDescription)")
//            }
//        }
//        return outputFileURL
//        //pdfVC.removeFromParent()
//        //pdfVC.view.removeFromSuperview()
//    }
    
    //    func render() -> URL {
    //        let renderer = ImageRenderer(content:Text(simulator.consoleContentString)
    //            .monospaced()
    //            .font(.system(size:12)))
    //
    //        let url = URL.documentsDirectory.appending(path: "output.pdf")
    //
    //        let numberOfLines = simulator.consoleContentString.countInstances(of: "\n") + 1
    //        let numberOfPages = numberOfLines / 60
    //
    //
    //        renderer.render{size, context in
    //            guard let pdf = CGContext(url as CFURL, mediaBox: nil, nil)
    //            else {
    //                return
    //            }
    //            //let textRange = CFRangeMake(0, simulator.consoleContentString.index(after:"\n"))
    //            var pageRange = CFRangeMake(1,0)
    //            let pageSize = CGSize(width: 8.5 * 72, height: 11 * 72)
    //
    //            let contentString = CFAttributedStringCreate(nil, simulator.consoleContentString as CFString, nil)
    //
    //            let frameSetter = CTFramesetterCreateWithAttributedString(contentString ?? "" as! CFAttributedString)
    //
    //            //CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, textRange, nil, pageSize, nil)
    //            let pageRect = CGRect(x: 72, y: 72, width:7.5 * 72, height: 9 * 72)
    //           let framePath = CGPath(rect: pageRect, transform: nil)
    ////            let frame = CTFramesetterCreateFrame(frameSetter, pageRange, framePath, nil)
    //
    //            //CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0,min(800, simulator.consoleContentString.count)), nil, pageSize, nil)
    //            pageRange = CFRangeMake(1,250)
    //            var frame = CTFramesetterCreateFrame(frameSetter, pageRange, framePath, nil)
    //            pdf.beginPDFPage(nil)
    //            CTFrameDraw(frame, pdf)
    //            pdf.endPDFPage()
    //
    //           // CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(801,min(1600, simulator.consoleContentString.count)), nil, pageSize, nil)
    //            pageRange = CFRangeMake(251,350)
    //             frame = CTFramesetterCreateFrame(frameSetter, pageRange, framePath, nil)
    //            pdf.beginPDFPage(nil)
    //            CTFrameDraw(frame, pdf)
    //            pdf.endPDFPage()
    //
    //            //CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(1601,min(3000, simulator.consoleContentString.count)), nil, pageSize, nil)
    //            pageRange = CFRangeMake(351,400)
    //             frame = CTFramesetterCreateFrame(frameSetter, pageRange, framePath, nil)
    //            pdf.beginPDFPage(nil)
    //            CTFrameDraw(frame, pdf)
    //            pdf.endPDFPage()
    //            pdf.closePDF()
    //        }
    //        return url
    //    }
//
//        func render() -> URL {
//            let renderer = ImageRenderer(content:Text(simulator.consoleContentString)
//                .monospaced()
//                .font(.system(size:10)))
//
//            let url = URL.documentsDirectory.appending(path: "output.pdf")
//
//                    let numberOfLines = simulator.consoleContentString.countInstances(of: "\n") + 1
//                    let numberOfPages = numberOfLines / 60
//            print("Number of pages: \(numberOfPages)")
//
//            renderer.render{size, context in
//                for page in 0..<numberOfPages {
//                    print("\n\nPage number: \(page)\n\n")
//                    var box = CGRect(x:72, y:11*72*page + 72, width:Int(7.5 * 72), height:Int(size.height)/numberOfPages*page)
//                    guard var pdf = CGContext(url as CFURL, mediaBox: &box, nil)
//                    else {
//                        return
//                    }
//                   // print("\n\nPage number: \(page)\n\n")
//                    pdf.beginPDFPage(nil)
//                    context(pdf)
//                    pdf.endPDFPage()
//                }
               // var box = CGRect(x: 72, y: 72, width: 7.5*72, height: size.height)
    //            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil)
    //            else {
    //                return
    //            }
    //            pdf.beginPDFPage(nil)//pageInfo as CFDictionary)
    //            //CTFrameDraw(frame, pdf)
    //            context(pdf)
    //            pdf.endPDFPage()
    //            pdf.beginPDFPage(nil)//pageInfo as CFDictionary)
    //            //CTFrameDraw(frame, pdf)
    //            context(pdf)
    //            pdf.endPDFPage()
    //            pdf.beginPDFPage(nil)//pageInfo as CFDictionary)
    //            //CTFrameDraw(frame, pdf)
    //            context(pdf)
    //            pdf.endPDFPage()
    //            pdf.closePDF()
//            }
//            return url
//        }
//}
