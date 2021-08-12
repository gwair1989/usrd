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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        managerUSRD.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListVCtoPdfVc"{

            let pdfVC = segue.destination as! PDFViewController
            pdfVC.id = data[1].id
        }
    }
    
    @objc func openPDF(_ sender: UIButton){
        performSegue(withIdentifier: "ListVCtoPdfVc", sender: self)
        
    }

    
    @objc func openSelectedVC(_ sender: UIButton){
        performSegue(withIdentifier: "ListVcToSelectelVC", sender: self)
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
        
        
        cell.nameLabel.text = "\(data[indexPath.row].lastName) \(data[indexPath.row].firstName) \(data[indexPath.row].middleName)"
        cell.jobLabel.text = "\(data[indexPath.row].workPlace)"
        cell.positionLabel.text = "\(data[indexPath.row].workPost)"
        cell.уearLabel.text = "Рік: \(data[indexPath.row].declarationPeriod)"
        cell.pdfButton.addTarget(nil, action: #selector(openPDF), for: .touchUpInside)
        cell.selectedButton.addTarget(nil, action: #selector(openSelectedVC), for: .touchUpInside)
        cell.pdfButton.tag = indexPath.row
        
        return cell
    }
    

    //    MARK: - Search

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            self.managerUSRD.requestUSRD(lastname: searchText)
        })
//        managerUSRD.requestUSRD(lastname: searchText)
//        searchInDB(text: searchText, searchBar: searchBar)
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

