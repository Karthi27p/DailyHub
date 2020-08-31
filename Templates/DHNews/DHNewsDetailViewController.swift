//
//  DHNewsDetailViewController.swift
//  DailyHub
//
//  Created by Karthi on 18/08/20.
//  Copyright © 2020 Karthi. All rights reserved.
//

import Foundation
import WebKit

class DHNewsDetailViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var webView: WKWebView!
    var url: URL!
   
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
}
