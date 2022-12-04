//
//  ConsoleView.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 11/27/22.
//  This is where I will put the main simulation console output.
//

import SwiftUI

struct ConsoleView: View {
    @EnvironmentObject var simulator: Simulator
    var body: some View {
        
        TextEditor(text: $simulator.consoleContentString)
            .monospaced()
            .font(.system(size:12))
        simButtons
    }
        
        func render() -> URL {
            let renderer = ImageRenderer(content:
                                            Text(simulator.consoleContentString)
                .monospaced()
                .font(.system(size:8)))

            let url = URL.documentsDirectory.appending(path: "output.pdf")
            renderer.render{size, context in
                var box = CGRect(x:0, y:0, width:size.width, height:size.height)
                guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil)
                else {
                    return
                }
                //pdf.beginPDFPage(nil)
                pdf.beginPDFPage(["setTopMargin":50] as CFDictionary)
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
                    .font(.headline)
            }
            .buttonStyle(.bordered)
            
            //Spacer()
            
            Group{
                Button{
                    simulator.continueSubject()
                } label: {
                    Text("Continue same")
                        .font(.headline)
                }
                .disabled(!simulator.alive)
                
                Button{
                    simulator.inspectSubject()
                } label: {
                    Text("Inspect")
                        .font(.headline)
                }
                
                Button{
                    simulator.dumpParameters()
                } label: {
                    Text("Dump")
                        .font(.headline)
                }
            }.buttonStyle(.bordered)
                .disabled(!simulator.patientStarted)
            ShareLink("Export PDF", item:render())
                .buttonStyle(.bordered)
        }.padding(.horizontal)
        
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
