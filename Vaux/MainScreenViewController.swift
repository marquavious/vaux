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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleArtsitsSegmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var filteredSongs = [SongObject]()
    let searchController = UISearchController(searchResultsController: nil)
    
    var songs: Results<SongObject>! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songs = RealmHelper.retrieveSongs()
        setUpSearchBarAndTableview()
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.rgb(225, green: 74, blue: 74)
    }
    
    func setUpSearchBarAndTableview(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        tableView.backgroundView = UIView()
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        UISearchBar.appearance().barTintColor = UIColor.rgb(225, green: 74, blue: 74)
        UISearchBar.appearance().tintColor =  UIColor.white
        tableView.reloadData()
    }
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongsTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.default
        let row = indexPath.row
        var song = songs[row]
        cell.artistName.text = song.songArtist ?? "UNKOWN"
        if searchController.isActive && searchController.searchBar.text != "" {
            song = filteredSongs[indexPath.row]
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
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredSongs = songs.filter ({( songs: SongObject) -> Bool in
            return songs.songTitle!.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
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
            let song: SongObject
            if searchController.isActive && searchController.searchBar.text != "" {
                song = filteredSongs[indexPath.row]
            } else {
                song = songs[indexPath.row]
            }
            let destination = segue.destination as! WebCellDisplay
            destination.songObject = song
        }
    }
}

