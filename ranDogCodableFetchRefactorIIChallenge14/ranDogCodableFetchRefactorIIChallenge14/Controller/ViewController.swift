//
//  ViewController.swift
//  ranDog
//
//  Created by mairo on 28/09/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
    // *** change from let to var as per 3b. 04:29 
    var breeds: [String] = [] // = ["malinois", "retriever"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        // MARK: 4
        // 4a. 05:04 There just one more step to get the breeds list working. We need to make our request. We'll do this in a viewDidLoad(), to ensure we fetched the breeds list immediatelly upon app does launch, passing in "handleBreedsListRespponse" as the completion handler.
        DogAPI.requestBreedsList(completionHandler: handleBreedsListResponse(breeds:error:))
        // 4b. 05:22 Now that we are getting the breedsList ~ listAllBreeds from the API, we no longer need this static list of breeds up here. So I'll just make this an empty Array (comment out "= ["malinois", "retriever"]"). Ok, let's run it to see the completed app in action. If I scroll through and select a breed, we'll see an image appears and if I scroll through again to select a different breed, then we'll see that the image gets updated. Now if you are like me, I don't know anyting about different dog breeds. So i can't tell you if this is the exact breed. But the dogAPI does and by calling the right endpoint, passing in the selected breed, we can be sure that the API returns the right image annd our breeds list feature is complete. 
    }
    
    func handleRandomImageResponse(imageData: DogImage?, error: Error?) {
        guard let imageUrl =  URL(string: imageData?.message ?? "") else {
            return
        }
        DogAPI.requestImageFile(imageUrl: imageUrl, completionHandler: self.handleImageFileResponse(image:error:))
    }
    
    // MARK: 3
    // 3a. 04:09 Like the other requests, I am going to crate a new nethod to act as the completion handler. We'll all it "handleBreedsListResponse" and it will take the same parameters as the completioin handler for the mehtod we just created, and Array of Strings for the breeds and an optiona error in case something went wrong.
    func handleBreedsListResponse(breeds: [String], error: Error?) {
        // 3b. 04:29 In this method, all we need to do is update the breds list and reload the data. So I'll assign self.breeds, our global property  to the breds list that we got back from the server. Breeds is currently a constant but I am going to change it to a variable so that we can update its value (*** change from let to var).
        self.breeds = breeds
        // 3.c. 04:46 To update the picker, just like a table view, we need to reload the data. But because we're updating the UI, we need to do this on the main thread. So I am going to add a call to async here and reload the data I'll call self.pickerView.reloadAllComponents().
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }
        
    func handleImageFileResponse(image: UIImage?, error: Error?) {
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
        DogAPI.requestRandomImage(breed: breeds[row], completionHandler: handleRandomImageResponse(imageData:error:)) 
    }
    
}
