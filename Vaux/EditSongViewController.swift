//
//  EditSongViewController.swift
//  beatkeep
//
//  Created by Marquavious on 8/29/16.
//  Copyright © 2016 marqmakesapps. All rights reserved.
//

import UIKit
import RealmSwift

class EditSongViewController: UIViewController,  UITextFieldDelegate {
    
    var  inheritedSong: SongObject?
    
    let realm = try! Realm()
    
    @IBOutlet weak var editedSong: UITextField!
    
    @IBOutlet weak var editedArtist: UITextField!
    
    @IBOutlet weak var editedLink: UITextField!
    
    @IBOutlet weak var editLinkSwitch: UISwitch!
    
    @IBAction func editLinkSwitchOption(_ sender: AnyObject) {
        
        if editLinkSwitch.isOn {
            
            print("Switch is on")
            editedLink.isUserInteractionEnabled = true
            editedLink.textColor = UIColor.rgb(225, green: 74, blue: 74)
        } else {
            print("Switch is off")
            editedLink.isUserInteractionEnabled = false
            editedLink.textColor = UIColor(red: 225, green: 225, blue: 225, alpha: 0.19)
            
        }
    }
    
    @IBAction func saveChanges(_ sender: AnyObject) {
        
        if (editedSong.text != "") && (editedSong.text != " ") && (editedSong.text != "   ") && (editedSong.text != "    ") {
            let urlForCheckSavingMode = editedLink.text
            if ((urlForCheckSavingMode!.containsIgnoringCase(" ")) || (urlForCheckSavingMode!.containsIgnoringCase("  ")) || (urlForCheckSavingMode!.containsIgnoringCase("   ")) == true ){
                displayAlert("ERROR", message: "Invalid Link")
                return
            } else {
                if let song = inheritedSong {
                    try! realm.write {
                        song.songTitle = editedSong.text ?? ""
                        song.songArtist = editedArtist.text ?? ""
//                        song.songLink = editedLink.text ?? ""
            }
            }; performSegue(withIdentifier: "returnToSongsSegue", sender: self)
            }
            } else {
            displayAlert("ERROR", message: "Song must have a title")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editedSong.text = inheritedSong?.songTitle ?? ""
        editedArtist.text = inheritedSong?.songArtist ?? ""
//        editedLink.text = inheritedSong?.songLink ?? ""
//        editLinkSwitch.setOn(false, animated: false)
        editedLink.isUserInteractionEnabled = false
        editedLink.textColor = UIColor(red: 225, green: 225, blue: 225, alpha: 0.19)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
