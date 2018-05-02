//
//  WikipediaViewController.swift
//  eu-member-data
//
//  Created by Tomi Lahtinen on 27/04/2018.
//  Copyright © 2018 Tomi Lahtinen. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WikipediaViewController: UIViewController, WKUIDelegate {
    @IBOutlet weak var webView: WKWebView!
    
    var country: Country!
    
    override func viewDidLoad() {
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        let userLang = Utils.userLang
        debugPrint("User language", userLang)
        let url = URL(string: "https://\(userLang).wikipedia.org/wiki/\(country.name[userLang]!)")!
        debugPrint("Wikipedia", url)
        webView.load(URLRequest(url: url))
    }
    
    // TODO: Remove these nodes from Wikipedia page to make it look betterS
    // <nav id="mw-mf-page-left" class="navigation-drawer view-border-box">
    // <div class="header-container header-chrome">
}
