//
//  MainScreen.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/7/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit
import GoogleMobileAds
import MessageUI

class MainScreen: DownloadViewController, MFMailComposeViewControllerDelegate  {
    @IBOutlet var icons: [UIImageView]!
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        GoogleAdsHelper.loadBanner(bannerView, uiViewController: self)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onExercise(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            let email = "voontv@gmail.com"
            let subject = "[EN]Request exercise : German grammar"
            let body = "Enter your request here."

        
            let picker = MFMailComposeViewController()

            picker.setSubject(subject)
            picker.setMessageBody(body, isHTML: true)
            picker.mailComposeDelegate = self
            picker.setToRecipients([email])
        
            presentViewController(picker, animated: true, completion: nil)
        }else{
            let alert = ViewUtils.createAlert("Could Not Send Email", message: "Your device could not send e-mail.  Please check your e-mail configuration and try again.")
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: false, completion: nil)
        }
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

        let bannerHeight = CGFloat(50)
        let spacingPercent = 0

        var topItem = self.imgTitle.frame.origin.y + self.imgTitle.bounds.height
        let midleLayoutHeight = viewHeight - topItem - bannerHeight
        
        let itemStepHeight = midleLayoutHeight / CGFloat(buttons.count)
        
        let buttonHeight = itemStepHeight * CGFloat(100-spacingPercent)/100
        let buttonWidth = buttonHeight * buttonSizeRatio
        
        let buttonMargin = (itemStepHeight - buttonHeight)
        let buttonX = (viewWidth - buttonWidth)/2
        
        for index in 0..<buttons.count{
            buttons[index].frame = CGRectMake(buttonX, topItem, buttonWidth, buttonHeight)
            topItem = topItem + buttonMargin + buttonHeight
        }
    }
}
