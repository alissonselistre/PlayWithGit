//
//  WebViewController.swift
//  PlayWithGit
//
//  Created by Alisson L. Selistre on 01/07/17.
//  Copyright © 2017 Alisson Selistre. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var customNavigationItem: UINavigationItem!
    
    var url: URL?
    var customTitle = ""
    
    //MARK: view methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self
        
        if let url = url {
            webView.loadRequest(URLRequest(url: url))
        }
        
        customNavigationItem.title = customTitle
    }
    
    //MARK: actions
    
    @IBAction func dismissButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: UIWebViewDelegate
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        LoadingOverlay.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        LoadingOverlay.hide()
    }
}
