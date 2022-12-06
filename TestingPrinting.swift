//
//  TestingPrinting.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 12/6/22.
//

import Foundation

func exportToPDF() {

    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let outputFileURL = documentDirectory.appendingPathComponent("SwiftUI.pdf")

    //Normal with
    let width: CGFloat = 8.5 * 72.0
    //Estimate the height of your view
    let height: CGFloat = 1000
    let charts = ChartsView()

    let pdfVC = UIHostingController(rootView: charts)
    pdfVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)

    //Render the view behind all other views
    let rootVC = UIApplication.shared.windows.first?.rootViewController
    rootVC?.addChild(pdfVC)
    rootVC?.view.insertSubview(pdfVC.view, at: 0)

    //Render the PDF
    let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 8.5 * 72.0, height: height))

    do {
        try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
            context.beginPage()
            pdfVC.view.layer.render(in: context.cgContext)
        })

        self.exportURL = outputFileURL
        self.showExportSheet = true

    }catch {
        self.showError = true
        print("Could not create PDF file: \(error)")
    }

    pdfVC.removeFromParent()
    pdfVC.view.removeFromSuperview()
}

//Render the PDF

 let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 8.5 * 72.0, height: height))
 DispatchQueue.main.async {
     do {
         try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
             context.beginPage()
             pdfVC.view.layer.render(in: context.cgContext)
         })
         print("wrote file to: \(outputFileURL.path)")
     } catch {
         print("Could not create PDF file: \(error.localizedDescription)")
     }
 }

func exportToPDF() {
    let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("SwiftUI.pdf")
    let pageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    //View to render on PDF
    let myUIHostingController = UIHostingController(rootView: ContentView())
    myUIHostingController.view.frame = CGRect(origin: .zero, size: pageSize)
    
    
    //Render the view behind all other views
    guard let rootVC = UIApplication.shared.windows.first?.rootViewController else {
        print("ERROR: Could not find root ViewController.")
        return
    }
    rootVC.addChild(myUIHostingController)
    //at: 0 -> draws behind all other views
    //at: UIApplication.shared.windows.count -> draw in front
    rootVC.view.insertSubview(myUIHostingController.view, at: 0)
    
    
    //Render the PDF
    let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))
    DispatchQueue.main.async {
        do {
            try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
                context.beginPage()
                myUIHostingController.view.layer.render(in: context.cgContext)
            })
            print("wrote file to: \(outputFileURL.path)")
        } catch {
            print("Could not create PDF file: \(error.localizedDescription)")
        }
        
        //Remove rendered view
        myUIHostingController.removeFromParent()
        myUIHostingController.view.removeFromSuperview()
    }
}

// scale 1 -> 72 DPI
// scale 4 -> 288 DPI
// scale 300 / 72 -> 300 DPI
let dpiScale: CGFloat = 4

// for US letter page size
let pageSize = CGSize(width: 8.5 * 72, height: 11 * 72)
// for A4 page size
// let pageSize = CGSize(width: 8.27 * 72, height: 11.69 * 72)

let pdfVC = UIHostingController(rootView: swiftUIview)
pdfVC.view.frame = CGRect(origin: .zero, size: pageSize * dpiScale)

...

let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))
do {
    try pdfRenderer.writePDF(to: outputFileURL) { context in
        context.beginPage()
        context.cgContext.scaleBy(x: 1 / dpiScale, y: 1 / dpiScale)
        pdfVC.view.layer.render(in: context.cgContext)
    }
    print("File saved to: \(outputFileURL.path)")
}
...

extension CGSize {
    static func * (size: CGSize, value: CGFloat) -> CGSize {
        return CGSize(width: size.width * value, height: size.height * value)
    }
}

