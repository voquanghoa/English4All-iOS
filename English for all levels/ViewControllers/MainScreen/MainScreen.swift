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
    
    let branchName = [
        "LEVEL_A1",
        "LEVEL_A2",
        "LEVEL_B1",
        "LEVEL_B2",
        "LEVEL_C1",
        "GRAMMAR"
    ]
    
    @IBAction func onButtonClick(sender: AnyObject) {
        let branch = self.branchName[(sender as! UIButton).tag]
        let dataItem = AssertDataController.sharedInstance.getDataBranch(branch)
        showListView(dataItem)
        print("Sender \(branch)")
        print( (sender as! UIButton).tag)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        GoogleAdsHelper.loadBanner(bannerView, uiViewController: self)
    }

    @IBAction func onExercise(sender: AnyObject) {
        let email = "voontv@gmail.com"
        let subject = "[EN]Request exercise : German grammar"
        let body = "Enter your request here."
        let url = NSURL(string: "mailto:\(email)?subject=\(subject)&body=\(body)")
        
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func showListView(dataItem: DataItem!){
        if(dataItem != nil){
            self.navigationController?.pushViewController(ListView(dataItem: dataItem, parentPath: "/assets"), animated: true)
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
