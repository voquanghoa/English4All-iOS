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
    
    override init() {
        print("init class")
    }
    
    func prepar() {
        
        let resourcePath = NSBundle.mainBundle().resourcePath!

        print(resourcePath)
        let fileDestinationUrl = NSURL(fileURLWithPath:resourcePath + "/data.json")
        
        do {
            let mytext = try String(contentsOfURL: fileDestinationUrl, encoding: NSUTF8StringEncoding)
            print(mytext)
        } catch let error as NSError {
            print("error loading from url \(fileDestinationUrl)")
            print(error.localizedDescription)
        }
    }
}