func exportToPDF() {
    let listHeight: CGFloat = 24.0//or you can get it from your ListView
    let rowsCount = yourArrayOrObject.count
        let rowsCountPerPage = Int(11.69 * 72 / listHeight) - 6
        let countOfPages = Int(ceil( Double(rowsCount) / Double(rowsCountPerPage)))
    
    var index = 0
    while index < countOfPages {
        
    let items = yourArrayOrObject.slice(size: rowsCountPerPage)[index]
    
        let rootView =  List {
            ForEach(items, id: \.self) { item in
                Text("\(item.name)")
            }
    }
        
        let dpiScale: CGFloat = 1.5
        
        // for US letter page size
        // let pageSize = CGSize(width: 8.5 * 72, height: 11 * 72)
        // for A4 page size
        let pageSize = CGSize(width: 8.27 * 72, height: 11.69 * 72)
        
        //View to render on PDF
        let myUIHostingController = UIHostingController(rootView: rootView)
        myUIHostingController.view.frame = CGRect(origin: .zero, size: pageSize * dpiScale)
        myUIHostingController.view.overrideUserInterfaceStyle = .light//it will be light, when dark mode
        //Render the view behind all other views
        guard let rootVC = UIApplication.shared.windows.first?.rootViewController else {
            print("ERROR: Could not find root ViewController.")
            return
        }
        rootVC.addChild(myUIHostingController)
        //at: 0 -> draws behind all other views
        //at: UIApplication.shared.windows.count -> draw in front
        rootVC.view.insertSubview(myUIHostingController.view, at: 0)
        
        
        //Render the PDF
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))
    let data = pdfRenderer.pdfData { context in
        context.beginPage()

        context.cgContext.scaleBy(x: 1 / dpiScale, y: 1 / dpiScale)
        myUIHostingController.view.layer.render(in: context.cgContext)
    }
        //Remove rendered view
        myUIHostingController.removeFromParent()
        myUIHostingController.view.removeFromSuperview()
        if index == 0 {
    pdfDocumentData = data // pdfDocumentData must be declared above: @State private var pdfDocumentData = Data()(don't forget import PDFKit)
        } else {
            pdfDocumentData =  mergePdf(data: pdfDocumentData, otherPdfDocumentData: data).dataRepresentation()!
        }
        index += 1
    }
   
    writeDataToTemporaryDirectory(withFilename: "YourPDFFileName.pdf", data: pdfDocumentData)
  
}

private func writeDataToTemporaryDirectory(withFilename: String, data: Data)  {
        do {
            // name the file
            let temporaryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(withFilename)
            print("writeDataToTemporaryDirectory at url:\t\(temporaryFileURL)")
            try data.write(to: temporaryFileURL, options: .atomic)
           print("It's Ok!")//you can open file in sheet: (self.showReport = true) ,for example
            pdfDocumentData = Data()
          
        } catch {
            print(error)
        }
  
    }
func mergePdf(data: Data, otherPdfDocumentData: Data) -> PDFDocument {
    // get the pdfData
    let pdfDocument = PDFDocument(data: data)!
    let otherPdfDocument = PDFDocument(data: otherPdfDocumentData)!
    
    // create new PDFDocument
    let newPdfDocument = PDFDocument()

    // insert all pages of first document
    for p in 0..<pdfDocument.pageCount {
    let page = pdfDocument.page(at: p)!
        newPdfDocument.insert(page, at: newPdfDocument.pageCount)
    }

    // insert all pages of other document
    for q in 0..<otherPdfDocument.pageCount {
        let page = otherPdfDocument.page(at: q)!
        newPdfDocument.insert(page, at: newPdfDocument.pageCount)
    }
    return newPdfDocument
}
extension CGSize {
static func * (size: CGSize, value: CGFloat) -> CGSize {
    return CGSize(width: size.width * value, height: size.height * value)
   }
}
extension Array {
func slice(size: Int) -> [[Element]] {
    (0...(count / size)).map{Array(self[($0 * size)..<(Swift.min($0 * size + size, count))])}
  }
}

func exportToPDF() {
    let outputFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("SwiftUI.pdf")
    let pageSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    let rootVC = UIApplication.shared.windows.first?.rootViewController

    //Render the PDF
    let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(origin: .zero, size: pageSize))
    DispatchQueue.main.async {
        do {
            try pdfRenderer.writePDF(to: outputFileURL, withActions: { (context) in
                context.beginPage()
                rootVC?.view.layer.render(in: context.cgContext)
            })
            print("wrote file to: \(outputFileURL.path)")
        } catch {
            print("Could not create PDF file: \(error.localizedDescription)")
        }
    }
}
