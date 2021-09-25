//
//  WebViewVC.swift
//  Smoothie
//
//  Created by Ajay Yadav on 25/09/21.
//

import Foundation
import UIKit
import WebKit

class WebViewVC : UIViewController {

    @IBOutlet weak var webviewInstance : WKWebView!
    var urlString : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webviewInstance.load(NSURLRequest(url: NSURL(string: urlString)! as URL) as URLRequest)

    }
    
}
