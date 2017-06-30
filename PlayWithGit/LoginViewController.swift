//
//  LoginViewController.swift
//  PlayWithGit
//
//  Created by Alisson Selistre on 29/06/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: view methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            tryLogin()
        }
        
        return true
    }
    
    // actions
    
    @IBAction func goButtonPressed(_ sender: UIButton) {
        tryLogin()
    }
    
    @IBAction func loginDefaultUserButtonPressed(_ sender: UIButton) {
        usernameTextField.text = "githubzin"
        passwordTextField.text = "1234git"
        tryLogin()
    }
    
    // helpers
    
    private func validateFields() -> Bool {

        if usernameTextField.text?.characters.count == 0 {
            Alert.showMessage(title: nil, message: "Missing username")
            return false
        }
        
        if passwordTextField.text?.characters.count == 0 {
            Alert.showMessage(title: nil, message: "Missing password")
            return false
        }
        
        return true
    }
    
    private func tryLogin() {
        
        if validateFields() {
            
            guard let username = usernameTextField.text else { return }
            guard let password = passwordTextField.text else { return }
            
            NetworkManager.loginWithCredentials(username: username, password: password, completion: { (success) in
                
                if (success) {
                    
                    NetworkManager.getUserForUsername(username: username, completion: { (user) in
                        
                        if let user = user {
                            
                            NetworkManager.loggedUser = user
                            
                            self.dismiss(animated: true, completion: nil)
                            
                        } else {
                            Alert.showErrorMessage(message: "Error when retrieving the user information.")
                        }
                    })
                } else {
                    Alert.showErrorMessage(message: "User not found")
                }
            })
        }
    }
}
