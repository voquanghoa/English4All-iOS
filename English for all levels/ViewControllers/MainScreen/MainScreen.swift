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
    let imgHighlight = [
        "main_menu_grammar_button_touched",
        "main_menu_examination_button_touched",
        "main_menu_study_offline_button_touched",
        "main_menu_listen_button_touched"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        GoogleAdsHelper.loadBanner(bannerView, uiViewController: self)
        for index in 0..<buttons.count{
            let highlightImg = UIImage(named:"\(imgHighlight[index]).png")
            buttons[index].setImage(highlightImg, forState: .Selected)
            buttons[index].setImage(highlightImg, forState: .Highlighted)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onExercise(sender: AnyObject) {
        
        if MFMailComposeViewController.canSendMail() {
            let email = "voontv@gmail.com"
            let subject = "[iOS]Request exercise : English for all levels"
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
        let commonMargin = CGFloat(8)
        
        let viewWidth = self.view.bounds.width
        let viewHeight = self.view.bounds.height
        
        let commonRight = viewWidth - commonMargin
        let commonLeft = commonMargin
        
        let topMargin = viewHeight * 70.0 / 900
        let bannerHeight = CGFloat(80)
        let spacingPercent = 15

        var topItem = self.imgTitle.bounds.origin.y + self.imgTitle.bounds.height + topMargin
        let midleLayoutHeight = viewHeight - topItem - bannerHeight
        
        let itemStepHeight = midleLayoutHeight / CGFloat(buttons.count)
        
        let buttonHeight = itemStepHeight * CGFloat(100-spacingPercent)/100;
        let buttonWidth = viewWidth - 2 * commonMargin - buttonHeight
        
        let iconSize = buttonHeight
        
        let iconRight =  commonRight - iconSize
        
        for i in 0..<buttons.count {
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
