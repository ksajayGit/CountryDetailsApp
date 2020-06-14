//
//  UIImageView+Extension.swift
//  CountryDetailsApp
//
//  Created by MyHome on 15/06/20.
//  Copyright © 2020 MyHome. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageFromCache(url: String) {
        guard let imageUrl = URL(string: url) else {
            image = nil
            return
        }
        
        if let cachedImage = imageCache.object(forKey: url as NSString) as? UIImage {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            guard let data = data,
                let image = UIImage(data: data),
                error == nil else{
                    DispatchQueue.main.async {
                        self.image = UIImage(named: "No_Image_Found")
                    }
                    return
            }
            
            DispatchQueue.main.async {
                imageCache.setObject(image, forKey: url as NSString)
                self.image = image
            }
        }.resume()
    }
}
