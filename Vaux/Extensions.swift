//
//  Extensions.swift
//  beatkeep
//
//  Created by Marquavious on 9/12/16.
//  Copyright © 2016 marqmakesapps. All rights reserved.
//

import UIKit

extension EditSongViewController {
    
    func displayAlert(_ title: String, message: String){
        
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension AddSong {
    
    func displayAlert(_ title: String, message: String){
        
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}


extension MainScreenViewController: SongsTableViewCellDelegate {
    func didTapEditButtonForSongsTableViewCell(_ cell: SongsTableViewCell) {
        performSegue(withIdentifier: "editSongSegue", sender: cell)
    }
}

extension UIColor {
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension MainScreenViewController: UISearchResultsUpdating {
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        func updateSearchResults(for searchController: UISearchController) {
//            filterContentForSearchText(searchText: searchController.searchBar.text!)
        }
        
    }

}

extension String {
    func contains(_ find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(_ find: String) -> Bool{
        return self.range(of: find, options: NSString.CompareOptions.caseInsensitive) != nil
    }
    
    func replace(_ target: String, withString: String) -> String{
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
