//
//  ListView.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/7/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit

class ListView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        AssertDataController.sharedInstance.prepar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
