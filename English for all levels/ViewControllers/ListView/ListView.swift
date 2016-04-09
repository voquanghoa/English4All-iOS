//
//  ListView.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/7/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class ListView: UIViewController {
    @IBOutlet weak var ListItemView: UITableView!
    var adapter:ListViewDataSource!
    
    @IBAction func onBack(sender: AnyObject) {
        if(!adapter.backItem()){
            print("Can not back")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ListItemView.registerNib(UINib(nibName: "DataItemUITableViewCell", bundle: nil), forCellReuseIdentifier: "DataItemUITableViewCell")
        self.adapter = ListViewDataSource(dataItem: AssertDataController.sharedInstance.dataItem, listItemView: self.ListItemView)

        self.ListItemView.dataSource = adapter
        self.ListItemView.delegate = adapter
    }
    
    
}
