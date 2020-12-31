//
//  HomeViewController.swift
//  SmartCart
//
//  Created by Yasir Tahir Ali on 21/11/2020.
//

import UIKit
import SwiftyJSON
import ScanKitFrameWork
import AlamofireImage
import Lottie

class HomeViewController: BaseViewController {

    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var homeTableView: UITableView!
    
    var addedItems: [ItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.initViews()
    }
    
    @IBAction func OnScanButtonClicked(_ sender: UIButton) {
        showDefaultScannerView()
    }
    
    func initViews(){
        setDefaultAnimation()
        
        // Remove Extra lines of UITableView
        self.homeTableView.tableFooterView = UIView(frame: .zero)
        self.homeTableView.contentInset.bottom = 100
        self.homeTableView.rowHeight = UITableView.automaticDimension
    }
}

// This extension is responsible for Huawei Scan Kit (Default View)
extension HomeViewController: DefaultScanDelegate {
    func showDefaultScannerView(){
        let options = HmsScanOptions.init(scanFormatType: UInt32(HMSScanFormatTypeCode.ALL.rawValue), photo: true) // Init Options
        
        let hmsDefaultScanViewController = HmsDefaultScanViewController.init(defaultScanWithFormatType: options) // Take instance of Default Scan View Controller
        hmsDefaultScanViewController?.defaultScanDelegate = self // Setting the delegate to this ViewController
        
        // Make sure it is not nil
        if(hmsDefaultScanViewController != nil){
            self.view.addSubview(hmsDefaultScanViewController!.view)
            self.addChild(hmsDefaultScanViewController!)
            self.didMove(toParent: hmsDefaultScanViewController!)
            self.navigationController?.setNavigationBarHidden(true, animated: false) // If Navigation Controller is not nil, hiding the navigation bar
        }
    }
    
    func defaultScanDelegate(forDicResult resultDic: [AnyHashable : Any]!) {
        self.processResult(results: resultDic ?? [:])
    }
    
    func defaultScanImagePickerDelegate(for image: UIImage!) {
        let resultDic = HmsBitMap.bitMap(for: image, with: HmsScanOptions.init(scanFormatType: UInt32(HMSScanFormatTypeCode.ALL.rawValue), photo: true))
        self.processResult(results: resultDic ?? [:])
    }
    
    func processResult(results: [AnyHashable : Any]?) {
        if(results == nil || results!.isEmpty){
            displayResponse(message: "Unable to get the Barcode value")
            return // No need to run the remaining code
        }
        
        let result = results!["text"] as? String
        
        if(result != nil){
            callAPI(barCodeValue: result!)
        } else {
            displayResponse(message: "Unable to get the Barcode value")
        }
    }
}

// This extension is responsible for API call and to fetch results
extension HomeViewController {
    func callAPI(barCodeValue: String){
        self.showLoading()
        webservice.getBarCodeDetails(barCodeValue: barCodeValue) { (success, message, value)  in
            if(success){
                
                let json = try! JSON(data: value as! Data) // Converting Data to JSON
                
                // Parsing JSON to Custom Item Model class
                for i in 0..<json["products"].count {
                    
                    var title = json["products"][i]["title"].stringValue
                    
                    if(title.isEmpty){
                        title = json["products"][i]["product_name"].stringValue
                    }
                    
                    if(title.isEmpty){
                        title = "Name not available"
                    }
                    
                    let item = ItemModel.init(title: title, category: json["products"][i]["category"].stringValue, manufacturer: json["products"][i]["manufacturer"].stringValue, imageURL: json["products"][i]["images"][0].string!, availability: "")
                    
                    var stores: String = ""
                    
                    for j in 0..<json["products"][i]["stores"].count {
                        
                        if(j > 0){
                            break // If incase, the stores are more then 5, we have to break and display only 5 store information
                        }
                        
                        
                        if(!stores.isEmpty){
                            stores = stores + "\n"
                        }
                        
                        stores = stores + json["products"][i]["stores"][j]["store_name"].stringValue + " | " + json["products"][i]["stores"][j]["currency_symbol"].stringValue + json["products"][i]["stores"][j]["store_price"].stringValue
                    }
                    
                    if(stores.isEmpty){
                        stores = "Out of Stock"
                    }
                    
                    item.setAvailability(value: stores)
                    
                    self.addedItems.append(item) // Adding Item to our list
                }
                // Putting a delay here to make sure the loader is has been shown for adequete time
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.homeTableView.reloadData() // Notify UITableView to reload as data is changed
                    self.showResults()
                }
            } else {
                
                self.setDefaultAnimation()
                var displayMsg : String = ""
                if(message.elementsEqual("UnableToProcessRequest")){
                    displayMsg = "Unable to find any item for this barcode \(barCodeValue)"
                } else if(message.elementsEqual("NoInternetConnection")) {
                    displayMsg = "Please check if you're connected to Internet and Try Again!"
                }
                self.displayResponse(message: displayMsg)
            }
        }
    }
}

// This extension is responsible to display API result in the UITableView
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell

        let item = self.addedItems[indexPath.row]
        
        cell.lblTitle.text = item.getTitle()
        cell.lblCategory.text = item.getCategory()
        cell.lblManufacturer.text = item.getManufacturer()
        cell.lblAvailability.text = item.getAvailability()
        
        let placeholderImage = UIImage(named: "placeholder")!
        
        if(!item.getImageURL().isEmpty){
            let url = URL(string: item.getImageURL())!
            cell.imgItem.af.setImage(withURL: url, placeholderImage: placeholderImage) // Download and set Image. If failed, set placeholder
        } else {
            cell.imgItem.image = placeholderImage
        }

        return cell
    }
}

// This extension is responsible to manage all the lottie animation methods
extension HomeViewController {
    
    func setDefaultAnimation(){
        if(self.addedItems.count > 0){
            showResults()
        } else {
            noItemFound()
        }
    }
    
    func noItemFound(){
        DispatchQueue.main.async {
            self.homeTableView.isHidden = true
            self.animationView.isHidden = false
            self.animationView.animation = Animation.named("empty_view")
            self.animationView.contentMode = .scaleAspectFit
            self.animationView.loopMode = .loop
            self.animationView.animationSpeed = 1.5
            self.animationView.play()
        }
    }
    
    func showLoading(){
        DispatchQueue.main.async {
            self.homeTableView.isHidden = true
            self.animationView.isHidden = false
            self.animationView.animation = Animation.named("not_found")
            self.animationView.contentMode = .scaleAspectFit
            self.animationView.loopMode = .loop
            self.animationView.animationSpeed = 1.5
            self.animationView.play()
        }
    }
    
    func showResults(){
        DispatchQueue.main.async {
            self.homeTableView.isHidden = false
            self.animationView.isHidden = true
        }
    }
    
}
