//
//  DetailViewController.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 29.10.2021.
//

import UIKit



class DetailViewController: UIViewController {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailArtistName: UILabel!
    @IBOutlet weak var detailCollectionName: UILabel!
    @IBOutlet weak var detailTrackName: UILabel!
    @IBOutlet weak var detailPrice: UILabel!
    @IBOutlet weak var detailReleaseDate: UILabel!
    @IBOutlet weak var detailgenre: UILabel!
    @IBOutlet weak var detailCollectionId: UILabel!
    
    var DetailImage = UIImageView().image
    var DetailArtistName = ""
    var DetailCollectionName = ""
    var DetailTrackName = ""
    var DetailPrice = ""
    var DetailReleaseDate = ""
    var DetailCollectionId = ""
    var DetailGenre = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImage.image = DetailImage
        detailArtistName.text = DetailArtistName
        detailCollectionId.text = DetailCollectionId
        detailCollectionName.text = DetailCollectionName
        detailTrackName.text = DetailTrackName
        detailPrice.text = DetailPrice
        detailReleaseDate.text = DetailReleaseDate
        detailgenre.text = DetailGenre
        
        
        detailImage.layer.cornerRadius = 8
        
    }

}
