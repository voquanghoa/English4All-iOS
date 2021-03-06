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
    
    var assetData:DataItem! = nil
    var grammarData: DataItem! = nil
    var examination: DataItem! = nil
    
    override init() {
        let resourcePath = NSBundle.mainBundle().resourcePath!
        let fileDestinationUrl = NSURL(fileURLWithPath:resourcePath + "/assets/data.json")
        
        do {
            let mytext = try String(contentsOfURL: fileDestinationUrl, encoding: NSUTF8StringEncoding)
            self.assetData = AssertDataController.decodeJson(mytext)
            
        } catch {
            print("error loading from url \(fileDestinationUrl)")
        }
    }
    
    class func decodeJson(text: NSString) -> DataItem{
        do{
            let nsData = text.dataUsingEncoding(NSUTF8StringEncoding)
            let json: NSDictionary = try (NSJSONSerialization.JSONObjectWithData(nsData!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary)!
            return DataItem(json: json)
            
        }catch{
            return DataItem()
        }
    }
    
    func loadGramarData(data: String){
        grammarData = AssertDataController.decodeJson(data)
    }
    
    func loadExaminaton(data: String){
        examination = AssertDataController.decodeJson(data)
    }
}
