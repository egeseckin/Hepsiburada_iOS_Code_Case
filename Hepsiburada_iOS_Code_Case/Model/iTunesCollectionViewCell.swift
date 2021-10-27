//
//  iTunesCollectionViewCell.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 25.10.2021.
//

import UIKit


class iTunesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iTunesImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var count = 0
    func setup(with items: iTunesApiData ){
        DispatchQueue.main.async {
            let imageUrl = URL(string: items.results[self.count].artworkUrl100)!
            let imageData = try! Data(contentsOf: imageUrl)
            self.iTunesImage.image = UIImage(data: imageData)
            
            self.nameLabel.text = "Name:" + items.results[self.count].collectionName
            self.priceLabel.text = "Price:" + String(items.results[self.count].collectionPrice)
            self.dateLabel.text = "Release Date:" + items.results[self.count].releaseDate
            self.count += 1
        }
    }
}




