//
//  ViewController.swift
//  ranDog
//
//  Created by mairo on 28/09/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageVIew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: 6. Storing the Endpoint
        // To verify that this works and doesn't crash, let's try printing the URL from the ViewController's viewDidLoad function. And run the app.
        // print(DogAPI.Endpoint.randomImageFromAllDogsCollection.url)
        
        // MARK: 7. Making the Request
        // 00:00 Instead of just printing the URL, let's store it in a constant instead. You can name the constant randomImageEndpoint.
        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        //  00:25 Now the remaining tasks are very similar to the stepts we already took when requewsting a static resource. We'll create a URL session data task and handle the response. We can use the shared URL sessioin for this. So, we'll set the task equal to URLSession.shared and choose the dataTask method with the URL and completion handler parameters. We can pass in our randomImageEndpoint for the URL, and then for the completion handler, if we double-click *** on parameter list, we can turn this into trailing closure syntax 00:58. This makes it much easier to just tab through and rename the parameters: data, response and error.
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in // ***
            //  01:12 Then to fill in the code that we want to run when the handler is called. This completion handler passes in a closure or a function. When the app receives a response from the server, the completion handler will be called. The dataTask method or URLSession task has no idea what we want to do with the data once it's been received. So, we tell it twhat code should be run when the request is complete. 01:35 The response is either the data we got back or an error. So, we need to figure out what kind of response we got. Let's use a guard statement to confirm that the data we got is not nil. We'll write, guard let data equals data else, we don't have the data we wanted and we can return from this function immediately.
            guard let data = data else {
                return
            }
            // 01:58 After the  guard, we know that we do have data. So, let's print it out to see what's in here.
            print("prints data as xy bytes, as you can see: \"\(data)\"")
            
            // MARK: 9. Parsing JSON with JSONSerialization
            // 00:58 We're going to store JSON object in a new constant, and parse it with JSONSerialization.
            // 01:04 We type JSONSerialization.json and split autotomplete fill in the right function. Notice that this is called on the JSONSerialization class itself, that's because "jsonObject(with: Data..."  is a class method, we do not ever need to create an instance of JSONSerialization. For the data, we just parse in the data we unwrapped using the guard statement. These are the bytes we want to parse as JSON.
            // 01:34 For "options:", we are expecting an Array. I am just going to leave this empty (probably that's why now in Swift this part is not any more visible even though in documetnation it is stated - STILL I HAVE TO ADD IT THERE SO WRITE: "options: [] ... after data,), we do not need to do anything with this propert in Swift, but if you'd like to learn more about JSON reading options, I have included more details in the instructor notes.
            // 01:47 So, we call JSON object with data but it looks like the compiler is givving us an error: "Call can throw, but it is not marked with 'try' and the error is not handled". 01:52 For exsmple, if the response from the dogAPI were not valid JSON data, it would not be possible for this to succeed.
            // 02:00 We can handle this with a do catch and mark it with try (versus only le json = JSONSerialization). In the even of an error, we can just print it out but if not that means the parsing was successful and we're one step away from accessing the JSON data.
            // 02:15 Remember that the format for this object is like a Dictionary where keys are Strings and the values can be of any type. JSON objects with data returns -> Any.
            // So, we're going to need to force cast it to a Dictionary type ...as! [String: Any]... where keys are Strings and values can be of any type.
            // 02:24 So, we're going to need to force cast it to a Dictionary type ...as! [String: Any]... where keys are Strings and values can be of any type.
            // 02:35 Now we can grab the URL from the dictionary (let url = ... under let json) and store it as a String and instead of printing the data, let's now print the URL to see what we've got. Run the app, and if we look at the console, we see the image URL gets printed out. Congratulations, you've successfully parsed the dog APIs JSON response in your app. Parsing JSON with JSONSerialization works just fine with small data like this. However, as we begin workig with more complex JSON, parsing JSON like this will quickly get messy. Next up, we're going to clean up our parsing code to convert our JSON object into a custom struct leveraging the newer MARK: Codable protocol
           
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let url = json["message"]
                    as! String
                print("instead of xy bytes, now url is printed out, can see: \"\(url)\"")
            } catch {
                print(error)
            }
            
        }
        //  02:02 Last but not least, do not forget to call task.resume(). Since tasks are created in a suspended state, we have to call .resume() to kick them off. OK, so let's run it and it's a 102 bytes (here at my side 97 bytes). Hmmm, what's that? Is that an image file? Well, not yet. If you remember from looking at the documentation (02:24), we are expectiung a JSON response with the "status" and "message" like this (02:25) ~ shall print out: "DogImage(status: "success", message: "https://images.dog.ceo/breeds/terrier-toy/n02087046_6357.jpg")" - as per next project named "ranDogCodable"  So how do we turn a 102 (97) ** bytes into this JSON? ** That will be our next task.
        task.resume()
    }
    
}

