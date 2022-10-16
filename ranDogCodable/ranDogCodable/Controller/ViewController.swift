//
//  ViewController.swift
//  ranDog
//
//  Created by mairo on 28/09/2022.
//

// MARK: 12. From JSON to Struct with Codable (still does not fetch/display the image)

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageVIew: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) {
            (data, response, error) in
            guard let data = data else {
                return
            }
            // 01:24 Here we can create a JSON decoder using its initializer, which does not require any parameters.
            let decoder = JSONDecoder()
            // 01:30 Now we are going to create an instance of the DogImage struct. So I am going to create a new constant. This constant will use type inference to become of type DogImage in a moment. Now I'll call the decoder's decode function. It takes two parameters, 1. a type to decode into and 2. the data that it should decode from.
            // 01:55 For the 1. type I'll pass in DogImage.self. Here, self just means we're referring to the definition of the DogImage structs we just created, not an instance of the struct.
            // 02:06 For the from data, I'll pass in the "data" we've unwrapped, and know they exist, the bytes representing our JSON response.
            // 02:14 And the compiler is remindi me that this "Call can throw, but it is not marked with 'try' and the error is not handled". You've already seen how we handled errors, with JSON serialization. 02:23 So, for now I'll just disable error propagation with try exclamation point. This is not something we should do in a production app but we'll discuss more about what to do when an error occurs later in the course.
            // ...
            let imageData = try! decoder.decode(DogImage.self, from: data)
            // 02:34 And that's it, our data will be decoded into an instance of the DogImage struct. With just these two steps to create the decoder, hence to decoe it into a custom type.
            // 02:44 THe kye difference here, between using JSON decoder and JSON's serialization, is that our networking code doesn't have to extract each property from the JSON. THe response is just converted into an instance of DogImage.
            // 02:58 Let's print the imageData that got parsed and see what it says. And we'll run it and it's cool. We have a DogImage struct, which contains:
                    /// status: "success",
                    /// message: "https://images.dog.ceo/breeds/..." the URL of the DogImage
            // 03:15 Note that whatever our JSON object contains, so long as our struct properties are the same as the keys, JSON decoder will corretly parse the data. There's no need to pull individual values out of a dictionary. Our data is parsed directly into our own model object. Like before, the messasge only contains the URL of the image, which means we don't have the imageData yet. In order to get it we need to make another network request. Fortunately, we've done this before, so that should be pretty straighforward. When you are ready let's do it.
            print(imageData)
        }
        task.resume()
    }
    
}

