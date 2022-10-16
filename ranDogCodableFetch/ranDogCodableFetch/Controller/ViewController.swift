//
//  ViewController.swift
//  ranDog
//
//  Created by mairo on 28/09/2022.
//

// comments in this default style are as per learning material Xcode project named "ImageRequest" where image of "Cat" is loaded, just here they are  applied for this "Dog" project.
/// comments in this style are from lesson 13. Fetching the Image,  just to have kind of "synonym comments", basically we do the same
// TODO: comments starting with TODO: are based on QUIZ from lesson 12. From JSON to Struct with Codable

import UIKit

/// 00:00 I am going to walk you through the steps needed to load the image into the image view. After we have converted the response to JSON, we'll need to covnvert the String that we've stored into a URL.
class ViewController: UIViewController {
    // 01:25 create an image view outlet for the ImageView
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() { // note that I could not drag and drop button within viewDidLoad() {...  body, therefore I opted to include whole code within @IBAction func pressAndLoadImage(_ sender: Any) { instead (vs. see project ImageRequest where all code is within func viewDidLoad())
        super.viewDidLoad()
    } //  keep } here in case want to use @IBAction for button
    
    // create action so after pressing button "Load Image from URL" the image is displayed
    @IBAction func pressAndLoadImage(_ sender: Any) {
        
        // To verify that this works and doesn't crash, let's try printing the URL from the ViewController's viewDidLoad function. And run the app.
        // print(DogAPI.Endpoint.randomImageFromAllDogsCollection.url)
        // Instead of just printing the URL, let's store it in a constant instead. You can name the constant randomImageEndpoint.
        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        //  00:25 Now the remaining tasks are very similar to the stepts we already took when requewsting a static resource. We'll create a URL session data task and handle the response. We can use the shared URL sessioin for this. So, we'll set the task equal to URLSession.shared and choose the dataTask method with the URL and completion handler parameters. We can pass in our randomImageEndpoint for the URL, and then for the completion handler, if we double-click *** on parameter list, we can turn this into trailing closure syntax 00:58. This makes it much easier to just tab through and rename the parameters: data, response and error.
        let taskOne = URLSession.shared.dataTask(with: randomImageEndpoint) { (dataOne, response, error) in // ***
            //  01:12 Then to fill in the code that we want to run when the handler is called. This completion handler passes in a closure or a function. When the app receives a response from the server, the completion handler will be called. The dataTask method or URLSession task has no idea what we want to do with the data once it's been received. So, we tell it twhat code should be run when the request is complete. 01:35 The response is either the data we got back or an error. So, we need to figure out what kind of response we got. Let's use a guard statement to confirm that the data we got is not nil. We'll write, guard let data equals data else, we don't have the data we wanted and we can return from this function immediately.
            guard let dataOne = dataOne else {
                print("under dataOne there are no data")
                return
            }
            
            // 12. From JSON to Struct with Codable: 01:24 Here we can create a JSON decoder using its initializer, which does not require any parameters.
            let decoder = JSONDecoder()
            // 01:30 Now we are going to create an instance of the DogImage struct. So I am going to create a new constant. This constant will use type inference to become of type DogImage in a moment. Now I'll call the decoder's decode function. It takes two parameters, 1. a type to decode into and 2. the data that it should decode from.
            // 01:55 For the 1. type I'll pass in DogImage.self. Here, self just means we're referring to the definition of the DogImage structs we just created, not an instance of the struct.
            // 02:06 For the from data, I'll pass in the "data" we've unwrapped, and know they exist, the bytes representing our JSON response.
            // 02:14 And the compiler is remindi me that this "Call can throw, but it is not marked with 'try' and the error is not handled". You've already seen how we handled errors, with JSON serialization. 02:23 So, for now I'll just disable error propagation with try exclamation point. This is not something we should do in a production app but we'll discuss more about what to do when an error occurs later in the course.
            let imageData = try! decoder.decode(DogImage.self, from: dataOne)
            // 02:34 And that's it, our data will be decoded into an instance of the DogImage struct. With just these two steps to create the decoder, hence to decoe it into a custom type.
            // 02:44 THe kye difference here, between using JSON decoder and JSON's serialization, is that our networking code doesn't have to extract each property from the JSON. THe response is just converted into an instance of DogImage.
            // 02:58 Let's print the imageData that got parsed and see what it says. And we'll run it and it's cool. We have a DogImage struct, which contains:
            /// status: "success",
            /// message: "https://images.dog.ceo/breeds/..." the URL of the DogImage
            // 03:15 Note that whatever our JSON object contains, so long as our struct properties are the same as the keys, JSON decoder will corretly parse the data. There's no need to pull individual values out of a dictionary. Our data is parsed directly into our own model object. Like before, the messasge only contains the URL of the image, which means we don't have the imageData yet. In order to get it we need to make another network request. Fortunately, we've done this before, so that should be pretty straighforward. When you are ready let's do it.
            print(imageData)
            print(imageData.message)
            
            // ...
            /// 13. Fetching the Image, 00:00 I am going to walk you through the steps needed to load the image into the image view.
            // TODO: a1) Create a constant that stores "message" property of "imageData". / Can use it directly "string: imageData.message" instead of "string: imageLocation", see a2)
            let imageLocation = imageData.message
            
            /// After we have converted the response to JSON, we'll need to covnvert the String that we've stored into a URL. Le't store it in a constant called imageURL  and use the URL initializer that takes a String as a parameter. 00:26 And for the String family, I'll pass in constant imageLocation that represents imageData.message
            // TODO: a2) You'll need to convert it to a "URL" to make the request.
            // We know the address of the image we want to retrieve, so our 1st task is to convert it into a URL
            guard let imageUrl = URL(string: imageLocation) else { // alternativelly can use let imageLocation when not commented out, see a1)
                /// Now it's ppossible that dogAPI did not return a valid URL. So, let's unwrap this using guard let to ensure the URL is not nil.
                // That might succeed or fail, so we're going to use a guard statements, and if we can't create the URL, let's print an error to the connsole and exit early
                print("cannot create URL from given String defined under constant imageLocation")
                return
            }
            // TODO: b) Create a "URLSessionDataTask" to download the image.
            /// 00:43 Now, we'll use this URL to create and tart another URL session data task. We're already in the completion handler of another data task, so that might feel little messy but this is a very common scenario that need to take the output from one network call and use it to make another network request. We'll talk about ways to clean up the code soon. For now let's handle this exaclty the same way we did last time.
            /// 01:09 We'll create a new task and set that equal to URLSession.shared.dataTask and will choose method with both a) the URL and b) completion handler parameter. For a) URL parameter we'll pass in the imageURL we just created. And for b) copletion handler, we're alrady in another closure with the same parameters, so we can see that it doesn't allow us to use trailing closure syntax (NO actually it did  allow me to use trailig closure syntax, maybe beause I named it differently as taskOne and taskTwo, bo.. ). We can simply rename the variable to data, response and error (anyhowe this have done also in my case).
            // At this point we have an unwrapped URL. Next, we need to create the HTTP get request to fetch the image from this URL. You might be tempted to instantiate it directly, but as the name suggests, the task needs to be associated with a URL session.
            // For now, we can use the URLSession.shared singleton, and so I'll pick the method for creating a DataTask that takes a URL and a completion handler as parameters. Time will pass between when we send the request and when we receive the response, so passing in a closure allows us to specify what code should run when the response does come.
            // For now, we can use the URLSession.shared singleton, and so I'll pick the method for creating a DataTask that takes a URL and a completion handler as parameters. Time will pass between when we send the request and when we receive the response, so passing in a closure allows us to specify what code should run when the response does come.
            // The URL is going to be the image URL we just created, and for the completion handler, because it is the last parameter, we can use trailing closure ** syntax and specify the three parameters: data, response and error
            let taskTwo = URLSession.shared.dataTask(with: imageUrl) { (dataTwo, response, error) in
                // TODO: c) Convert the downloaded data into a "UIImage". Check for errors as appropriate.
                /// 01:43 Now we can fill in the functio body with the code that we want to run when we get a response. We'll guard that we got data back and if we didn't, we'll simply return.
                // We specified a completion handler or a closure that should be executed to handle a response. Let's implement it to check whether or not we got data back, and if we did, convert it to a UIImage and then update the UI. If the request was not successfull, let's exit early using guard. We can do this by ensuring that we got data back, and if not, that means an error occured.
                guard let dataTwo = dataTwo else {
                    print("under dataTwo there are no data")
                    return
                }
                /// 01:54 But if we have data, that's great. We'll convert it to a UIImage with let downloadedImage and I'll use the UIImage initializer that accepts data as a parameter. 02:09 The UIImage initializer returns an optional (checking it by opion+click on "data" parameter label)  which is OK because our image view on the storyboard can accept an optional image.
                // Below the guard, we know that we do have data. So let's try using it to create a UIImage.
                // Now, this will return an optional, but that's totally OK, because we consider ImageViews image to either an image or nil, so we do not need to unwrap this.
                let downloadedImage = UIImage(data: dataTwo)
                // TODO: d1) Set the imageView to display this image.
                /// 02:15 The only hitch left is that our closure code is running on a random thread but we can only update the UI on the main thread. So we need to Dispatch that work over to the main thread like this (DispatchQueue.main.async {),  and we'll set self.imageView.image equal to the image we downloaded.
                // Once we do have the downloaded image, we can set it in the ImageView, and because we're using a closure, I'll need to use self, and we're going to set the image property to the downloaded image.
                // TODO: d2) Be sure to use the [|.|:|] main thread!!!
                DispatchQueue.main.async { // Error after running app without "DispatchQueue.main.async {... :" UIImageView.image must be used from main thread only" ~ that's why we call DispatchQueue.main.async { ... with code to update the imageView inside its body
                    self.imageView.image = downloadedImage // Reference to property 'imageView' in closure requires explicit use of 'self' to make capture semantics explicit / Reference 'self.' explicitly
                }
            }
            /// 02:35 Finally, what's our last step? Missing this step is a common mistake, yes we have to resume our task, so we need to add a call to taskX.resume()
            /// 02:53 Now we're ready to run. If we're successful, this time the UI will actually show our image and there it is. That's a lot of steps:
                /// 03:06 We started with the URL for fetching a random image ... (see let randomImageEndpoin in  line 25),
                /// then we fetched a JSON repponse containing the image's URL ...  (see let taskOne = URLSession.shared.dataTask(with: randomImageEndpoint) in line 27)
                /// parsed the JSON using JSON decoder ... (see let decoder = JSONDecoder() in line 35)
                /// loaded the image into our imageView ... (see DispatchQueue.main.async {... in line 87)
            /// 03:22 Take a moment to review the steps we took to get the image loaded then we'll do some refractoring so that our code is easier to work with as we add more features to our app. 
            taskTwo.resume()
            // ...
        }
        taskOne.resume()
    // keep } in case want to use  viewDidLoad()
    } // keep } in case wan to use @IBAction func pressAndLoadImage(_ sender: Any) {...
}

// TODO: 12. From JSON to Struct with Codable QUIZ - steps from a1 to d2 are withing this Project all commented with // TODO:
// QUIZ: You've already used URLSession to fetch an image. It's time to get some more practice making a request. Now that we have a "DogImage" struct containing a "message", (the image's URL), add code ...starting below the parsing code... to fetch the image and display it in the image view.

// a1) Create a constant that stores "message" property of "imageData".
// a2) You'll need to convert it to a "URL" to make the request.

// b) Create a "URLSessionDataTask" to download the image.

// c) Convert the downloaded data into a "UIImage". Check for errors as appropriate.

// d1) Set the image view to display this image.
// d2) Be sure to use the main thread!


