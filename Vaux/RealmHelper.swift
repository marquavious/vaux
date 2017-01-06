//
//  RealmHelper.swift
//  beatkeep
//
//  Created by Marquavious on 8/26/16.
//  Copyright © 2016 marqmakesapps. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    static func retrieveSongs() -> Results<SongObject> {
        let realm = try! Realm()
        return realm.objects(SongObject.self).sorted(byProperty: "songTitle", ascending: true)
    }
    
    static func retrieveSongsByArtist() -> Results<SongObject> {
        let realm = try! Realm()
        return realm.objects(SongObject.self).sorted(byProperty: "songArtist", ascending: true)
    }
    
    static func addSong(_ songObject: SongObject) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(songObject)
        }
    }
    
    static func deleteSong(_ songObject: SongObject) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(songObject)
        }
    }
    
    static func updateSong(_ songToBeUpdated: SongObject, newSong: SongObject) {
        let realm = try! Realm()
        try! realm.write() {
            songToBeUpdated.songTitle = newSong.songTitle
            songToBeUpdated.songArtist = newSong.songArtist
            songToBeUpdated.songDateUplaod = newSong.songDateUplaod
        }
    }
}
