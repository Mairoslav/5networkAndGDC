//
//  ViewController.swift
//  ranDog
//
//  Created by mairo on 28/09/2022.
//

import UIKit

// MARK: QUIZ from 15. Chaining Requests Refactor Part 2

class ViewController: UIViewController {
    
    // MARK: 12. Breeds List Setup
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
    // 04:30 Where does breeds come from? Well, just like a table view, a picker view can be populated with an Array. Let's add the breeds property to the ViewController byh scrolling up here (line 18), making it equal to an Array of Stings. And after = I'am going to add some breeds just so our picker has omething to display.
    // let breeds: [String] = ["boxer", "bulldog", "cattledog", "corgi", "dane", "germanshepard", "hound", "mix", "ovcharka"]
    let breeds: [String] = ["boxer", "hound"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 03:23 Remember that we need to make sure that our pickerView knows which object is the UIPickerViewDataSource and UIPickerViewDelegate. So we'll scroll up to viewDidLoad and set the dataSource to self which is our ViewController.
        // MARK: 12. Breeds List Setup
        pickerView.dataSource = self
        pickerView.delegate = self // and do the same thing for the delegate
        // 06:04 func pickerView... replaces the request we made in viewDidLoad, so I'am going to remove it. We'll only be requesting a random image if we have a breed selected in UIPickerView.
        /*
        DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(imageData:error:))
         */
        // 06:14 So let's run it and test it out. I'll move the pickerView to select an image and when the picker view value changes, an image is loaded. However, there's no guarantee that the image we get back will be of the selected breed. In order to correctly filter by breed, we need to modify the way our endpoint is stored so that it specifies that dog breed each time we make a request.
    }
    
    // note that vs previous version Button "Load the Dog" is removed, toghether with below @IBAction
    /*
    @IBAction func pressAndLoadImage(_ sender: Any) {
        
        DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(imageData:error:)) // this
        
    }
    */
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

// 03:14 (12. Breeds List Setup) For our convenience, let's just make our ViewController to conform to UIPickerViewDataSource and UIPickerViewDelegate, see: https://developer.apple.com/documentation/uikit/uipickerview/ We will do this using an extenstion below.
// 03:23 Remember that we need to make sure that our pickerView knows which object is the UIPickerViewDataSource and UIPickerViewDelegate. So we'll scroll up to viewDidLoad and set the dataSource to self which is our ViewController - check viewDidLoad.

// MARK: 12. Breeds List Setup
extension ViewController:
    UIPickerViewDataSource,
    UIPickerViewDelegate {
    // 04:14 Let's implement these methods now.
    // 04:17 In "numberOfComponents" in pickerView, we'll return one. We're just having the user select one value, the breed name.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 04:25 For a number of rows and component, we'll return breeds.counts.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
        // 04:30 Where does breeds come from? Well, just like a table view, a picker view can be populated with an Array. Let's add the breeds property to the ViewController byh scrolling up here (line 18), making it equal to an Array of Stings.
    }
    
    // 05:23 Let's implement these in the ViewController.
    // 05:28 Title for row and component just returns a String that will be displayed in the picker view. This is the name of the breed to be selected by the user.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // And we have an integer for the row the breed will be displayed in. So, we'll return the value in the breeds Array using the row as the index.
        return breeds[row] // note that if instead of row I can put here 0 or 1, however no other value, otherwise error: "Thread 1: Fatal error: Index out of range". This is valid when I have two breeds as per "let breeds: [String] = ["boxer", "hound"]"
    }
    
    // 05:44 For didSelectRowInComponent, this is called when the pickerView stops spinning and a breed has been selected.
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 05:51 When this happens, we want to fetch a new image from the DogAPI which we can do by calling our "requestRandomImage" method passing in "handleRandomImageResponse" method as the completion handler.
        // 06:04 This replaces the request we made in viewDidLoad, so I'am going to remove it. We'll only be requesting a random image if we have a breed.
       DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(imageData:error:))
    }
    
}
