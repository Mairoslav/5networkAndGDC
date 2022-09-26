//
//  ViewController.swift
//  ImageRequest
//
//  Created by mairo on 20/09/2022.
//

import UIKit

// to load an image from a URL, three URL strings, one http, one https and one string that isn't a real URL
enum KittenImageLocation: String {
    case http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
    case https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
    case error = "not a url"
}

class ViewController: UIViewController {
    
    // 01:25 create an image view outlet for the ImageView
    @IBOutlet weak var imageView: UIImageView!
    
    // 02:15 so that we can easily change which of these values we're working with. I'll set it equal to the .http rawValue for now ~ 02:30 So, we know the address of the image we want to retrieve
    let imageLocation = KittenImageLocation.http.rawValue // why says: "The resource could not be loaded because the App Transport Security policy requires the use of a secure connection." when I set the www.kittenswhiskers.com in Exception Domains via NSThirdPartyExceptionAllowsInsecureHTTPLoads in Info.plist
    // let imageLocation = KittenImageLocation.https.rawValue
    // let imageLocation = KittenImageLocation.error.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // 01:30 create load image action for button press
    @IBAction func handleLoadImageButtonPress(_ sender: Any) {
        // 02:55 We know the address of the image we want to retrieve, so our 1st task is to convert it into a URL.
        guard let imageUrl = URL(string: imageLocation) else {
            // That might succeed or fail, so we're going to use a guard statements, and if we can't create the URL, let's print an error to the connsole and exit early 03:05.
            print("cannot create URL")
            return
        }
        //  At this point we have an unwrapped URL. 03:13 Next, we need to create the HTTP get request to fetch the image from this URL. You might be tempted to instantiate it directly, but as the name suggests, the task needs to be associated with a URL session.
        // For now, we can use the URLSession.shared singleton, and so I'll pick the nethod for creating a DataTask that takes a URL and a completion handler as parameters. Time will pass between when we send the request and when we receive the response, so passing in a closure allows us to specify what code should run when the response does come.
        //  03:55 The URL is going to be the image URL we just created, and for the completion handler, because it is the last parameter, we can use trailing closure ** syntax and specify the three parameters: data, response and error
        
        // MARK: first alternative: using a DataTask
        // completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>) ** (commented out as per 10. Changing Data Task to Download Task)
        let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in // we have the in keyword to signal that this is the code that we want to execute
            // 04:49 We specified a completion handler or a closure that should be executed to handle a response. Let's implement it to check whether or not we got data back, and if we did, convert it to a UIImage and then update the UI. If the request was not successfull, let's exit early using guard. We can do this by ensuring that we got data back, and if not, that means an error occured.
            guard let data = data else {
                print("no data, or there was an error")
                return
            }
            // Below the guard, we know that we do have data. So let's try using it to create a UIImage.
            // 05:20 Now, this will return an optional, but that's totally OK, because we consider ImageViews image to either an image or nil, so we do not need to unwrap this.
            let downloadedImage = UIImage(data: data)
            // Once we do have the downloaded image, we can set it in the ImageView, and because we're using a closure, I'll need to use self, and we're going to set the image property to the downloaded image.
            // MARK: check 9. Multithreading and the Main Thread
            DispatchQueue.main.async {
                self.imageView.image = downloadedImage // Reference to property 'imageView' in closure requires explicit use of 'self' to make capture semantics explicit / Reference 'self.' explicitly
                // Error after running https for wolf image...: UIImageView.image must be used from main thread only ~ that's why we call DispatchQueue.main.async { ... with code to update the imageView inside its body
            }
        }
        // Great, so now the DataTask will load any data we successfufllyfetch right into memory. But watch out, it seems like we have kicked off the task, but remember that when you create a DataTask, it starts in a suspennded state. So, in order to actually run the task, you need to call task.resume()
        task.resume()
        
        // MARK: second alternative: using a DownloadTask, as per 10. Changing Data Task to DownloadTask
        // 01:36 We still have a URL for the kitten image and like before, we will start typing URLSession.shared
        // 01:44 Then we'll call the func .downloadTask method - we'll choose the one that takes a URL and a completion handler.
        // 01:51 For the URL, we pass in the imageURL.
        // 01:54 For the completion handler, we'll use trailing closure syntax. You can choose any names you want for the parameters, still here I stick with names locations, response and error. Keep in mind also "in" keyword to signal the body of our closure.
//        let task = URLSession.shared.downloadTask(with: imageUrl) { (location, response, error) in
//            // Just like the data parameter from the data task, location is optional. Going to unwrap it using a guard statement and will return early if the location is nil.
//            guard let location = location else {
//                print("location is nil")
//                return
//            }
//            // 02:26 I am going to print the location so that we can see it when we run the app.
//            print(location)
//            //  02:30 So, now we have a URL which corresponds to a temporary file we downloaded from the network. There are just three things left to do. First, we need to load the data from the file. Second, we need to turn it into an image. Third, set the image in our image view.
//
//            // 02:47 To convert the data into an instance of data, we can use its initializer that takes a URL, which will work for URLs of files stored on the device.
//            // let imageData = Data(contentsOf: location) // 02:55 This call can throw, but for the purpose of demonstration, I'll use try with the exclamation point as per below line
//            let imageData = try! Data(contentsOf: location)
//            // 03:02 In a real app, of course, we'd want to feel gracefully if the download fails. Hopefully, it doesn't fail and if so, we can then turn the data into an image. This step is exactly the same as if we got the data directly from the network.
//            let image = UIImage(data: imageData)
//            // 03:16 Then, like before, we can load the data into the imageView like so. Do not forget, we should only update the UI on the main thread. So, we'll need to wrap this in a call to async.
//            DispatchQueue.main.async {
//                self.imageView.image = image
//            }
//        }
//        // 03:29 Just one more thing, we need to make sure our request actually gets made with task.resume()
//        task.resume()
    }
    // 03:34 All right, we'll test it again to see if it still works. So run the app, press "Load Image" button an voila, the image loads just as before (as per 10. Changing Data Task to Download Task).
}

/*
 05:44 OK, so our DataTask is ready to go. Let's run it and test, we see our Loadimage button on the screen, and if I press it, hmm hothing, that's not what we expected but it looks like our console output exploded. Let's expand it to see what it has to say. Hemmm Interestning. It says "App Transport Security has blocked a clear text HTTP resource load since it is incesure. Temporary exceptions can be configured in your apps info.P list file". What does this mean? Well, it means that we're trying to retrieve data using the older HTTP protocol of the newer and safer HTTPS protocol.
 
 06:32 We know that we should use HTTPS if at all possible, but the reality is some servers still use HTTP. Apple does make it possible for us to load data from select HTTP connections, but the dafault security settings only allow secured connections over HTTPS.
 */

/*
 Source: Udacity course and GitHub https://github.com/wsigel/ImageRequest/blob/master/ImageRequest/Controller/ViewController.swift
 https://github.com/wsigel/ImageRequest/blob/master/ImageRequest/Info.plist
 */

