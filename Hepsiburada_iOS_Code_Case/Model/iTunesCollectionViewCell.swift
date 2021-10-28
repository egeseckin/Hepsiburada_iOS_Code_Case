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
    
    
    
    func setup(with items: [iTunesApiData] ){

        let imageUrl = URL(string: items[0].results[count].artworkUrl100)!
        let imageData = try! Data(contentsOf: imageUrl)
        self.iTunesImage.image = UIImage(data: imageData)
                    
        self.nameLabel.text = "Name: " + items[0].results[count].collectionName
        self.priceLabel.text = "Price: " + String(items[0].results[count].collectionPrice) + "$"
                    
        let date = items[0].results[count].releaseDate.components(separatedBy: "T")
        self.dateLabel.text = "Date: " + date[0]
            
        count += 1
        
    }
}




