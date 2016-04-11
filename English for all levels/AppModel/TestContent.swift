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
}
