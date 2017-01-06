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
    
    var webLink: SongObject?
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidAppear(_ animated: Bool) {
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




