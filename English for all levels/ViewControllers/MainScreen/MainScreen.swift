//
//  MainScreen.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/7/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class MainScreen: UIViewController {
    let activitiyViewController = ActivityViewController(message: "Loading...")
    @IBOutlet var icons: [UIImageView]!
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var imgTitle: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
    }

    func showLoadingDialog() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let alertController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: UIAlertControllerStyle.Alert)
        
        let spinnerIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        spinnerIndicator.center = CGPointMake(135.0, 65.5)
        spinnerIndicator.color = UIColor.blackColor()
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        self.presentViewController(alertController, animated: false, completion: nil)
    }
    
    func hideLoadingDialog(){
        dispatch_async(dispatch_get_main_queue(), {
            
        })
    }
    
    func showListView(dataItem: DataItem!){
        if(dataItem != nil){
            self.navigationController?.pushViewController(ListView(dataItem: dataItem), animated: true)
        }
    }
    
    func onDownloadDone(url:String, data:String, error:Bool){
        var dataItem: DataItem! = nil
        if(!error ){
            if (url.containsString("grammar")){
                AssertDataController.sharedInstance.loadGramarData(data)
                dataItem = AssertDataController.sharedInstance.grammarData
            }else{
                AssertDataController.sharedInstance.loadExaminaton(data)
                dataItem = AssertDataController.sharedInstance.examination
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            self.dismissViewControllerAnimated(false, completion: { () -> Void in
                    self.showListView(dataItem)
            })
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    @IBAction func onExaminationClicked(sender: AnyObject) {
        if(AssertDataController.sharedInstance.examination != nil){
            self.navigationController?.pushViewController(ListView(dataItem: AssertDataController.sharedInstance.examination), animated: true)
        }else{
            showLoadingDialog()
            HttpDownloader.load("http://doanit.com/appdata/english4all/examination/data.json", completion: onDownloadDone)
        }
    }
    
    @IBAction func onGrammarClicked(sender: AnyObject) {
        if(AssertDataController.sharedInstance.grammarData != nil){
            self.navigationController?.pushViewController(ListView(dataItem: AssertDataController.sharedInstance.grammarData), animated: true)
        }else{
            showLoadingDialog()
            HttpDownloader.load("http://doanit.com/appdata/english4all/grammar/data.json", completion: onDownloadDone)
        }

    }

    @IBAction func onOfflineClicked(sender: AnyObject) {
        self.navigationController?.pushViewController(ListView(dataItem: AssertDataController.sharedInstance.assetData), animated: true)
    }
    
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        rearrangeGraphics()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        
        rearrangeGraphics()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rearrangeGraphics()  {
        let commonMargin = CGFloat(8)
        
        let viewWidth = self.view.bounds.width
        let viewHeight = self.view.bounds.height
        
        let commonRight = viewWidth - commonMargin
        let commonLeft = commonMargin
        
        let topMargin = viewHeight * 70.0 / 900
        let bannerHeight = CGFloat(80)
        let spacingPercent = 15 //%

        var topItem = self.imgTitle.bounds.origin.y + self.imgTitle.bounds.height + topMargin
        let midleLayoutHeight = viewHeight - topItem - bannerHeight
        
        let itemStepHeight = midleLayoutHeight/5
        
        let buttonHeight = itemStepHeight * CGFloat(100-spacingPercent)/100;
        let buttonWidth = viewWidth - 2 * commonMargin - buttonHeight
        
        let iconSize = buttonHeight
        
        let iconRight =  commonRight - iconSize
        
        for i in 0...4 {
            if (i % 2 == 0){
                icons[i].frame = CGRectMake(commonLeft, topItem, iconSize, iconSize)
                buttons[i].frame = CGRectMake(commonRight - buttonWidth, topItem , buttonWidth, buttonHeight)
            }else{
                icons[i].frame = CGRectMake(iconRight, topItem, iconSize, iconSize)
                buttons[i].frame = CGRectMake(commonLeft, topItem , buttonWidth, buttonHeight)
            }
            topItem = topItem + itemStepHeight
        }
    }
}
