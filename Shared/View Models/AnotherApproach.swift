//
//  AnotherApproach.swift
//  MacPuf2022P
//
//  Created by J Michael Dean on 12/12/22.
//

import Foundation
import UIKit
class PDFCreator {

lazy var pageWidth : CGFloat  = {
    return 8.5 * 72.0
}()

lazy var pageHeight : CGFloat = {
    return 11 * 72.0
}()

lazy var pageRect : CGRect = {
    CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
}()

lazy var marginPoint : CGPoint = {
    return CGPoint(x: 10, y: 10)
}()

lazy var marginSize : CGSize = {
    return CGSize(width: self.marginPoint.x * 2 , height: self.marginPoint.y * 2)
}()


func prepareData() -> Data {
    //1
    let pdfMetaData = [
      kCGPDFContextCreator: "PDF Creator",
      kCGPDFContextAuthor: "Pratik Sodha",
      kCGPDFContextTitle: "My PDF"
    ]

    //2
    let format = UIGraphicsPDFRendererFormat()
    format.documentInfo = pdfMetaData as [String: Any]

    //3
    let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

    //5
    let data = renderer.pdfData { (context) in

        //6
        self.addText("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", context: context)
    }

    return data
}

@discardableResult
func addText(_ text : String, context : UIGraphicsPDFRendererContext) -> CGFloat {

    // 1
    let textFont = UIFont.systemFont(ofSize: 60.0, weight: .regular)

    // 2
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .natural
    paragraphStyle.lineBreakMode = .byWordWrapping

    // 3
    let textAttributes = [
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.font: textFont
    ]

    //4
    let currentText = CFAttributedStringCreate(nil,
                                               text as CFString,
                                               textAttributes as CFDictionary)
    //5
    let framesetter = CTFramesetterCreateWithAttributedString(currentText!)

    //6
    var currentRange = CFRangeMake(0, 0)
    var currentPage = 0
    var done = false
    repeat {

        //7
        /* Mark the beginning of a new page.*/
        context.beginPage()

        //8
        /*Draw a page number at the bottom of each page.*/
        currentPage += 1
        drawPageNumber(currentPage)


        //9
        /*Render the current page and update the current range to
          point to the beginning of the next page. */
        currentRange = renderPage(currentPage,
                                  withTextRange: currentRange,
                                  andFramesetter: framesetter)

        //10
        /* If we're at the end of the text, exit the loop. */
        if currentRange.location == CFAttributedStringGetLength(currentText) {
            done = true
        }

    } while !done

    return CGFloat(currentRange.location + currentRange.length)
}

func renderPage(_ pageNum: Int, withTextRange currentRange: CFRange, andFramesetter framesetter: CTFramesetter?) -> CFRange {
    var currentRange = currentRange
    // Get the graphics context.
    let currentContext = UIGraphicsGetCurrentContext()

    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    currentContext?.textMatrix = .identity

    // Create a path object to enclose the text. Use 72 point
    // margins all around the text.
    let frameRect = CGRect(x: self.marginPoint.x, y: self.marginPoint.y, width: self.pageWidth - self.marginSize.width, height: self.pageHeight - self.marginSize.height)
    let framePath = CGMutablePath()
    framePath.addRect(frameRect, transform: .identity)

    // Get the frame that will do the rendering.
    // The currentRange variable specifies only the starting point. The framesetter
    // lays out as much text as will fit into the frame.
    let frameRef = CTFramesetterCreateFrame(framesetter!, currentRange, framePath, nil)

    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    currentContext?.translateBy(x: 0, y: self.pageHeight)
    currentContext?.scaleBy(x: 1.0, y: -1.0)

    // Draw the frame.
    CTFrameDraw(frameRef, currentContext!)

    // Update the current range based on what was drawn.
    currentRange = CTFrameGetVisibleStringRange(frameRef)
    currentRange.location += currentRange.length
    currentRange.length = CFIndex(0)

    return currentRange
}

func drawPageNumber(_ pageNum: Int) {

    let theFont = UIFont.systemFont(ofSize: 20)
    
    let pageString = NSMutableAttributedString(string: "Page \(pageNum)")
    pageString.addAttribute(NSAttributedString.Key.font, value: theFont, range: NSRange(location: 0, length: pageString.length))

    let pageStringSize =  pageString.size()

    let stringRect = CGRect(x: (pageRect.width - pageStringSize.width) / 2.0,
                            y: pageRect.height - (pageStringSize.height) / 2.0 - 15,
                            width: pageStringSize.width,
                            height: pageStringSize.height)

    pageString.draw(in: stringRect)

}
}
