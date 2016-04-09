//
//  DataItemUITableViewCell.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/9/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class DataItemUITableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabelText(labelText:String) {
        self.label.text = labelText
    }
    
}
