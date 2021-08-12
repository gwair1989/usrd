//
//  TableViewCell.swift
//  usrd
//
//  Created by Aleksandr Khalupa on 11.08.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var уearLabel: UILabel!
    
    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var pdfButton: UIButton!
    
    @IBOutlet weak var selectedButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func openPdf(_ sender: UIButton) {
        
        
        
        
    }
    
    
    @IBAction func addToSelected(_ sender: UIButton) {
    }
    
}
