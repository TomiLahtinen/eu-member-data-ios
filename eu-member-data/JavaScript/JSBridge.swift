//
//  JSBridge.swift
//  eu-member-data
//
//  Created by Tomi Lahtinen on 02/05/2018.
//  Copyright © 2018 Tomi Lahtinen. All rights reserved.
//

import Foundation
import WebKit

class JSBridge {
    
    func readFileAndEvaluate(resourceName: String, parameters: [String: String] = [:], webView: WKWebView) {
        if let path = Bundle.main.path(forResource: resourceName, ofType: "js") {
            do {
                let js = try String(contentsOf: URL(fileURLWithPath: path))
                if let paramters = parameters,
                    !parameters.isEmpty {
                    parameters.forEach { (key, value) in
                        js.repla
                    }
                }
                webView.evaluateJavaScript(js) { (anything, error) in
                    debugPrint("Any", anything, "Error", error)
                }
            } catch {
                fatalError("Error reading file")
            }
        }
    }
}
