//
//  UIImageView+Color.swift
//  FoodyCookBook
//
//  Created by Madhusudhan Reddy Putta on 14/06/21.
//  Copyright © 2021 Madhusudhan Reddy. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
       /**
        To load the image
        
        #1. Check image is avaialble in cache or not.
        A. If not Download the image from URL and save in cache.
        B. If the image is avaible in cache then direct pass the image to imageview.
        
        
        - parameters:
         - urlString: The urlString in the Image URL, cannot be empty
        
    */
       func loadImageUsingCacheUrlString(urlString: String) {
                   
           var urlStr = urlString.replacingOccurrences(of: " ", with: "%20")
           
           urlStr = urlStr.replacingOccurrences(of: "\\", with: "/")
           
           #if DEDEBUG
           print(urlStr)
           #endif
           
           //Check cache for image first
           if let cachedImage = imageCache.object(forKey: urlStr as NSString)
           {
               self.image = cachedImage
               return
           }
           let url = NSURL(string: urlStr)
           if url != nil {
               URLSession.shared.dataTask(with: url! as URL){
                   data,response,error  in
                   
                   if error != nil {
                       DispatchQueue.main.async {
                         self.image = #imageLiteral(resourceName: "user-32")
                       }
                       
                       print("fail to download Image from FB with error: \(String(describing: error?.localizedDescription))")
                       return
                   }
                   
                   DispatchQueue.main.async {
                       
                       if let downloadedImage = UIImage(data: data!)
                       {
                           imageCache.setObject(downloadedImage, forKey: urlStr as NSString)
                           self.image = downloadedImage
                       }
                      }
                   }.resume()
           }
       }
    
}
