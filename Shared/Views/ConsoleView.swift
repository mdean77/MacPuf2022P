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
                ScrollView{
                    Text(simulator.consoleContentString)
                        .monospaced()
                        .font(.system(size:12))
                }
        
        simButtons
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
    
    
    func render() -> URL {
        // 1: Render Hello World with some modifiers
        let renderer = ImageRenderer(content:
                                        Text(simulator.consoleContentString)
            .font(.system(size: 12))
            .monospaced()
                .foregroundColor(.white)
                .padding()
                .background(.blue)
        )

        // 2: Save it to our documents directory
       let url = URL.documentsDirectory.appending(path: "output.pdf")

        // 3: Start the rendering process
        renderer.render { size, context in

            var box = CGRect(x: 0, y: 0, width: size.width, height: size.height/2)
            guard var pdf = CGContext(url as CFURL, mediaBox:&box, nil) else {
                return
            }

            pdf.beginPDFPage(nil)
            context(pdf)
            pdf.endPDFPage()
            
            box = CGRect(x: 0, y: size.height/4, width: size.width, height: size.height/2)
            guard var pdf = CGContext(url as CFURL, mediaBox:&box, nil) else {
                return
            }
            
            pdf.beginPDFPage(nil)
            context(pdf)
            pdf.endPDFPage()
            
            pdf.closePDF()
        }

        return url
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


