//
//  iTunesApiData.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 25.10.2021.
//

import Foundation

struct iTunesApiData: Decodable{
    let resultCount: Int
    let results: [Results]
    
   
}

struct Results: Decodable{
    let collectionPrice: Double?
    let collectionName: String
    let artworkUrl100: String?
    let releaseDate: String?
    
}
