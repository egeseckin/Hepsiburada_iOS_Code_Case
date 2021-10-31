//
//  ResultViewController.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 25.10.2021.
//

import UIKit

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
        cellNumber = 0 // In order to go top of the collectionview in each category we have to reset it first
        self.collectionView.reloadData()
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            category = "movie";
        case 1:
            category = "song";
        case 2:
            category = "software";
        case 3:
            category = "audiobook";
        default:
            break;
        }
        searchApi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchApi()
    }
    
    
}


