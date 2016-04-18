//
//  GoogleAdsHelper.swift
//  English for all levels
//
//  Created by Vo Quang Hoa on 4/18/16.
//  Copyright © 2016 Vo Quang Hoa. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GoogleAdsHelper: NSObject {
    static let BannerId = "ca-app-pub-3940256099942544/2934735716"
    
    class func loadBanner(bannerView: GADBannerView, uiViewController: UIViewController){
        bannerView.adUnitID = BannerId
        bannerView.rootViewController = uiViewController
        bannerView.loadRequest(GADRequest())
    }
    
    
}
