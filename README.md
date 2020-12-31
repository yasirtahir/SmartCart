![Smart Shopping Cart using Scan Kit (Native iOS Swift)](https://github.com/yasirtahir/SmartCart/raw/main/images/1.jpg)

 

## Introduction


In this demo, we will show how to integrate Huawei Scan Kit in iOS using native language (swift) and barcode lookup APIs to search and add items with information in your list. The use case has been created to make Smart Shopping Cart with HMS open capabilities.

  
## Pre-Requisites

  
Before getting started, following are the requirements:

1.  Xcode (During this tutorial, we used latest version 12.3)  
    
2.  iOS 9.0 or later (Scan Kit supports iOS 9.0 and above)
    
3.  Apple Developer Account
    
4.  iOS device for testing


  ## Development

1. Add **pod 'ScanKitFrameWork', '~> 1.0.2.300'** # Huawei Scan Kit dependency in the PodFile.
2. Add Camera and Photo permissions in the **info.plist**.  
3. We used **Lottie** animations in our sample to enhance look and feel.
4. Write necessary code for **Default View Scan Kit** and call the function.
5. Once you get the barcode number, call the API to get information about the product such as name, category, brand, price and available at store.
6. Based on the API results, display the items in **UITableView**.


Whenever user visit any store, they can use this app to scan the barcodes of all the items before putting them physically in the cart. Once they are done with shopping, they can process the checkout using different Mobile Payment gateways to offer Smart Cart checkout solution.

  

  

## Run the Application

  

Download this repo code. Build the project, run the application and test on any iOS phone. In this demo, we used iPhone 11 Pro Max for testing purposes.

Using Scan Kit, developers can develop different iOS applications with search option to improve the UI/UX. Scan Kit is a on-device open capability offered by Huawei which can be combined with other functionalities to offer innovative services to the end users.

  

![Demo](https://github.com/yasirtahir/SmartCart/raw/main/images/5.gif "Demo")

  

## Point to Ponder

1.  Before calling the Scan Kit, make sure the required permissions of Camera Usage Description and Photo Library Usage Description are mentioned in the info.plist.
    
2.  **ERROR_NO_CAMERA_PERMISSION**  (value 1) means the app does not have the camera permission.
    
3.  **ERROR_NO_READ_PERMISSION**  (value 2) means the app does not have the read permission on the file directory.
    
4.  Always use animation libraries like  **Lottie**  to enhance UI/UX in your application.
    

  

  

## References

### Huawei Scan Kit Official Documentation:  

[https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/ios-version-change-history-0000001050414335](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/ios-version-change-history-0000001050414335)

### Huawei Scan Kit FAQs:

[https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/faq-0000001050747017](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/faq-0000001050747017)

### Lottie iOS Documentation:  
[http://airbnb.io/lottie/#/ios](http://airbnb.io/lottie/#/ios)
