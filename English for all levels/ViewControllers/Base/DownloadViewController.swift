//
//  DownloadViewController.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/12/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController {
    
    func hideDownloadIndicator(completion: () -> Void){
        dispatch_async(dispatch_get_main_queue(), {
            self.dismissViewControllerAnimated(false, completion: completion)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    func showDownloadIndicator(){
        let downloadingAlert = ViewUtils.createDownloadingDialog()
        self.presentViewController(downloadingAlert, animated: false, completion: nil)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func showDownloadFailAlert(){
        dispatch_async(dispatch_get_main_queue(), {
            let downloadFailAlert = ViewUtils.createNoticeAlert("Cannot download the file. Please check you internet connection and try again later.")
            self.presentViewController(downloadFailAlert, animated: false, completion: nil)
        })
    }
}
