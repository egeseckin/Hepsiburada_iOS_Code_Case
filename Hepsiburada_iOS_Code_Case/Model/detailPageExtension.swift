//
//  detailPageExtension.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 31.10.2021.
//

import UIKit

extension ResultViewController{
    
    // MARK: Detail Page
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        //For image in detail page
        let imageUrl = URL(string: dataresult[indexPath.row].value(forKey: "artworkUrl100") as! String)
        let imageData = try! Data(contentsOf: imageUrl!)
        detail.DetailImage = UIImage(data: imageData)
        
        //For artist name in detail page
        detail.DetailArtistName = ("Artist Name: " + (dataresult[indexPath.row].value(forKey: "artistName") as? String ??  "No Artist Name"))
        
        //For collection id in detail page
        detail.DetailCollectionId = ("Collection ID: " + (String(dataresult[indexPath.row].value(forKey: "collectionId") as? Int ?? 0)))
        
        //For collection name in detail page
        detail.DetailCollectionName = ("Collection Name: " + (dataresult[indexPath.row].value(forKey: "collectionName") as? String ?? dataresult[indexPath.row].value(forKey: "collectionName") as? String ?? "Unknown"))
        
        //For Track name in detail page
        detail.DetailTrackName = ("Track Name: " + (dataresult[indexPath.row].value(forKey: "trackName") as? String ?? "No Track Name"))
        
        //For price in detail page
        detail.DetailPrice = ("Price: " + (String(dataresult[indexPath.row].value(forKey: "collectionPrice") as? Double ?? (dataresult[indexPath.row].value(forKey: "price") as? Double ?? 0)) + "$"))
        
        //For date in detail page
        let isoDate = (dataresult[indexPath.row].value(forKey: "releaseDate") as? String)!
        
        let dateFormatter = ISO8601DateFormatter()
        let datevalue = dateFormatter.date(from:isoDate)!
        let dateformat = DateFormatter()
        dateformat.dateStyle = .short
        dateformat.dateFormat = "d/MMM/y"
        let date = dateformat.string(from: datevalue)
        detail.DetailReleaseDate = ("Release Date: " + date)
        
        //For genre in detail page
        detail.DetailGenre = ("Genre: " + (dataresult[indexPath.row].value(forKey: "primaryGenreName") as? String ?? "No Genre"))
        
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
