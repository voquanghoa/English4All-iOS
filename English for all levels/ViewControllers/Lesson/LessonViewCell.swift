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
    
    var question: Question!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionTitle.backgroundColor = UIColor.clearColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onAnswerClick(sender: AnyObject) {
        let clickedButton = sender as! NSObject
        
        for index in 0..<answerTexts.count{
            answerTexts[index].selected = answerTexts[index] == clickedButton
            
            if(answerTexts[index].selected){
                question.userSelected = index
            }
        }
    }
    
    func setQuestion(index: Int, question: Question){
        self.question = question
        
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
                let questionIndex = index - (answerTexts.count - answerCount)
                let u = UnicodeScalar(97 + questionIndex)
                let answer = "\(Character(u)). \(question.anwers[questionIndex])"
                
                button.hidden = false
                button.setAttributedTitle(createHtmlAttrib(answer), forState: .Normal)
                if(questionIndex == question.userSelected){
                    button.selected = true
                }else{
                    button.selected = false
                }
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
}
