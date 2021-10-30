//
//  iTunesApiManager.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 25.10.2021.
//


import UIKit
import Alamofire


class iTunesApiManager: UIViewController{
    
    
    func apiRequest(term: String, category: String) -> [NSDictionary]{
        AF.request("https://itunes.apple.com/search?term=\(term)&entity=\(category)").responseJSON{(result) in
            if let datadecoded = result.value as? NSDictionary {
                dataresult = datadecoded.value(forKey: "results") as! [NSDictionary]
            }
        }
        return dataresult
    }
}

