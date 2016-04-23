//
//  ViewUtils.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/11/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class ViewUtils: NSObject {
    
    class func createAlert(title: String, message: String) -> UIAlertController{
        return UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    }
    
    class func createNoticeAlert(message: String) -> UIAlertController{
        return createNoticeAlert(message, handler: nil)
    }
    
    class func createNoticeAlert(message: String, handler: ((UIAlertAction) -> Void)?) -> UIAlertController{
        return createNoticeAlert("Notice", message:message, handler: handler)
    }
    
    class func createNoticeAlert(title:String, message: String,  handler: ((UIAlertAction) -> Void)?) -> UIAlertController{
        let alert = ViewUtils.createAlert(title, message:message)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: handler))
        return alert
    }
    
    class func createDownloadingDialog()-> UIAlertController{
        let createAlert = ViewUtils.createAlert("Downloading", message:"Please wait\n\n\n\n")
        
        let spinnerIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        spinnerIndicator.center = CGPointMake(135.0, 85.5)
        spinnerIndicator.color = UIColor.blackColor()
        spinnerIndicator.startAnimating()
        
        createAlert.view.addSubview(spinnerIndicator)
        
        return createAlert
    }
}
