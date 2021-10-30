//
//  ResultViewController.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 25.10.2021.
//

import UIKit
import Alamofire

var dataresult = [NSDictionary]()
var limit = 20 // items to display in each page

class ResultViewController: UIViewController,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var category = "movie"
    
    @IBAction func categories(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            category = "movie";
            limit = 0 // In order to go top of the collectionview in each category we have rest it first
            self.collectionView.reloadData()
            searchApi()
        case 1:
            category = "song";
            limit = 0
            self.collectionView.reloadData()
            searchApi()
        case 2:
            category = "software";
            limit = 0
            self.collectionView.reloadData()
            searchApi()
        case 3:
            category = "audiobook";
            limit = 0
            self.collectionView.reloadData()
            searchApi()
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        searchApi()
    }
    
    func searchApi()  {
        guard let term = searchBar.text , term.count > 2 else { // ıf user enters text less than 2 characters collectionview won't show anything
            limit = 0
            self.collectionView.reloadData()
            return
        }
        AF.request("https://itunes.apple.com/search?term=\(term)&entity=\(category)").responseJSON{(resp) in
            if let datadecoded = resp.value as? NSDictionary {
                dataresult = datadecoded.value(forKey: "results") as! [NSDictionary]
                limit = 20
                self.collectionView.reloadData()
                
            }
        }
        
    }
}

// MARK: Extension for ViewController
extension ResultViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //if input inside searchbar changes (dynamically) it comes here
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchApi()
    }
    
    //How many items should be displayed
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(dataresult.count != 0 ){
            if(dataresult.count < limit){
                return dataresult.count
            }
            else{
                return limit
            }
        }
        return 0
        
    }
    
    //For cells in collectionview
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iTunesCollectionViewCell", for: indexPath) as! iTunesCollectionViewCell
        
        
        let imageUrl = URL(string: dataresult[indexPath.row].value(forKey: "artworkUrl100") as! String)
        let imageData = try! Data(contentsOf: imageUrl!)
        cell.iTunesImage.image = UIImage(data: imageData)
        
        
        cell.nameLabel.text =  "Name: " + (dataresult[indexPath.row].value(forKey: "collectionName") as? String ?? dataresult[indexPath.row].value(forKey: "trackName") as? String ?? "Unknown")
        
        cell.priceLabel.text = "Price: " + (String(dataresult[indexPath.row].value(forKey: "collectionPrice") as? Double ?? dataresult[indexPath.row].value(forKey: "price") as? Double ?? 0)) + "$"
        
        let date = (dataresult[indexPath.row].value(forKey: "releaseDate") as? String)!.components(separatedBy: "T")
        cell.dateLabel.text = "Date: " + date[0]
        return cell
    }
    
    //Pagination
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == limit-1   {
            limit = limit + 20
            collectionView.reloadData()
        }
    }
    
    //Details Page
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        let imageUrl = URL(string: dataresult[indexPath.row].value(forKey: "artworkUrl100") as! String)
        let imageData = try! Data(contentsOf: imageUrl!)
        detail?.DetailImage = UIImage(data: imageData)
        
        detail?.DetailArtistName = ("Artist Name: " + (dataresult[indexPath.row].value(forKey: "artistName") as? String ??  "No Artist Name"))
        detail?.DetailCollectionName = ("Collection Name: " + (dataresult[indexPath.row].value(forKey: "collectionName") as? String ?? dataresult[indexPath.row].value(forKey: "collectionName") as? String ?? "Unknown"))
        detail?.DetailTrackName = ("Track Name: " + (dataresult[indexPath.row].value(forKey: "trackName") as? String ?? "No Track Name"))
        detail?.DetailPrice = ("Price: " + (String(dataresult[indexPath.row].value(forKey: "collectionPrice") as? Double ?? (dataresult[indexPath.row].value(forKey: "price") as? Double ?? 0)) + "$"))
        
        let date = (dataresult[indexPath.row].value(forKey: "releaseDate") as? String)!.components(separatedBy: "T")
        detail?.DetailReleaseDate = ("Release Date: " + date[0])
        
        detail?.DetailDescription = ("Description: " + (dataresult[indexPath.row].value(forKey: "description") as? String ?? "No Description"))
        
        self.navigationController?.pushViewController(detail!, animated: true)
    }
    
}
