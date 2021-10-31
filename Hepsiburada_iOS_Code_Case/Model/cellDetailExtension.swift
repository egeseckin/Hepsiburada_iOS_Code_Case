//
//  collectionViewCellDetails.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 31.10.2021.
//

import UIKit

extension ResultViewController{

    // MARK: Cell Properties
    //For giving attribute to cells in collectionview
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iTunesCollectionViewCell", for: indexPath) as! iTunesCollectionViewCell
        //For image in results cell
        let imageUrl = URL(string: dataresult[indexPath.row].value(forKey: "artworkUrl100") as! String)
        let imageData = try! Data(contentsOf: imageUrl!)
        cell.iTunesImage.image = UIImage(data: imageData)
        
        //For name in results cell
        cell.nameLabel.text =  "Name: " + (dataresult[indexPath.row].value(forKey: "collectionName") as? String ?? dataresult[indexPath.row].value(forKey: "trackName") as? String ?? "Unknown")
        
        //For price in results cell
        cell.priceLabel.text = "Price: " + (String(dataresult[indexPath.row].value(forKey: "collectionPrice") as? Double ?? dataresult[indexPath.row].value(forKey: "price") as? Double ?? 0)) + "$"
        //For date in results cell
        //let date = (dataresult[indexPath.row].value(forKey: "releaseDate") as? String)!.components(separatedBy: "T")
        
        let isoDate = (dataresult[indexPath.row].value(forKey: "releaseDate") as? String)!
        
        let dateFormatter = ISO8601DateFormatter()
        let datevalue = dateFormatter.date(from:isoDate)!
        let dateformat = DateFormatter()
        dateformat.dateStyle = .short
        dateformat.dateFormat = "d/MMM/y"
        let date = dateformat.string(from: datevalue)
        
        
        cell.dateLabel.text = "Date: " + date
        
        cell.layer.cornerRadius = 8
        cell.layer.shadowOpacity = 0.2
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        
        return cell
    }

}
