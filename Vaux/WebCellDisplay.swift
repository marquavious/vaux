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
    
    var songObject: SongObject?
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidAppear(_ animated: Bool) {
        // TODO: Check for internet connection here
        if let songObject = songObject{
            let artist = songObject.songArtist
            let song = songObject.songTitle
            let fullURL = "https://www.youtube.com/results?search_query="+artist!+"+"+song!
            let finalURL = fullURL.replace(" ", withString:"+")
            let url = URL(string: finalURL)
            let request = URLRequest(url: url!)
            webView.loadRequest(request)
            // return
        } else{
            navigationController?.popViewController(animated: true)
        }
    }
}




