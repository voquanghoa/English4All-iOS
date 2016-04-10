//
//  HttpDownloader.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/10/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class HttpDownloader: NSObject {
    class func load(urlPath: String, completion:(url:String, data:String, error:Bool) -> Void) {
            let url = NSURL(string: urlPath)
            let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "GET"
            let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                if (error == nil) {
                    let statusCode = (response as! NSHTTPURLResponse).statusCode
                    
                    if(statusCode == 200){
                        let newStr = String(data: data!, encoding: NSUTF8StringEncoding)
                        completion(url:urlPath, data: newStr!, error: false)
                    }else{
                        completion(url:urlPath, data: "", error: true)
                    }
                }
                else {
                    completion(url:urlPath, data: "", error: true)
                }
            })
            task.resume()
        }
}
