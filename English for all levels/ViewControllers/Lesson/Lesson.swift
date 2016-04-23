//
//  Lesson.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/11/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit
import GoogleMobileAds

class Lesson: UIViewController, UITableViewDataSource, UITableViewDelegate {

    static var adsCouter = 0
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var questionList: UITableView!
    
    var testContent: TestContent!
    var path: String!
    @IBOutlet weak var finishClick: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    var showAnswer = false
    
    func submitHandler(alert: UIAlertAction!) {
        finishButton.hidden = false
        submitButton.hidden = true
        Lesson.adsCouter = Lesson.adsCouter + 1
        if Lesson.adsCouter % 3 == 0 {
            interstitial.presentFromRootViewController(self)
        }
        self.questionList.reloadData()
    }
    
    @IBAction func finishClick(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func submitButtonClick(sender: AnyObject) {
        let correct = self.testContent.getCorrectCount()
        let total = self.testContent.getTotal()
        UserResultController.sharedInstance.updateScore(path, correct: correct, total: total)
        let message = "Your score is \(correct)/\(total)"
        let alert = ViewUtils.createNoticeAlert(message, handler: submitHandler)
        self.presentViewController(alert, animated: false, completion: nil)
        self.showAnswer = true
    }
    
    var interstitial: GADInterstitial!
    
    convenience init(testContent: TestContent, path: String){
        self.init()
        self.testContent = testContent.convertToReadable()
        self.path = path
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionList.registerNib(UINib(nibName: "LessonViewCell", bundle: nil), forCellReuseIdentifier: "LessonViewCell")
        self.questionList.registerNib(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: "QuestionCell")
        self.questionList.registerNib(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        
        self.questionList.estimatedRowHeight = 10
        self.questionList.rowHeight = UITableViewAutomaticDimension
        self.questionList.dataSource = self
        self.questionList.delegate = self
        self.questionList.backgroundColor = UIColor.clearColor()
        self.questionList.reloadData()
        
        
        GoogleAdsHelper.loadBanner(bannerView, uiViewController: self)
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        // Requests test ads on test devices.
        request.testDevices = ["2077ef9a63d2b398840261c8221a0c9b"]
        interstitial.loadRequest(request)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testContent.questions.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        let dataItem = testContent.questions[indexPath.row]
        
        if dataItem.category != ""{
            cell = questionList.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath)
            (cell as! CategoryCell).label.text = dataItem.category
        }else if dataItem.anwers.count == 0 {
            cell = questionList.dequeueReusableCellWithIdentifier("QuestionCell", forIndexPath: indexPath)
            (cell as! QuestionCell).setText(convertIndex(indexPath.row),text: dataItem.questionTitle)
        }else{
            cell = questionList.dequeueReusableCellWithIdentifier("LessonViewCell", forIndexPath: indexPath)
            (cell as! LessonViewCell).setQuestion(indexPath.row, question: dataItem, showAnswer:showAnswer)
            cell!.backgroundColor = UIColor.clearColor()
        }
        cell!.setNeedsLayout()
        
        return cell!
    }
    
    func convertIndex(index: Int) -> Int{
        var categorySkip = 0
        for i in 0...index{
            if testContent.questions[i].category != "" {
                categorySkip = categorySkip + 1
            }
        }
        return (index - categorySkip)/2
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
    }

}
