//
//  UserResultController.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/22/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class UserResultController: NSObject {
    static let sharedInstance = UserResultController()
    static let FilePath = "userresult.json"
    
    var path:NSURL!
    var userResults:[UserResult] = []
    var needUpdate = false
    
    override init() {
        let dir = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
        self.path = NSURL(fileURLWithPath: dir!).URLByAppendingPathComponent(UserResultController.FilePath)
    }
    
    func load() {
        do {
            let dataText = try NSString(contentsOfURL: self.path, encoding: NSUTF8StringEncoding)
            let nsData = dataText.dataUsingEncoding(NSUTF8StringEncoding)
            let jsonData = try NSJSONSerialization.JSONObjectWithData(nsData!, options: NSJSONReadingOptions.MutableContainers)
            let jsonArray = jsonData as! NSMutableDictionary
            for (_, value) in jsonArray{
                userResults.append(UserResult(json: value as! NSDictionary))
            }
        }
        catch {/* error handling here */}
    }
    
    func save(){
        let jsonData = JSONSerializer.toJson(self.userResults)
        do {
            try jsonData.writeToURL(self.path, atomically: false, encoding: NSUTF8StringEncoding)
            needUpdate = true
        }
        catch {/* error handling here */}
    }
    
    func getScore(path: String) -> UserResult!{
        for result in self.userResults{
            if result.path == path {
                return result
            }
        }
        return nil
    }
    
    func updateScore(path: String, correct:Int, total:Int){
        var result = getScore(path)
        
        if result == nil {
            result = UserResult()
            result.path = path
            result.correct = correct
            result.total = total
            self.userResults.append(result)
        }else{
            result.correct = correct
            result.total = total
        }
        
        save()
    }
}
