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
    
    var anwers: [String] = []
    
    override init() {
        
    }
    
    init(json: NSDictionary) {
        self.questionTitle = json["questionTitle"] as! String
        self.correctAnswer = json["correctAnswer"] as! Int
        
        if let y = json["category"] as? String {
            self.category = y
        }
        
        self.anwers = (json["anwers"] as? [String])!
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
        
        let q3 = Question()
        q3.anwers = self.anwers
        q3.correctAnswer = self.correctAnswer
        
        questions += [q2, q3]
        
        return questions
    }
}
