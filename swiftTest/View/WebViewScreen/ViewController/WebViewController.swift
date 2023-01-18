//
//  WebViewController.swift
//  swiftTest
//
//  Created by MacBook on 18/01/23.
//

import UIKit
import WebKit


class WebViewController: UIViewController {

    
    let webview = WKWebView()
    var urlData: String = ""
    
    @IBOutlet weak var vwContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        urlData = "https://www.youtube.com/watch?v=JafGypqFvs4"
        
        
        vwContainer.addSubview(webview)
        guard let url = URL(string:urlData) else {
            return
        }
        
    
        DispatchQueue.main.async {
            self.webview.load(URLRequest(url: url))

        }

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webview.frame = vwContainer.bounds
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
