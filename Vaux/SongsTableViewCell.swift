//
//  SongsTableViewCell.swift
//  beatkeep
//
//  Created by Marquavious on 8/25/16.
//  Copyright © 2016 marqmakesapps. All rights reserved.
//

import UIKit

protocol SongsTableViewCellDelegate {
    func didTapEditButtonForSongsTableViewCell(_ cell: SongsTableViewCell)
}

class SongsTableViewCell: UITableViewCell {

    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var addMoreButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var editCoverButton: UIButton!
    @IBOutlet weak var dateAdded: UILabel!
    @IBOutlet weak var addMoreCoverButton: UIButton!
    
    var delegate: SongsTableViewCellDelegate?
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        delegate?.didTapEditButtonForSongsTableViewCell(self)
    }
}
