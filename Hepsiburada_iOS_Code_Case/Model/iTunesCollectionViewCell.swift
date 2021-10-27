//
//  iTunesCollectionViewCell.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 25.10.2021.
//

import UIKit

var count = 0
class iTunesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iTunesImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    func setup(with items: iTunesApiData ){

            let imageUrl = URL(string: items.results[count].artworkUrl100)!
            let imageData = try! Data(contentsOf: imageUrl)
            self.iTunesImage.image = UIImage(data: imageData)
            
            self.nameLabel.text = "Name: " + items.results[count].collectionName
            self.priceLabel.text = "Price: " + String(items.results[count].collectionPrice) + "$"
            
            let date = items.results[count].releaseDate.components(separatedBy: "T")
            self.dateLabel.text = "Date: " + date[0]
            
            count += 1
        
    }
}




