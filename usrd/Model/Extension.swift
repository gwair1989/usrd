////
////  Extension.swift
////  usrd
////
////  Created by Aleksandr Khalupa on 04.11.2021.
////
//
//import Foundation
//import WebKit
//
//extension WKWebView {
//    
//    // Call this function when WKWebView finish loading
//    func exportAsPdfFromWebView(id:String) -> String {
//        let pdfData = createPdfFile(printFormatter: self.viewPrintFormatter())
//        return self.saveWebViewPdf(data: pdfData, id: id)
//    }
//    
//    func createPdfFile(printFormatter: UIViewPrintFormatter) -> NSMutableData {
//        
//        let originalBounds = self.bounds
//        self.bounds = CGRect(x: originalBounds.origin.x, y: bounds.origin.y, width: self.scrollView.contentSize.width, height: self.scrollView.contentSize.height)
//        let pdfPageFrame = CGRect(x: 0, y: 0, width: self.scrollView.contentSize.width, height: self.scrollView.contentSize.height)
//        let printPageRenderer = UIPrintPageRenderer()
//        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
//        printPageRenderer.setValue(NSValue(cgRect: UIScreen.main.bounds), forKey: "paperRect")
//        printPageRenderer.setValue(NSValue(cgRect: pdfPageFrame), forKey: "printableRect")
//        self.bounds = originalBounds
//        return printPageRenderer.generatePdfData()
//    }
//    
//    // Save pdf file in document directory
//    func saveWebViewPdf(data: NSMutableData, id: String) -> String {
//        
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let docDirectoryPath = paths[0]
//        let pdfPath = docDirectoryPath.appendingPathComponent("\(id).pdf")
//        if data.write(to: pdfPath, atomically: true) {
//            return pdfPath.path
//        } else {
//            return ""
//        }
//    }
//}
//
//extension UIPrintPageRenderer {
//    
//    func generatePdfData() -> NSMutableData {
//        let pdfData = NSMutableData()
//        UIGraphicsBeginPDFContextToData(pdfData, UIScreen.main.bounds, nil)
//        self.prepare(forDrawingPages: NSMakeRange(0, self.numberOfPages))
//        let printRect = UIGraphicsGetPDFContextBounds()
//        for pdfPage in 0 ..<  self.numberOfPages {
//            UIGraphicsBeginPDFPage()
//            self.drawPage(at: pdfPage, in: printRect)
//        }
//        UIGraphicsEndPDFContext();
//        return pdfData
//    }
//}
