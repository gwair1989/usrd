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

    

}
