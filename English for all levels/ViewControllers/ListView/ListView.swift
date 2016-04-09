//
//  ListView.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/7/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class ListView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var ListItemView: UITableView!
    var dataItem:DataItem!
    
    convenience init(dataItem: DataItem) {
        self.init()
        
        self.dataItem = dataItem
    }
    
    @IBAction func onBack(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.ListItemView.registerNib(UINib(nibName: "DataItemUITableViewCell", bundle: nil), forCellReuseIdentifier: "DataItemUITableViewCell")
        self.ListItemView.dataSource = self
        self.ListItemView.delegate = self
    }
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItem.children.count
    }
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = ListItemView.dequeueReusableCellWithIdentifier("DataItemUITableViewCell", forIndexPath: indexPath) as! DataItemUITableViewCell
        
        let fruit = self.dataItem.children[indexPath.row].display
        
        cell.setLabelText(fruit)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let nextItem = self.dataItem.children[indexPath.row]
        
        if(nextItem.children.count > 0){
            let childDataItem = self.dataItem.children[indexPath.row]
            self.navigationController?.pushViewController(ListView(dataItem: childDataItem), animated: true)
        }else{
            print("Can not enter")
        }
    }
}
