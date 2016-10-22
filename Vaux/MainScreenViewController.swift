//
//  ViewController.swift
//  beatkeep
//
//  Created by Marquavious on 8/22/16.
//  Copyright © 2016 marqmakesapps. All rights reserved.
//

import UIKit
import RealmSwift

class MainScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var filteredSongs = [SongObject]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var songs: Results<SongObject>! {
        didSet {
            tableView.reloadData()
        }
    }
    
//    func filterContentForSearchText(searchText: String, scope: String = "All") {
//        filteredSongs = songs.filter { songs in
//            return songs.songTitle!.lowercaseString.containsString(searchText.lowercaseString)
//        }
//        filteredSongs = songs.filter { songs in
//            return songs.songArtist!.lowercaseString.containsString(searchText.lowercaseString)
//        }
//        
//        tableView.reloadData()
//    }
    
    @IBOutlet weak var titleArtsitsSegmentController: UISegmentedControl!
    
    @IBAction func selectedSegmentChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            songs = RealmHelper.retrieveSongs()
        case 1:
            songs = RealmHelper.retrieveSongsByArtist()
        default:
            songs = RealmHelper.retrieveSongs()
            break;
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        songs = RealmHelper.retrieveSongs()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        UISearchBar.appearance().barTintColor = UIColor.rgb(225, green: 74, blue: 74)
        UISearchBar.appearance().tintColor =  UIColor.white
        tableView.backgroundView = UIView()
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.rgb(225, green: 74, blue: 74)

        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongsTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.default
        let row = indexPath.row
        var song = songs[row]
        cell.artistName.text = song.songArtist ?? "UNKOWN"
        if searchController.isActive && searchController.searchBar.text != "" {
            song = filteredSongs[indexPath.row]
            
        } else {
            
        }
        
        cell.songTitle.text = song.songTitle ?? "\(song.songTitle)"
        
        if cell.artistName.text == "" || cell.artistName.text == " " || cell.artistName.text == "  " || cell.artistName.text == "  " {
            
            cell.artistName.text = "UNKOWN"
            
        } else {
            
            cell.artistName.text = song.songArtist ?? "UNKOWN"
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredSongs.count
        }
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        RealmHelper.deleteSong(songs[indexPath.row])
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSongSegue" {
            let cell = sender as! SongsTableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let song = songs[indexPath.row]
            let destination = segue.destination as! EditSongViewController
            destination.inheritedSong = song
            
        } else if segue.identifier == "showWebPage" {
            let cell = sender as! SongsTableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            //            let song = songs[indexPath.row]
            let song: SongObject
            if searchController.isActive && searchController.searchBar.text != "" {
                song = filteredSongs[indexPath.row]
            } else {
                song = songs[indexPath.row]
            }
            let destination = segue.destination as! WebCellDisplay
            destination.webLink = song
        }
    }
}

