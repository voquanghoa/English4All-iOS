//
//  LessonViewCell.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/11/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class LessonViewCell: UITableViewCell {
    @IBOutlet var answerTexts: [UIButton]!
    
    var showAnswer = false
    var question: Question!
    static var custombackground:UIColor!

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onAnswerClick(sender: AnyObject) {
        if !showAnswer {
            let clickedButton = sender as! NSObject
        
            for index in 0..<answerTexts.count{
                answerTexts[index].selected = answerTexts[index] == clickedButton
            
                if(answerTexts[index].selected){
                    question.userSelected = index
                }
            }
        }
    }
    
    func setButtonColor(button: UIButton, color: UIColor){
        button.setTitleColor(color, forState: UIControlState.Disabled)
        button.setTitleColor(color, forState: UIControlState.Normal)
        button.setTitleColor(color, forState: UIControlState.Highlighted)
        button.setTitleColor(color, forState: UIControlState.Selected)
        button.setTitleColor(color, forState: UIControlState.Reserved)
        button.setTitleColor(color, forState: UIControlState.Focused)
        button.setTitleColor(color, forState: UIControlState.Application)
        
        button.setTitleShadowColor(color, forState: UIControlState.Disabled)
        button.setTitleShadowColor(color, forState: UIControlState.Normal)
        button.setTitleShadowColor(color, forState: UIControlState.Highlighted)
        button.setTitleShadowColor(color, forState: UIControlState.Selected)
        button.setTitleShadowColor(color, forState: UIControlState.Reserved)
        button.setTitleShadowColor(color, forState: UIControlState.Focused)
        button.setTitleShadowColor(color, forState: UIControlState.Application)
    }
    
    func setQuestion(index: Int, question: Question, showAnswer: Bool){
        self.question = question
        self.showAnswer = showAnswer
        self.setNeedsLayout()
        
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
                button.setAttributedTitle(QuestionHelper.createHtmlAttrib(answer), forState: .Normal)
                
                
                var color:UIColor!
                if showAnswer {
                    if(questionIndex != question.userSelected){
                        color = UIColor.brownColor()
                    }else if question.isCorrect(){
                        color = UIColor.greenColor()
                    }else{
                        color = UIColor.redColor()
                    }
                }else{
                    color = UIColor.blueColor()
                }
                
                setButtonColor(button, color: color)
                
                button.selected = true
                if(questionIndex != question.userSelected){
                    button.selected = false
                }
                button.setNeedsLayout()
                button.setNeedsDisplay()
            }
        }
    }
}
