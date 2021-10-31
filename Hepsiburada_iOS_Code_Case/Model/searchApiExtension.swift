//
//  searchApiExtension.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 31.10.2021.
//

import UIKit
import Alamofire

extension ResultViewController {
    func searchApi()  {
        self.actIN.startAnimating()
        // if user enters text less than 2 characters collectionview won't show anything
        guard let term = searchBar.text , term.count > 2 else {
            self.actIN.stopAnimating()
            cellNumber = 0
            self.collectionView.reloadData()
            return
        }
        
        // Clear the spaces between words
        let newTerm = term.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
        //Make request to api with Alamofire
        AF.request("https://itunes.apple.com/search?term=\(newTerm)&entity=\(category)").responseJSON{(result) in
            if let datadecoded = result.value as? NSDictionary {
                self.actIN.stopAnimating()
                dataresult = datadecoded.value(forKey: "results") as! [NSDictionary]
                cellNumber = 20 // If cell number is incremented in previous searches it resets it back to 20
                self.collectionView.reloadData()
            }
        }
        
    }
}
