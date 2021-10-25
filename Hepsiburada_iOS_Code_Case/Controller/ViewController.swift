//
//  ViewController.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 24.10.2021.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    //MARK: - SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
    }
    
    //Triggered when user enters the words and press search from the keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        searchBar.endEditing(true)
        if(searchBar.text!.count > 2){//User can only search if more than 2 characters are entered.
            print(searchBar.text!)
            searchBar.text = ""
            searchBar.placeholder = "Search"
            
        }
        else{ //If user enters less than 2 characters to searchbar it will promprt error
            print("Error")
            searchBar.text = ""
            searchBar.placeholder = "ERROR"
        }
    }
}

 
