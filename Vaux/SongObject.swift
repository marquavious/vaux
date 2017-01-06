//
//  SongObject.swift
//  beatkeep
//
//  Created by Marquavious on 8/24/16.
//  Copyright © 2016 marqmakesapps. All rights reserved.
//

import Foundation
import RealmSwift

class SongObject: Object {
    dynamic var songTitle: String?
    dynamic var songArtist: String?
    dynamic var songDateUplaod : Date?
}
