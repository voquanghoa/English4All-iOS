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
    static let BannerId = "ca-app-pub-5633074162966218/8147671087"
    static let PopupId = "ca-app-pub-5633074162966218/9624404285"
    
    class func createRequest() -> GADRequest{
        let request = GADRequest()

        request.testDevices = [ kGADSimulatorID, "86beb5d7ecb61d6d8e8a0e8c90fa8390" ]
        
        return request
    }
    
    class func loadBanner(bannerView: GADBannerView, uiViewController: UIViewController){
        bannerView.adUnitID = BannerId
        bannerView.rootViewController = uiViewController
        bannerView.loadRequest(createRequest())
    }
    
    static var interstitial:GADInterstitial!
    static var adsShowConter = 0
    
    class func loadPopup(){
        GoogleAdsHelper.interstitial = GADInterstitial(adUnitID: GoogleAdsHelper.PopupId)
        interstitial.loadRequest(createRequest())
    }
    
    class func checkAndShowPopup(uiController: UIViewController){
        adsShowConter = adsShowConter + 1
        if adsShowConter % 3 == 0 {
            interstitial.presentFromRootViewController(uiController)
        }
    }
    
}
