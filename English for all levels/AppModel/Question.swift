//
//  Question.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/11/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class Question: NSObject {
    var questionTitle: String = ""
    
    var correctAnswer: Int = -1
    var userSelected: Int = -1
    var category: String = ""
    var answerDisplay:String = ""
    var questionIndex = 0
    var answerDisplayIndex = 0
    
    var anwers: [String] = []
    
    override init() {
        
    }
    
    init(json: NSDictionary) {
        self.questionTitle = json["questionTitle"] as! String
        self.correctAnswer = json["correctAnswer"] as! Int
        
        if let y = json["category"] as? String {
            self.category = y
        }
        
        self.anwers = (json["answers"] as? [String])!
    }
    
    func isUserSelected() -> Bool{
        return userSelected >= 0
    }
    
    func isCorrect() -> Bool{
        return isUserSelected() && (userSelected == correctAnswer)
    }
    
    func particularCopy(answer:[String], index:Int) -> [String]{
        var ret:[String] = []
        for i in 0..<answer.count{
            ret.append(i == index ? answer[i] : "")
        }
        return ret
    }
    
    func extend() -> [Question]{
        var questions: [Question] = []
        
        if self.category != "" {
            let q1 = Question()
            q1.category = self.category
            questions += [q1]
        }
        
        let q2 = Question()
        q2.questionTitle = self.questionTitle
        q2.questionIndex = self.questionIndex
        questions.append(q2)
        
        for i in 0..<self.anwers.count{
            let q3 = Question()
            q3.answerDisplay = self.anwers[i]
            q3.questionIndex = self.questionIndex
            q3.answerDisplayIndex = i
            questions.append(q3)
        }
        
        return questions
    }
}
