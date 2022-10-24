//
//  ViewController.swift
//  ranDog
//
//  Created by mairo on 28/09/2022.
//

import UIKit

// MARK: 13. Filter By Breed
// 00:24 I'll add a new "case" and we'll call it "randomImageForBreed" (this done in DogAPI.swift file)

class ViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
    // let breeds: [String] = ["malinoisInexZero", "malinoisIndexOne"]
    let breeds: [String] = ["malinois", "retriever"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    func handleRandomImageResponse(imageData: DogImage?, error: Error?) {
        
        guard let imageUrl =  URL(string: imageData?.message ?? "") else {
            return
        }
        
        DogAPI.requestImageFile(imageUrl: imageUrl, completionHandler: self.HandleImageFileResponse(image:error:))
        
    }
        
    func HandleImageFileResponse(image: UIImage?, error: Error?) {
        
        DispatchQueue.main.async {
            self.imageView.image = image
        }
        
    }
    
}

extension ViewController:
    UIPickerViewDataSource,
    UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(imageData:error:)) // Missing argument for parameter 'breed' in call so ... check comments below: 02:57 ...
        // 02:57 All right. So we're almost done. We just need to modify where we can call this method to provide the breed. In didSelectRow and component (switch to ViewController.swift file), let's fill in the breed parameter. We'll get this from the breeds Array at the row that was just selected. Cool. So in our pickerView data source and delegate are fully implemented and we can now get a randomimage just specifying the dog breed.
        // 03:21 But we're still using hard coded values for dog breeds up here (see up "let breeds: ["malinois", "retriever"]). With everything setup, let's finish implementing the breeds list feature by using our JSON parsing knowledge to get a list of breeds from theh dogAPI.
        DogAPI.requestRandomImage(breed: breeds[row], completionHandler: handleRandomImageResponse(imageData:error:)) // "breed: breeds[row]," added
    }
    
}
