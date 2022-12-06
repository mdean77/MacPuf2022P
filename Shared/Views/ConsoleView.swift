//
//  ConsoleView.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 11/27/22.
//  This is where I will put the main simulation console output.
//

import SwiftUI
//import CoreText

struct ConsoleView: View {
    @EnvironmentObject var simulator: Simulator
    var body: some View {
        
        TextEditor(text: $simulator.consoleContentString)
            .monospaced()
            .font(.system(size:12))
        simButtons
    }
    
    func render() -> URL {
        let renderer = ImageRenderer(content:Text(simulator.consoleContentString)
            .monospaced()
            .font(.system(size:10)))
        
        let url = URL.documentsDirectory.appending(path: "output.pdf")
        
        let numberOfLines = simulator.consoleContentString.countInstances(of: "\n") + 1
        
        
        renderer.render{size, context in
            guard let pdf = CGContext(url as CFURL, mediaBox: nil, nil)
            else {
                return
            }
            let textRange = CFRangeMake(0, simulator.consoleContentString.count)
            var pageRange = CFRangeMake(0,3)
            let pageSize = CGSize(width: 612.0, height: 792.0)
            let contentString = CFAttributedStringCreate(nil, simulator.consoleContentString as CFString, nil)

            let frameSetter = CTFramesetterCreateWithAttributedString(contentString ?? "" as! CFAttributedString)
            
//            CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, textRange, nil, pageSize, &pageRange)
           let pageRect = CGRect(x: 72, y: 72, width:612.0, height: 792.0)
           let framePath = CGPath(rect: pageRect, transform: nil)
//            let frame = CTFramesetterCreateFrame(frameSetter, pageRange, framePath, nil)
            
            CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0,min(800, simulator.consoleContentString.count)), nil, pageSize, &pageRange)
            var frame = CTFramesetterCreateFrame(frameSetter, pageRange, framePath, nil)
            pdf.beginPDFPage(nil)
            CTFrameDraw(frame, pdf)
            pdf.endPDFPage()

            CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(801,min(1600, simulator.consoleContentString.count)), nil, pageSize, &pageRange)
             frame = CTFramesetterCreateFrame(frameSetter, pageRange, framePath, nil)
            pdf.beginPDFPage(nil)
            CTFrameDraw(frame, pdf)
            pdf.endPDFPage()

            CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(1601,min(3000, simulator.consoleContentString.count)), nil, pageSize, &pageRange)
             frame = CTFramesetterCreateFrame(frameSetter, pageRange, framePath, nil)
            pdf.beginPDFPage(nil)
            CTFrameDraw(frame, pdf)
            pdf.endPDFPage()
            pdf.closePDF()
        }
        return url
    }
    
//    func render() -> URL {
//        let renderer = ImageRenderer(content:Text(simulator.consoleContentString)
//            .monospaced()
//            .font(.system(size:10)))
//
//        let url = URL.documentsDirectory.appending(path: "output.pdf")
//
//        renderer.render{size, context in
//            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height)
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
//        }
//        return url
//    }
    
    var simButtons: some View {
        HStack{
            Button{
                simulator.startUp()
            } label: {
                Text("Simulate new")
            }
            
            Group{
                Button{simulator.continueSubject()
                } label: {
                    Text("Continue same")
                }
                .disabled(!simulator.alive)     // If not alive, cannot allow continuation
                Button{
                    simulator.inspectSubject()
                } label: {
                    Text("Inspect")
                }
                Button{
                    simulator.dumpParameters()
                } label: {
                    Text("Dump")
                }
                ShareLink("Export PDF", item:render())
            }
            .disabled(!simulator.patientStarted)
        }
        .buttonStyle(.bordered)
        .font(.headline)
    }
}




struct ConsoleView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group{
            ConsoleView()
                .previewInterfaceOrientation(.landscapeLeft)
            ConsoleView()
                .previewInterfaceOrientation(.landscapeRight)
                .preferredColorScheme(.dark)
        }.environmentObject(Simulator())
        
    }
}

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
}
