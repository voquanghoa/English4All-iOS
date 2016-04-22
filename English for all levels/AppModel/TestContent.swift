//
//  TestContent.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/11/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class TestContent : NSObject{
    var questions: [Question] = []
    
    init(jsons: NSArray) {
        for i in 0..<jsons.count{
            self.questions.append(Question(json: jsons[i] as! NSDictionary))
        }
    }
    
    override init() {
        
    }
    
    func convertToReadable() -> TestContent{
        var questions: [Question] = []
        for question in self.questions {
            questions += question.extend()
        }
        
        let testContent = TestContent()
        testContent.questions = questions
        return testContent
    }
    
    func getTotal() -> Int{
        var total = 0
        for question in self.questions {
            if question.anwers.count > 1 {
                total = total + 1
            }
        }
        return total
    }
    
    func getCorrectCount() -> Int{
        var correct = 0
        for question in self.questions {
            if question.anwers.count > 1 {
                if question.isCorrect() {
                    correct = correct + 1
                }
            }
        }
        return correct
    }
}
