//: [Previous](@previous)

// MARK: 10. Changing Data Task to Download Task

import Foundation

/*
 00:00 We have seen how to use the URLSessionDataTask to fetch a resource over the network and load it straight to memory. Before we conclude this lesson, let's take a look back at some of the other URLSession tasks, specifically if we wanted to download the image data into a file before loading it into our app.
 
 00:23 To do this, let's refractor our request to use a URLSession download task. If we go back into the documentation for URLSession, we can see that there's also a variety of ways to create download tasks. Let's use this method:
 
        https://developer.apple.com/documentation/foundation/urlsession
        MARK: func downloadTask(with: URL, completionHandler: (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask
        
        Creates a download task that retrieves the contents of the specified URL, saves the results to a file, and calls a handler upon completion.
 
 00:34 Like the one for data task, we'll use the one that takes a URL and a completion handler. Like the completion handler for a data task, we see that it returns a response and an error like we expect.
 
 00:47 But what about this first value, location? (see below marked by ***)
 
    This completion handler takes the following parameters:
    MARK: location ***
    The location of a temporary file where the server’s response is stored. You must move this file or open it for reading before your completion handler returns. Otherwise, the file is deleted, and the data is lost.
    MARK: response
    An object that provides response metadata, such as HTTP headers and status code. If you are making an HTTP or HTTPS request, the returned object is actually an HTTPURLResponse object.
    MARK: error
    An error object that indicates why the request failed, or nil if the request was successful.
 
 00:50 Well, because data tasks returned the data stored in memory, we got back an instance of the data struct or the data we got back from the server. For func downloadTasks, the data returned by the server is stored on the device and its location is the URL of this file. Even thoughh it's a URL, don't let the name be deceiving. The iOS file system uses URLs to point to any resource, not just files from the network. These files actually store locally on the device.
 
 01:19 In order to use this file, we need to read it into UIImage. That's the key difference between using a dataTask and downloadTask.
 
 01:27 Let's switch back to our app to see it in action. First, I am going to comment all the code that makes the data task so that we can start over.
 
 01:36 We still have a URL for the kitten image and like before, we will start typing URLSession.shared
 01:44 Then we'll call the func downloadTask method - we'll choose the one that takes a URL and a completion handler.
 01:51 For the URL, we pass in the imageURL.
 01:54 For the completion handler, we'll use trailing closure syntax. You can choose any names you want for the parameters, still here I stick with names locations, response and error. Keep in mind also "in" keyword to signal the body of our closure.
 
 Just like the data parameter from the data task, location is optional. Going to unwrap it using a guard statement and will return early if the location is nil.
 
 02:26 I am going to print the location so that we can see it when we run the app.
 
 02:30 So, now we have a URL which corresponds to a temporary file we downloaded from the network. There are just three things left to do. First, we need to load the data from the file. Second, we need to turn it into an image. Third, set the image in our image view.
 
 02:47 To convert the data into an instance of data, we can use its initializer that takes a URL, which will work for URLs of files stored on the device. 02:55 This call can throw, but for the purpose of demonstration, I'll use try with the exclamation point.
 
 03:02 In a real app, of course, we'd want to feel gracefully if the download fails. Hopefully, it doesn't fail and if so, we can then turn the data into an image. This step is exactly the same as if we got the data directly from the network.
 
 // 03:16 Then, like before, we can load the data into the imageView like so. Do not forget, we should only update the UI on the main thread. So, we'll need to wrap this in a call to async.
 
 // 03:29 Just one more thing, we need to make sure our request actually gets made with task.resume()
 
 // 03:34 All right, we'll test it again to see if it still works. So run the app, press "Load Image" button an voila, the image loads just as before.
 
 // 03:44 Notice in the print output, that we can see the address to the temporary file. Right now, we're just loading the image data from this temporary file directly into memory, but if we wanted to store it in longer-term, we'd move this file to a permanent location such as the user's documents directory. You'll learn more about the documents directory and working with files in general in the courses on persistence. For now, I just wanted to show you the similarities between working with different types of URLSession tasks. 
 */


//: [Next](@next)
