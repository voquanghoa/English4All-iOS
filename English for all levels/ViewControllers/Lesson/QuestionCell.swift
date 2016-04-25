//
//  QuestionCell.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/20/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        label.backgroundColor = UIColor.clearColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setText(index:Int, text: String){
        label.attributedText = QuestionHelper.createHtmlAttrib("\(index + 1). \(text)")
    }
}
