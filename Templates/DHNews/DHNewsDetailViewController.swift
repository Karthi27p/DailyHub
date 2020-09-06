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
    var progressBar: UIProgressView!
   
    //MARK: Life Cycle Methods
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        self.progressBar = progressView
        self.view.addSubview(progressView)
        self.configureProgressView(progressView: progressView)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func viewDidLoad() {
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    //MARK: ProgressView Configuration
    func configureProgressView(progressView: UIProgressView) {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true

        if #available(iOS 11.0, *) {
            progressView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        }
        progressView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        progressView.setProgress(0.0, animated: true)
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 4)
        progressView.backgroundColor = .gray
        progressView.tintColor = .blue
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.progressBar.progress = Float(webView.estimatedProgress)
            self.progressBar.isHidden = webView.estimatedProgress == 1.0
        }
    }
    
}
