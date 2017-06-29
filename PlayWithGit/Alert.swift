//
//  Alert.swift
//  PlayWithGit
//
//  Created by Alisson Selistre on 29/06/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import UIKit

class Alert {
    
    //MARK: public warning methods
    
    class func showMessage(title: String?, message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
    class func showSuccessMessage(message: String) {
        showMessage(title: "Success!", message: message)
    }
    
    class func showErrorMessage(message: String) {
        showMessage(title: "Oops!", message: message)
    }
}
