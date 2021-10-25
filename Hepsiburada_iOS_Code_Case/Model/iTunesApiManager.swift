//
//  iTunesApiManager.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 25.10.2021.
//

import Foundation

struct iTunesApiManager{
    
    let iTunesURL = "https://itunes.apple.com/search?"
    
    func fetchTerm(term: String, entity: String ){
        let urlString = "\(iTunesURL)term=\(term)&entity=\(entity)"
    }
}
