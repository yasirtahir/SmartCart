//
//  BaseViewController.swift
//  SmartCart
//
//  Created by Yasir Tahir Ali on 21/11/2020.
//

import UIKit
import TTGSnackbar

class BaseViewController: UIViewController {
    
    let snackbar = TTGSnackbar.init()
    let webservice = WebServiceManager.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayResponse(message: String){
        DispatchQueue.main.async {
            self.snackbar.duration = .long
            self.snackbar.message = message
            self.snackbar.show()
        }
    }
}
