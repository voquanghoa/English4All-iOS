//
//  MainScreen.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/7/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class MainScreen: UIViewController {

    @IBOutlet var icons: [UIImageView]!
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var imgTitle: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

    @IBAction func showListView(sender: AnyObject) {
        self.view.window?.rootViewController = ListView()
        self.view.window?.makeKeyAndVisible()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        rearrangeGraphics()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        rearrangeGraphics()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rearrangeGraphics()  {
        let commonMargin = CGFloat(8)
        
        let viewWidth = self.view.bounds.width
        let viewHeight = self.view.bounds.height
        
        let commonRight = viewWidth - commonMargin
        let commonLeft = commonMargin
        
        let topMargin = viewHeight * 70.0 / 900
        let bannerHeight = CGFloat(80)
        let spacingPercent = 15 //%

        var topItem = self.imgTitle.bounds.origin.y + self.imgTitle.bounds.height + topMargin
        let midleLayoutHeight = viewHeight - topItem - bannerHeight
        
        let itemStepHeight = midleLayoutHeight/5
        
        let buttonHeight = itemStepHeight * CGFloat(100-spacingPercent)/100;
        let buttonWidth = viewWidth - 2 * commonMargin - buttonHeight
        
        let iconSize = buttonHeight
        
        let iconRight =  commonRight - iconSize
        
        for i in 0...4{
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
