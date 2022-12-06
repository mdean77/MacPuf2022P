//
//  ConsoleView.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 11/27/22.
//  This is where I will put the main simulation console output.
//

import SwiftUI
import CoreText

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
            .font(.system(size:8)))
        
        let url = URL.documentsDirectory.appending(path: "output.pdf")
        renderer.render{size, context in
            guard let pdf = CGContext(url as CFURL, mediaBox: nil, nil)
            else {
                return
            }
//            var textRange = CFRangeMake(0, simulator.consoleContentString.count)
//            var pageRange = CFRangeMake(0,2)
//            let pageSize = CGSize(width: 792.0, height: 612.0)
//            var contentString = CFAttributedStringCreate(nil, simulator.consoleContentString as CFString, nil)
//
//            let frameSetter = CTFramesetterCreateWithAttributedString(contentString ?? "" as! CFAttributedString)
//            CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, textRange, nil, pageSize, &pageRange)
//            let pageRect = CGRect(x: 72.0, y: 72.0, width: 468.0, height: 648.0)
//            let framePath = CGPath(rect: pageRect, transform: nil)
//            let frame = CTFramesetterCreateFrame(frameSetter, pageRange, framePath, nil)

              // print("frame = \(frame)\n")
            
            pdf.beginPDFPage(nil)
//            print("textRange = \(textRange)\n")
//            print("pageRange = \(pageRange)\n")
//            print("contentString = \(contentString)\n")
//            CTFrameDraw(frame, pdf)
//            print("textRange = \(textRange)\n")
//            print("pageRange = \(pageRange)\n")
//            print("contentString = \(contentString)\n")
//            CTFrameDraw(frame, pdf)
             //  print("frame = \(frame)\n")
            context(pdf)
            pdf.endPDFPage()
            pdf.closePDF()
        }
        return url
    }
    
    
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
