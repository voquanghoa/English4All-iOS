//
//  AssertDataController.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/7/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit


class AssertDataController: NSObject {
    
    static let sharedInstance = AssertDataController()
    
    var dataItem:DataItem! = nil
    
    override init() {
        let resourcePath = NSBundle.mainBundle().resourcePath!
        let fileDestinationUrl = NSURL(fileURLWithPath:resourcePath + "/data.json")
        
        do {
            let mytext = try String(contentsOfURL: fileDestinationUrl, encoding: NSUTF8StringEncoding)
            let data = mytext.dataUsingEncoding(NSUTF8StringEncoding)
            let json: NSDictionary = try (NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary)!
            dataItem = DataItem(json: json)
            
        } catch {
            print("error loading from url \(fileDestinationUrl)")
        }
    }
}
