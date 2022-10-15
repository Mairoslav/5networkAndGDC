//
//  ViewController.swift
//  ranDog
//
//  Created by mairo on 28/09/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressAndLoadImage(_ sender: Any) {
        
        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        
        let taskOne = URLSession.shared.dataTask(with: randomImageEndpoint) {
            (dataOne, response, error) in
            guard let dataOne = dataOne else {
                print("under dataOne there are no data")
                return
            }
            
            let decoder = JSONDecoder()
            
            let imageData = try! decoder.decode(DogImage.self, from: dataOne)
            
            print(imageData)
            print(imageData.message)
            
            let imageLocation = imageData.message
            
            guard let imageUrl = URL(string: imageLocation) else {
                print("cannot create URL from given String defined under constant imageLocation")
                return
            }
            
            // MARK: 15. Chaining Requests Refactor Part 1
            // 04:48 So, we're done implementing request image file in  DogAPI.swift file. Now, it's time to call it from our ViewController. We'll do this once we have the URL by calling "DogAPI.requestImageFile(imageUrl:..." Now switch to ViewController, yes we are here now.
            // 05:11 we will pass in the URL or the imgageURL we created within the guard let. For completion handler, we receive an optional UIImage, I'll call that image as well as an error. Just like before, we'll need to add a call to async to ensure updates happen on the main thread, and set the image in the imageView.
            // 05:35 If an error occurred, then this image will be nil, and this will have no effect. So we've moved one network requ4est out of the ViewController, but we still have a lot of indenting. Let's take care of that next... see next project called "ranDogCodableFetchRefactorII
            
            DogAPI.requestImageFile(imageUrl: imageUrl, completionHandler: { // TODO: new DispatchQueue relocated here
                (image,error) in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            })
            
            // commented out/removed the old code related to taskTwo, now we have refactored into our new method
            /*
            let taskTwo = URLSession.shared.dataTask(with: imageUrl) {
                (dataTwo, response, error) in
                guard let dataTwo = dataTwo else {
                    print("under dataTwo there are no data")
                    return
                }
                let downloadedImage = UIImage(data: dataTwo)
                
                DispatchQueue.main.async {
                    self.imageView.image = downloadedImage
                }
            }
            taskTwo.resume()
            */
            
        }
        taskOne.resume()
    }
}
