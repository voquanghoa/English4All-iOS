//
//  LessonViewCell.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/11/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class LessonViewCell: UITableViewCell {
    @IBOutlet var answerTexts: [DLRadioButton]!
    
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
    
    func setButtonColor(button: DLRadioButton, color: UIColor){
        button.iconColor = color
        button.indicatorColor = color
        button.tintColor = color
        button.setNeedsDisplay()
    }
    
    @IBOutlet weak var correctIcon: UIButton!
    @IBOutlet weak var incorrectIcon: UIButton!
    
    func setQuestion(index: Int, question: Question, showAnswer: Bool){
        self.question = question
        self.showAnswer = showAnswer
        
        correctIcon.hidden = true
        incorrectIcon.hidden = true
        if showAnswer {
            if question.isCorrect() {
                correctIcon.hidden = false
            }else{
                incorrectIcon.hidden = false
            }
        }
        
        let answerCount = question.anwers.count
        for index in 0..<answerTexts.count{
            let button = answerTexts[index]
            
            if(index < answerTexts.count - answerCount){
                button.hidden = true
            }else{
                let answerIndex = index - (answerTexts.count - answerCount)
                let u = UnicodeScalar(97 + answerIndex)
                let answer = "\(Character(u)). \(question.anwers[answerIndex])"
                
                button.hidden = false
                button.setAttributedTitle(QuestionHelper.createHtmlAttrib(answer), forState: .Normal)
                
                var color:UIColor!
                if showAnswer {
                    if answerIndex == question.correctAnswer {
                        color = UIColor.greenColor()
                    }else if answerIndex == question.userSelected {
                        color = UIColor.redColor()
                    }else{
                        color = UIColor.clearColor()
                    }
                }else{
                    color = UIColor.blueColor()
                }
                
                setButtonColor(button, color: color)
                
                button.selected = (answerIndex == question.userSelected)
            }
        }
    }
}
