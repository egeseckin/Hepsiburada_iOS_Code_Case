//
//  ViewController.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 24.10.2021.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    
    @IBOutlet weak var searchTextField: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }

    // Search Button actions
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true) //used to disappear keyboard after user finishes typing
        print(searchTextField.text)
    }
    
    //Triggered when user enters the words and press search from the keyboard
    func textFieldReturn(_ textField: UITextField) -> Bool {
    
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldFinished(_ textField: UITextField){
        
        searchTextField.text = ""
        
    }
}

 
