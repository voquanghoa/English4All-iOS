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
    
    @IBOutlet weak var folderBackground: UIImageView!
    @IBOutlet weak var fileBackground: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    func setLabelText(labelText:String) {
        self.label.text = labelText
    }
    
    func setViewStyle(isFile: Bool){
        folderBackground.hidden = isFile
        fileBackground.hidden = !isFile
    }
    
}
