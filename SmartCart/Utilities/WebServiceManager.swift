//
//  WebServiceManager.swift
//  SmartCart
//
//  Created by Yasir Tahir Ali on 21/11/2020.
//

import Foundation
import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}

class WebServiceManager: NSObject {
    
    static let instance = WebServiceManager()
    
    func getBarCodeDetails(barCodeValue: String, completion: @escaping (_ success: Bool, _ message: String, _ value: Any) -> Void) -> Void {
        if Connectivity.isConnectedToInternet {
            let api_key: String = "vgb3flwvrhyla2cwi60f4b1h2kcapw" // "zvjihfd8hnbk3tsus8ajcbfnrec0kc"
            let fullURL: String = "https://api.barcodelookup.com/v2/products?barcode=\(barCodeValue)&key=\(api_key)"
            
            AF.request(fullURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).debugLog().responseJSON { response in
                if(response.value != nil){
                    completion(true, "success", response.data!)
                } else {
                    completion(false, "UnableToProcessRequest", "")
                }
            }
        } else {
            completion(false, "NoInternetConnection", "")
        }
    }
}



