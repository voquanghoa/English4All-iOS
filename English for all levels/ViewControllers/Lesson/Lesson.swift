//
//  Lesson.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/11/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class Lesson: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var questionList: UITableView!
    var testContent: TestContent!
    
    convenience init(testContent: TestContent){
        self.init()
        self.testContent = testContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionList.registerNib(UINib(nibName: "LessonViewCell", bundle: nil), forCellReuseIdentifier: "LessonViewCell")
        
        self.questionList.estimatedRowHeight = 200
        self.questionList.rowHeight = UITableViewAutomaticDimension
        self.questionList.dataSource = self
        self.questionList.delegate = self

    }
    
    override func viewWillAppear(animated: Bool) {
        self.questionList.reloadData()
    }
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testContent.questions.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = questionList.dequeueReusableCellWithIdentifier("LessonViewCell", forIndexPath: indexPath) as! LessonViewCell
        let question = self.testContent.questions[indexPath.row]
        cell.setQuestion(question)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
    }

}
