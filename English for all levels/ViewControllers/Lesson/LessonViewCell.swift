//
//  LessonViewCell.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/11/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class LessonViewCell: UITableViewCell {
    static var answerViews:Set<LessonViewCell>!
    
    @IBOutlet weak var answerRadioButton: DLRadioButton!
    var showAnswer = false
    var question: Question!
    var selectedCallback:(cell: LessonViewCell) -> Void = LessonViewCell.dummyCallBack
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        LessonViewCell.answerViews.insert(self)
    }
    
    class func dummyCallBack(cell: LessonViewCell) -> Void{
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        LessonViewCell.answerViews.insert(self)
    }
    
    @IBAction func onAnswerClick(sender: AnyObject) {
        if !showAnswer {
            let clickedButton = sender as! DLRadioButton
            question.userSelected = clickedButton.tag
            answerRadioButton.selected = true
        
            for cell in LessonViewCell.answerViews {
                if cell != self && cell.question.questionIndex == self.question.questionIndex{
                    cell.answerRadioButton.selected = false
                }
            }
            selectedCallback(cell: self)
        }
    }
    
    func setSelectedCallBack(callback: (cell: LessonViewCell) -> Void){
        selectedCallback = callback
    }
    
    class func InitViewSet(){
        answerViews = Set<LessonViewCell>()
        
    }
    
    func setButtonColor(button: DLRadioButton, color: UIColor){
        button.iconColor = color
        button.indicatorColor = color
        button.tintColor = color
        button.setNeedsDisplay()
    }
    
    func setDisplay(question: Question, showAnswer: Bool, isSelected:Bool, isUserCorrect:Bool, isAnswerCorrect:Bool){
        self.question = question
        self.showAnswer = showAnswer
        let u = UnicodeScalar(97 + question.answerDisplayIndex)
        let answer = "\(Character(u)). \(question.answerDisplay)"
        
        self.answerRadioButton.setAttributedTitle(QuestionHelper.createHtmlAttrib(answer), forState: .Normal)
        self.answerRadioButton.selected = isSelected
        
        var color:UIColor!
        if showAnswer {
            if isSelected {
                if isUserCorrect{
                    color = UIColor.greenColor()
                }else{
                    color = UIColor.redColor()
                }
            }else{
                if isAnswerCorrect {
                    color = UIColor.blueColor()
                }else{
                    color = UIColor.clearColor()
                }
            }
        }else{
            color = UIColor.blueColor()
        }
        setButtonColor(answerRadioButton, color: color)
    }
}
