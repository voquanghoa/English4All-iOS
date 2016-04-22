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
    
    func setQuestion(index: Int, question: Question, showAnswer: Bool){
        self.question = question
        self.showAnswer = showAnswer
        
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
                button.selected = true
                //button.enabled = !showAnswer
                
                if(questionIndex != question.userSelected){
                    button.selected = false
                }
                
                if showAnswer {
                    
                }
            }
        }
    }
}
