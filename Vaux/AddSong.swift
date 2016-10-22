//
//  AddSong.swift
//  beatkeep
//
//  Created by Marquavious on 8/25/16.
//  Copyright © 2016 marqmakesapps. All rights reserved.
//

import UIKit
import RealmSwift

class AddSong: UIViewController, UITextFieldDelegate {

    var song: SongObject?
    
    @IBOutlet weak var addSongTextField: UITextField!
    @IBOutlet weak var addArtistTextField: UITextField!
    @IBOutlet weak var addLinkTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    @IBAction func addSongActionHandler(_ sender: AnyObject) {
        
        if (addSongTextField.text != "") && (addSongTextField.text != " ") && (addSongTextField.text != "   ") && (addSongTextField.text != "    ") {
            
            let urlForCheckSavingMode = addLinkTextField.text
        
            if ((urlForCheckSavingMode!.containsIgnoringCase(" ")) || (urlForCheckSavingMode!.containsIgnoringCase("  ")) || (urlForCheckSavingMode!.containsIgnoringCase("   ")) == true ){
                displayAlert("ERROR", message: "Invalid Link")
                return
                
            } else {
                
                if let song = song {
                    let newSong = SongObject()
                    newSong.songTitle = addSongTextField.text ?? ""
                    newSong.songArtist = addArtistTextField.text ?? ""
                    newSong.songLink = addLinkTextField.text ?? ""
                    RealmHelper.updateSong(song, newSong: newSong)
                    
                } else {
                    let song = SongObject()
                    song.songTitle = addSongTextField.text ?? ""
                    song.songArtist = addArtistTextField.text ?? ""
                    song.songLink = addLinkTextField.text ?? ""
                    RealmHelper.addSong(song)
                    
                }
                performSegue(withIdentifier: "afterAddSegue", sender: self)
            }
            
        } else {
            displayAlert("ERROR", message: "Song must have a title")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}



