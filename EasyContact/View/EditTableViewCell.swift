//
//  EditTableViewCell.swift
//  EasyContact
//
//  Created by Abhinav Singh on 6/2/19.
//  Copyright © 2019 Abhinav. All rights reserved.
//

import UIKit

class EditTableViewCell: UITableViewCell {

    @IBOutlet weak var txtContactValue: UITextField!
    @IBOutlet weak var txtContactLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
