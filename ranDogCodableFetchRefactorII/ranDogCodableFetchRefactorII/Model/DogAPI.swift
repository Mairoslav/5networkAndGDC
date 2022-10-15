//
//  DogAPI.swift
//  ranDog
//
//  Created by mairo on 29/09/2022.
//

import Foundation
import UIKit

class DogAPI {
    
    enum Endpoint: String {
        
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
        
    }
        
    class func requestImageFile(imageUrl: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        
        let taskTwo = URLSession.shared.dataTask(with: imageUrl) {
            (dataTwo, response, error) in
            
            guard let dataTwo = dataTwo else {
                completionHandler(nil, error)
                print("under dataTwo there are no data")
                return
            }
            
        let downloadedImage = UIImage(data: dataTwo)
        
        completionHandler(downloadedImage, nil)
            
        }
        
        taskTwo.resume()
        
    }
    
}
