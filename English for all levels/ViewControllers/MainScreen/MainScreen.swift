//
//  MainScreen.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/7/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MainScreen: DownloadViewController {
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var imgTitle: UIImageView!

    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        GoogleAdsHelper.loadBanner(bannerView, uiViewController: self)
    }

    @IBAction func onExercise(sender: AnyObject) {
        let email = "voontv@gmail.com"
        let subject = "[EN]Request exercise : English for all levels"
        let body = "Enter your request here."
        let url = NSURL(string: "mailto:\(email)?subject=\(subject)&body=\(body)")
        
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func showListView(dataItem: DataItem!){
        if(dataItem != nil){
            self.navigationController?.pushViewController(ListView(dataItem: dataItem, parentPath: ""), animated: true)
        }
    }
    
    func onDownloadDone(url:String, data:String, error:Bool){
        dispatch_async(dispatch_get_main_queue()){
            var dataItem: DataItem! = nil
            if(!error ){
                if (url.containsString("grammar")){
                    AssertDataController.sharedInstance.loadGramarData(data)
                    dataItem = AssertDataController.sharedInstance.grammarData
                }else{
                    AssertDataController.sharedInstance.loadExaminaton(data)
                    dataItem = AssertDataController.sharedInstance.examination
                }
                self.hideDownloadIndicator({ () -> Void in
                    self.showListView(dataItem)
                })
            }else{
                self.hideDownloadIndicator({ () -> Void in
                    self.showDownloadFailAlert()
                })
            }
        }
    }
    
    @IBAction func onExaminationClicked(sender: AnyObject) {
        if(AssertDataController.sharedInstance.examination != nil){
            showListView(AssertDataController.sharedInstance.examination)
        }else{
            showDownloadIndicator()
            HttpDownloader.load("/examination/data.json", completion: onDownloadDone)
        }
    }
    
    @IBAction func onGrammarClicked(sender: AnyObject) {
        if(AssertDataController.sharedInstance.grammarData != nil){
            showListView(AssertDataController.sharedInstance.grammarData)
        }else{
            showDownloadIndicator()
            HttpDownloader.load("/grammar/data.json", completion: onDownloadDone)
        }
    }

    @IBAction func onOfflineClicked(sender: AnyObject) {
        self.showListView(AssertDataController.sharedInstance.assetData)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        rearrangeGraphics()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func rearrangeGraphics()  {
        let buttonSizeRatio = CGFloat(951.0/223)
        
        let viewWidth = self.view.bounds.width
        let viewHeight = self.view.bounds.height

        let bannerHeight = CGFloat(80)
        let spacingPercent = 0

        var topItem = self.imgTitle.frame.origin.y + self.imgTitle.bounds.height
        let midleLayoutHeight = viewHeight - topItem - bannerHeight
        
        let itemStepHeight = midleLayoutHeight / CGFloat(buttons.count)
        
        let buttonHeight = itemStepHeight * CGFloat(100-spacingPercent)/100
        let buttonWidth = buttonHeight * buttonSizeRatio
        
        let buttonHalfMargin = (itemStepHeight - buttonHeight) / 2
        let buttonX = (viewWidth - buttonWidth)/2
        
        for index in 0..<buttons.count{
            topItem = topItem + buttonHalfMargin
            buttons[index].frame = CGRectMake(buttonX, topItem, buttonWidth, buttonHeight)
            topItem = topItem + buttonHalfMargin + buttonHeight
        }
    }
}
