//
//  NetworkRequestViewModel.swift
//  Contacts
//
//  Created by Ravindra Patidar on 14/09/19.
//  Copyright © 2019 GoJek. All rights reserved.
//

import Foundation

class NetworkRequestViewModel {
    
    static var sharedInstance = NetworkRequestViewModel()
    
    func getContacts(urlStr:String, method: String, completion: @escaping ([Contact])->Void, failiure: @escaping (Error)->Void) {
        
        APIManager.sharedInstance.getRequest(urlStr: urlStr, method: "GET", completion:completion, failiure: failiure)
    }
}
