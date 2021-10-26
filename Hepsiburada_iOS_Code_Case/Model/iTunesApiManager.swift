//
//  iTunesApiManager.swift
//  Hepsiburada_iOS_Code_Case
//
//  Created by Ege Seçkin on 25.10.2021.
//

import Foundation
import UIKit

class iTunesApiManager: UIViewController{
    
    
    
    
    func performRequest(urlString: String){
        
        //Create URL
        
        if let url = URL(string: urlString){
            //Create URL Session
            let session = URLSession(configuration: .default)
            
            //Give a task to the session
            //Closure
            let task =  session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                }
                if let safeData = data{
                    //self.parseJSON(iTunesData: safeData)
                }
            }
            
            //Start the task
            task.resume()
        }
    }

}
