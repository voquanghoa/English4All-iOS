//
//  File.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/8/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import Foundation

class DataItem : NSObject {
    var fileName:String = ""
    var display: String = "";
    var children: [DataItem] = []
    
    init(json: NSDictionary) {
        self.fileName = json["fileName"] as! String
        self.display = json["display"] as! String
        if let items = json["children"] as? NSArray {
            for item in items {
                children.append(DataItem(json: item as! NSDictionary))
            }
        }
    }
}