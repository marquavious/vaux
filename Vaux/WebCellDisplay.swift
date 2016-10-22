//
//  WebCellDisplay.swift
//  beatkeep
//
//  Created by Marquavious on 8/26/16.
//  Copyright © 2016 marqmakesapps. All rights reserved.
//

import UIKit
import Foundation
class WebCellDisplay: UIViewController {
    
    
    func displayAlert(_ title: String, message: String){
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)

        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    var webLink: SongObject?
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidAppear(_ animated: Bool) {
        let urlForCheck = webLink?.songLink
        if (urlForCheck!.containsIgnoringCase("HTTP") == true ) {
            if verifyUrl(urlForCheck) == false {
                
                displayAlert("ERROR", message: "Link is invalid")
            } else {
                
                let url = URL(string: "\(urlForCheck)")
                let request = URLRequest(url: url!)
                webView.loadRequest(request)
            }
        } else {

            if urlForCheck?.characters.count == 0 {
                
                let artist = webLink?.songArtist
                let song = webLink?.songTitle
                let editedLink = "https://www.youtube.com/results?search_query="+artist!+"+"+song!
                let editedLinkAgain = editedLink.replace(" ", withString:"+")
                let url = URL(string: editedLinkAgain)
                let request = URLRequest(url: url!)
                webView.loadRequest(request)
                return
            } else{
                displayAlert("ERROR", message: "Link is invalid. Defaulted to search.")
                let artist = webLink?.songArtist
                let song = webLink?.songTitle
                let editedLink = "https://www.youtube.com/results?search_query="+artist!+"+"+song!
                let editedLinkAgain = editedLink.replace(" ", withString:"+")
                let url = URL(string: editedLinkAgain)
                let request = URLRequest(url: url!)
                webView.loadRequest(request)
                return
            }
        }
    }
    
    func verifyUrl (_ urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(url) {
                } else {
                    
                }
            }
        }
        return false
    }
}




