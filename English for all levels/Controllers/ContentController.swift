//
//  ContentController.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/11/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class ContentController: NSObject {
    class func decodeTestContent(dataText: String) -> TestContent{
        do{
            let nsData = dataText.dataUsingEncoding(NSUTF8StringEncoding)
            let json = try NSJSONSerialization.JSONObjectWithData(nsData!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            return TestContent(jsons: json)
        }catch{
            return TestContent()
        }
    }
    
    class func loadTestContent(path: String)-> TestContent{
        let resourcePath = NSBundle.mainBundle().resourcePath!
        let fileDestinationUrl = NSURL(fileURLWithPath:resourcePath + path)
        
        do {
            let mytext = try String(contentsOfURL: fileDestinationUrl, encoding: NSUTF8StringEncoding)
            return decodeTestContent(mytext)
            
        } catch {
            return TestContent()
        }
    }
}
