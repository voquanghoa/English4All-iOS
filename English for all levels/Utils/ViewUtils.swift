//
//  ViewUtils.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/11/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class ViewUtils: NSObject {
    
    class func createDownloadingDialog()-> UIAlertController{
        let createAlert = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: UIAlertControllerStyle.Alert)
    
        let spinnerIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    
        spinnerIndicator.center = CGPointMake(135.0, 65.5)
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
