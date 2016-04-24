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

    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var questionList: UITableView!
    @IBOutlet weak var finishClick: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    var testContent: TestContent!
    var path: String!
    var showAnswer = false
    
    func submitHandler(alert: UIAlertAction!) {
        finishButton.hidden = false
        submitButton.hidden = true
        GoogleAdsHelper.checkAndShowPopup(self)
        self.showAnswer = true
        self.questionList.reloadData()
    }
    
    @IBAction func finishClick(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func submitButtonClick(sender: AnyObject) {
        let correct = self.testContent.getCorrectCount()
        let total = self.testContent.getTotal()
        UserResultController.sharedInstance.updateScore(path, correct: correct, total: total)
        let message = "Your score is \(correct)/\(total)."
        let alert = ViewUtils.createNoticeAlert(message, handler: submitHandler)
        self.presentViewController(alert, animated: false, completion: nil)
    }
    
    convenience init(testContent: TestContent, path: String, name: String){
        self.init()
        self.testContent = testContent.convertToReadable()
        self.path = path
        self.title = name
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
        GoogleAdsHelper.loadPopup()
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
