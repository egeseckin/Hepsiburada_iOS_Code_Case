//
//  ViewController.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 24.10.2021.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var category = "movie"
    @IBAction func categories(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex
            {
            case 0:
            category = "movie";
            case 1:
            category = "song";
            case 2:
            category = "software";
            case 3:
            category = "audiobook"
            default:
                break;
            }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    var iTunesURLManager = ResultViewController()
    
    
    //MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
    }
    
    //Triggered when user enters the words and press search from the keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.endEditing(true)
        if(searchBar.text!.count > 2 ){//User can only search if more than 2 characters are entered.
            print(searchBar.text!)
            if let term = searchBar.text {
                print(category)
                iTunesURLManager.fetchTerm(term: term, entity: category)
            }
            performSegue(withIdentifier: "ResultViewSegue", sender: self)
            searchBar.text = ""
            searchBar.placeholder = "Search"
            
        }
        else{ //If user enters less than 2 characters to searchbar it will promprt error
            print("Error")
            searchBar.text = ""
            searchBar.placeholder = "Please provide more than 2 characters"
        }
    }
    
}

 
