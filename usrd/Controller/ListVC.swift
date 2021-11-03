//
//  ViewController.swift
//  usrd
//
//  Created by Aleksandr Khalupa on 11.08.2021.
//

import UIKit

class ListVC: UITableViewController, UISearchBarDelegate, ManagerUSRDDelegate {

    

    @IBOutlet weak var searchBar: UISearchBar!
    
    let managerUSRD = ManagerUSRD()
    lazy var data: [ModelUSRD] = []
    
    private var timer: Timer?
    private var ids: (() -> Int)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        managerUSRD.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListVCtoPdfVc"{
            let x  = ids!()
            let pdfVC = segue.destination as! PDFViewController
            pdfVC.id = data[x].id
        }
    }
    
    @IBAction func goToSelectedVC(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ListVcToSelectelVC", sender: self)
    }
    
    @objc func openPDF(_ sender: UIButton){
        ids = { return sender.tag }
        performSegue(withIdentifier: "ListVCtoPdfVc", sender: self)
    }

    
    @objc func addToSelected(_ sender: UIButton){
        ids = { return sender.tag }
        let addSelectedImage = UIImage(systemName: "star.fill")
        let noSelectedImage = UIImage(systemName: "star")
        if sender.currentImage == noSelectedImage {
        sender.setImage(addSelectedImage, for: .normal)
        } else {
            sender.setImage(noSelectedImage, for: .normal)
        }
    }
    
    func getUSRDData(data: [ModelUSRD]) {
        self.data = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func getError(serverError: String) {
        print(serverError)
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! TableViewCell
        
        cell.nameLabel.text = "\(data[indexPath.row].lastname) \(data[indexPath.row].firstnameString) \(data[indexPath.row].middlename)"
        cell.jobLabel.text = "\(data[indexPath.row].workPlace)"
        cell.positionLabel.text = "\(data[indexPath.row].workPost)"
        cell.уearLabel.text = "Звітний період: \(data[indexPath.row].declarationPeriodString)"
        cell.pdfButton.addTarget(nil, action: #selector(openPDF), for: .touchUpInside)
        cell.selectedButton.addTarget(nil, action: #selector(addToSelected), for: .touchUpInside)
        cell.pdfButton.tag = indexPath.row
        
        return cell
    }
    

    //    MARK: - Search

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            self.managerUSRD.requestUSRD(lastname: searchText)
        })
    }
    
    func searchInDB(text:String, searchBar: UISearchBar){
        
        if text != ""{
//            listArray = listArray?.filter("item CONTAINS[cd] %@", text).sorted(byKeyPath: "item", ascending: true)
        } else{
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        tableView.reloadData()
    }
}

