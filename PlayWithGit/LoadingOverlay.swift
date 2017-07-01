//
//  LoadingOverlay.swift
//  PlayWithGit
//
//  Created by Alisson L. Selistre on 01/07/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import UIKit

class LoadingOverlay {
    
    private static let OVERLAY_TAG = 6969
    
    //MARK: public methods
    
    class func show() {

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        guard let mainWindow = getMainWindow() else { return }
        
        var overlay = mainWindow.viewWithTag(OVERLAY_TAG)
        
        if overlay == nil {
            
            // create the overlay
            let newOverlay = UIView(frame: mainWindow.frame)
            newOverlay.tag = OVERLAY_TAG
            newOverlay.center = mainWindow.center
            newOverlay.alpha = 0
            newOverlay.backgroundColor = UIColor.black
            mainWindow.addSubview(newOverlay)
            mainWindow.bringSubview(toFront: newOverlay)
            
            // create the network indicator
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
            indicator.center = newOverlay.center
            indicator.startAnimating()
            newOverlay.addSubview(indicator)
            
            overlay = newOverlay
        }
        
        if let overlay = overlay {
            
            overlay.alpha = 0
            
            // animate the overlay to show
            UIView.animate(withDuration: 0.5, animations: { 
                overlay.alpha = 0.5
            })
        }
    }
    
    class func hide() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        guard let mainWindow = getMainWindow() else { return }
        
        if let overlay = mainWindow.viewWithTag(OVERLAY_TAG) {
            
            // animate the overlay to hide
            UIView.animate(withDuration: 0.5, animations: { 
                overlay.alpha = 0
            }, completion: { (success) in
                overlay.removeFromSuperview()
            })
        }
    }
    
    //MARK : helpers
    
    private class func getMainWindow() -> UIWindow? {
        guard let mainWindow = UIApplication.shared.keyWindow else {
            print("There is no place to show the loading overlay.")
            return nil
        }
        
        return mainWindow
    }
}
