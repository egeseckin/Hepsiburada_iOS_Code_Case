//
//  ResultViewController.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 25.10.2021.
//

import UIKit
import Alamofire

var dataresult = [NSDictionary]()
var cellNumber = 20 // items to display in each page

class ResultViewController: UIViewController,UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var actIN: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var category = "movie"
    
    //Segmented Control
    @IBAction func categories(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            category = "movie";
            cellNumber = 0 // In order to go top of the collectionview in each category we have rest it first
            self.collectionView.reloadData()
            searchApi()
        case 1:
            category = "song";
            cellNumber = 0
            self.collectionView.reloadData()
            searchApi()
        case 2:
            category = "software";
            cellNumber = 0
            self.collectionView.reloadData()
            searchApi()
        case 3:
            category = "audiobook";
            cellNumber = 0
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
    
    // MARK: API Request
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

// MARK: Extension for ViewController
extension ResultViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //if input inside searchbar changes (dynamically) it comes here
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchApi()
    }
    
    //How many items should be displayed
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.actIN.stopAnimating()
        if(dataresult.count != 0 ){
            if(dataresult.count < cellNumber){
                return dataresult.count
            }
            else{
                return cellNumber
            }
        }
        return 0
        
    }
    
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
        let date = (dataresult[indexPath.row].value(forKey: "releaseDate") as? String)!.components(separatedBy: "T")
        cell.dateLabel.text = "Date: " + date[0]
        
        
        return cell
    }
    
    //Pagination
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //Increments the number of cells on the page when it comes to end of page
        if indexPath.row == cellNumber-1   {
            self.actIN.startAnimating()
            cellNumber = cellNumber + 20
            collectionView.reloadData()
        }
    }
    
    //Details Page
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        //For image in detail page
        let imageUrl = URL(string: dataresult[indexPath.row].value(forKey: "artworkUrl100") as! String)
        let imageData = try! Data(contentsOf: imageUrl!)
        detail?.DetailImage = UIImage(data: imageData)
        
        //For artist name in detail page
        detail?.DetailArtistName = ("Artist Name: " + (dataresult[indexPath.row].value(forKey: "artistName") as? String ??  "No Artist Name"))
        
        //For collection name in detail page
        detail?.DetailCollectionName = ("Collection Name: " + (dataresult[indexPath.row].value(forKey: "collectionName") as? String ?? dataresult[indexPath.row].value(forKey: "collectionName") as? String ?? "Unknown"))
        
        //For Track name in detail page
        detail?.DetailTrackName = ("Track Name: " + (dataresult[indexPath.row].value(forKey: "trackName") as? String ?? "No Track Name"))
        
        //For price in detail page
        detail?.DetailPrice = ("Price: " + (String(dataresult[indexPath.row].value(forKey: "collectionPrice") as? Double ?? (dataresult[indexPath.row].value(forKey: "price") as? Double ?? 0)) + "$"))
        
        //For date in detail page
        let date = (dataresult[indexPath.row].value(forKey: "releaseDate") as? String)!.components(separatedBy: "T")
        detail?.DetailReleaseDate = ("Release Date: " + date[0])
        
        //For description in detail page
        detail?.DetailDescription = ("Description: " + (dataresult[indexPath.row].value(forKey: "description") as? String ?? "No Description"))
        
        self.navigationController?.pushViewController(detail!, animated: true)
    }
    
}
