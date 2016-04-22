//
//  UserResult.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/22/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class UserResult: NSObject {
    var path = ""
    var correct = 0
    var total = 0
    
    override init() {
        
    }
    
    init(json: NSDictionary) {
        self.path = json["path"] as! String
        self.correct = json["correct"] as! Int
        self.total = json["total"] as! Int
    }
}
