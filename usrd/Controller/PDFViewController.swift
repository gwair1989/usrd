//
//  PDFViewController.swift
//  usrd
//
//  Created by Aleksandr Khalupa on 11.08.2021.
//

import UIKit
import WebKit

class PDFViewController: UIViewController {

    var id = ""
    let managerUSRD = ManagerUSRD()
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let urlRequest = managerUSRD.requestUSRD(id: id) {
        webView.load(urlRequest)
        }
    }

    @IBAction func AddToSelect(_ sender: UIBarButtonItem) {
        webView.createPDF { result in
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let docDirectoryPath = paths[0]
            let pdfPath = docDirectoryPath.appendingPathComponent("\(self.id).pdf")
            print(pdfPath)
            switch result {
            
            case .success(let data):
                do {
                    try data.write(to: pdfPath)
                    print("Successfully created and saved pdf…")
                } catch let error {
                    print("Could not _save_ pdf: \(error)")
                }
            case .failure(let error):
                print("Could not create pdf: \(error)")
            }


        }
//        let pdfFilePath = self.webView.exportAsPdfFromWebView(id: id)
//        print(pdfFilePath)
    }
    

}
