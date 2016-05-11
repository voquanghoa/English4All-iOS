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
    
    var correctIndexs:[Int]!
    var userSelected:[Int]!
    
    
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
        var correct = 0
        let total = self.correctIndexs.count
        for i in 0..<total {
            if self.correctIndexs[i] == self.userSelected[i] {
                correct = correct + 1
            }
        }
        UserResultController.sharedInstance.updateScore(path, correct: correct, total: total)
        let message = "Your score is \(correct)/\(total)."
        let alert = ViewUtils.createNoticeAlert(message, handler: submitHandler)
        self.presentViewController(alert, animated: false, completion: nil)
    }
    
    convenience init(testContent: TestContent, path: String, name: String){
        self.init()
        self.correctIndexs = [Int](count: testContent.questions.count, repeatedValue: 0)
        self.userSelected = [Int](count: testContent.questions.count, repeatedValue: -1)
        for i in 0..<testContent.questions.count {
            self.correctIndexs[i] = testContent.questions[i].correctAnswer
        }
        
        self.testContent = testContent.convertToReadable()
        self.path = path
        self.title = name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LessonViewCell.InitViewSet()
        
        self.questionList.registerNib(UINib(nibName: "LessonViewCell", bundle: nil), forCellReuseIdentifier: "LessonViewCell")
        self.questionList.registerNib(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: "QuestionCell")
        self.questionList.registerNib(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        
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
        }else if dataItem.answerDisplay == "" {
            cell = questionList.dequeueReusableCellWithIdentifier("QuestionCell", forIndexPath: indexPath)
            (cell as! QuestionCell).setText(dataItem.questionIndex,text: dataItem.questionTitle)
        }else{
            cell = questionList.dequeueReusableCellWithIdentifier("LessonViewCell", forIndexPath: indexPath)
            (cell as! LessonViewCell).setDisplay(
                dataItem,
                showAnswer: showAnswer,
                isSelected: self.userSelected[dataItem.questionIndex] == dataItem.answerDisplayIndex,
                isUserCorrect: self.userSelected[dataItem.questionIndex] == self.correctIndexs[dataItem.questionIndex],
                isAnswerCorrect: self.correctIndexs[dataItem.questionIndex] == dataItem.answerDisplayIndex
            )
            
            (cell as! LessonViewCell).setSelectedCallBack(onUserSelected)
            
            
            cell!.backgroundColor = UIColor.clearColor()
            
        }
        cell!.setNeedsLayout()
        
        return cell!
    }
    
    func onUserSelected(cell: LessonViewCell) -> Void{
        self.userSelected[cell.question.questionIndex] = cell.question.answerDisplayIndex
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
    }

}
