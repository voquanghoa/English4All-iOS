//
//  ViewUtils.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/11/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class ViewUtils: NSObject {
    class func createAlert(message: String, title: String) -> UIAlertController{
        return UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    }
    
    class func createNoticeAlert(message: String) -> UIAlertController{
        let alert = ViewUtils.createAlert(message, title: "Notice")
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        return alert
    }
    
    class func createDownloadingDialog()-> UIAlertController{
        let createAlert = ViewUtils.createAlert("Please wait\n\n\n\n", title: "Downloading")
        
        let spinnerIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        spinnerIndicator.center = CGPointMake(135.0, 85.5)
        spinnerIndicator.color = UIColor.blackColor()
        spinnerIndicator.startAnimating()
        
        createAlert.view.addSubview(spinnerIndicator)
        
        return createAlert
    }
    
    class func getViewContentHeight(textView: UITextView) -> CGFloat{
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame;
        return newSize.height
    }
}
