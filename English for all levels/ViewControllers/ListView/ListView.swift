//
//  ListView.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/7/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ListView: DownloadViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var ListItemView: UITableView!
    var dataItem:DataItem!
    var path: String!
    var selectedFileName: String!
    convenience init(dataItem: DataItem, parentPath: String) {
        self.init()
        self.path = "\(parentPath)/\(dataItem.fileName)"
        self.dataItem = dataItem
    }
    
    @IBAction func onBack(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ListItemView.backgroundColor = UIColor.clearColor()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = self.dataItem.display
        self.ListItemView.registerNib(UINib(nibName: "DataItemUITableViewCell", bundle: nil), forCellReuseIdentifier: "DataItemUITableViewCell")
        self.ListItemView.dataSource = self
        self.ListItemView.delegate = self
        GoogleAdsHelper.loadBanner(bannerView, uiViewController: self)
    }
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItem.children.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = ListItemView.dequeueReusableCellWithIdentifier("DataItemUITableViewCell", forIndexPath: indexPath) as! DataItemUITableViewCell
        let dataItem = self.dataItem.children[indexPath.row]
        
        cell.setLabelText(dataItem.display)
        cell.backgroundColor = UIColor.clearColor()
        cell.setViewStyle(dataItem.children.count == 0)
        cell.displayResultForPath("\(path)/\(dataItem.fileName)")
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let selectedItem = self.dataItem.children[indexPath.row]
        
        if(selectedItem.children.count > 0){
            self.navigationController?.pushViewController(ListView(dataItem: selectedItem, parentPath: self.path), animated: true)
        }else{
            prepareShowTestContent(selectedItem)
        }
    }
    
    func onDownloadDone(url:String, data:String, error:Bool){
        self.hideDownloadIndicator({ () -> Void in
                if(!error ){
                    self.showTestContent(ContentController.decodeTestContent(data), path:url)
                }else{
                    self.showDownloadFailAlert()
                }
            }
        )
    }
    
    override func viewWillAppear(animated: Bool) {
        if UserResultController.sharedInstance.needUpdate {
            self.ListItemView.reloadData()
        }
    }
    
    func prepareShowTestContent(selectedItem: DataItem){
        let selectedPath = "\(path)/\(selectedItem.fileName)"
        self.selectedFileName = selectedItem.display
        
        if (selectedPath.containsString("/assets/")){
            let testContent = ContentController.loadTestContent(selectedPath)
            
            showTestContent(testContent, path:selectedPath)
        }else{
            self.showDownloadIndicator()
            HttpDownloader.load(selectedPath, completion: onDownloadDone)
        }
    }
    
    func showTestContent(testContent: TestContent, path:String){
        dispatch_async(dispatch_get_main_queue()){
            self.navigationController?.pushViewController(Lesson(testContent: testContent, path: path, name: self.selectedFileName), animated: true)
        }
    }
}
