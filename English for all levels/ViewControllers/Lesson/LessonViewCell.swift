//
//  LessonViewCell.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/11/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class LessonViewCell: UITableViewCell {

    @IBOutlet weak var questionTitle: UITextView!

    @IBOutlet var answerTexts: [UIButton]!
    var contentHeight:CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setQuestion(question: Question){
        questionTitle.text = question.questionTitle
        
        var height = ViewUtils.getViewContentHeight(questionTitle)
        
        height = height + questionTitle.frame.origin.y + 5
        
        let answerCount = question.anwers.count
        for index in 0..<answerTexts.count{
            let button = answerTexts[index]
            
            if(index < answerTexts.count - answerCount){
                button.hidden = true
            }else{
                button.hidden = false
                button.setTitle(question.anwers[index - (answerTexts.count - answerCount)], forState: .Normal)
                height = height + button.frame.origin.y + 27
            }
        }
        height = height + 200
        contentHeight = height
        

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
