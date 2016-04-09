//
//  ListViewDataSource.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/9/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//
import UIKit

class ListViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var dataItem:DataItem
    var currentItem: DataItem
    
    var ListItemView: UITableView!
    var stackView: [DataItem] = []
    
    init(dataItem: DataItem, listItemView: UITableView){
        self.dataItem = dataItem
        self.currentItem = dataItem
        self.ListItemView = listItemView
    }
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentItem.children.count
    }
    
    func reloadData() {
        dispatch_async(dispatch_get_main_queue(), {
            self.ListItemView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let nextItem = self.currentItem.children[indexPath.row]
        
        if(nextItem.children.count > 0){
            let childDataItem = self.currentItem.children[indexPath.row]
            self.stackView.append(self.currentItem)
            self.currentItem = childDataItem
            reloadData()
            print("Display item \(self.currentItem.display)")
        }else{
            print("Can not enter")
        }
    }
    
    func backItem() -> Bool {
        if(stackView.count == 0){
            return false
        }
        
        currentItem = stackView.popLast()!
        reloadData()
        return true
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("Show item at \(indexPath.row) list size is \(self.currentItem.children.count)")
        let cell = ListItemView.dequeueReusableCellWithIdentifier("DataItemUITableViewCell", forIndexPath: indexPath) as! DataItemUITableViewCell
        
        let fruit = self.currentItem.children[indexPath.row].display
        
        cell.setLabelText(fruit)
        
        return cell
    }
}
