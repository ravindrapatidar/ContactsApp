//
//  APIManager.swift
//  Contacts
//
//  Created by Ravindra Patidar on 14/09/19.
//  Copyright © 2019 GoJek. All rights reserved.
//

import Foundation

class APIManager {
    
    static var sharedInstance = APIManager()
    
    func getRequest<T:Decodable>(urlStr:String, method: String, completion: @escaping ([T])->Void, failiure: @escaping (Error)->Void) {
        
        guard let url = URL.init(string: urlStr) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let responseData = data, error == nil else {
                    return
            }
            
            let decoder = JSONDecoder.init()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                
                let responseData =  try decoder.decode([T].self, from: responseData)
                
                completion(responseData)
                
            } catch let error {
                failiure(error)
            }
        }
        task.resume()
    }
}
