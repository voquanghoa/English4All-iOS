//
//  LessonViewCell.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/11/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class LessonViewCell: UITableViewCell {

    @IBOutlet weak var category: UIButton!
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet var answerTexts: [UIButton]!
    var contentHeight:CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionTitle.backgroundColor = UIColor.clearColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setQuestion(index: Int, question: Question){
        
        if(question.category == ""){
            category.hidden = true
        }else{
            category.hidden = false
            category.setTitle(question.category, forState: .Normal)
        }
        
        questionTitle.attributedText = createHtmlAttrib("\(index + 1). \(question.questionTitle)")
        
        let answerCount = question.anwers.count
        for index in 0..<answerTexts.count{
            let button = answerTexts[index]
            
            if(index < answerTexts.count - answerCount){
                button.hidden = true
            }else{
                button.hidden = false
                button.setAttributedTitle(createHtmlAttrib(question.anwers[index - (answerTexts.count - answerCount)]), forState: .Normal)
            }
        }
    }
    
    func createHtmlAttrib(html: String) -> NSAttributedString{
        let sizeHtml = "<font size='5'>\(html)</font>"
        
        let attrStr = try! NSAttributedString(
            data: sizeHtml.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        return attrStr
    }
    
    func updateSize(){
        var frame = self.frame
        frame.size = CGSize(width: frame.size.width, height: contentHeight)
        self.frame = frame
    }
    
    override func willMoveToWindow(newWindow: UIWindow?) {
        updateSize()
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        updateSize()
    }
}
