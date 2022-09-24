//: [Previous](@previous)

// MARK: 5. URLSession and Data Tasks

import Foundation

/*
 00:00 So far you have gotten a lot of practice working with URLs in Swift and breaking them down into their components. But what do we do with URLs? That's where making network requests comes in. To make network request in iOS, we use the URLSession object. What is the URLSession?
 
 00:20 According to the documentation URLSession is "An object that coordinates a group of related, network data transfer tasks". That is just Apple's technical jargon for something that makes network requests.
 
 00:40 URLSession provides the shared property: "URLSession.shared", an object that can be used throughout your app. We'll talk what exactly URLSession can do later on. But for now let's see how to make a network request. When we say the word Request, URLSession calls them tasks or URLSessionTask(s). There are several different types of tasks used by URLSession:
        
        a) URLSessionDataTask
        b) URLSessionDownloadTask
        c) URLSessionUploadTask
        d) URLSessionStreamTask
 
 a) URLSessionDataTask returns data from the network directly into memory as an instance of the data struct. 01:15 Data is just a type in Swift that stores raw data or bytes.
 
 b) URLSessionDownloadTask works like a a) URLSessionDataTask, except that the data is stored directly in a file on a device. We use b) URLSessionDownloadTask when loading large files from network that we do not necessarily need to store in memory while our app is running.
 
 c) URLSessionUploadTask is used for uploading data or sending a large amount of data from the device to the server. For example, an app that lets you share a picture on social media would use an c) URLSessionUploadTask
 
 d) URLSessionStreamTask is a way to load a continuous stream of data over the network. Accessing music or video files from a server are just some examples when you want to use c) URLSessionUploadTask
 */
 
 // MARK: Each task a), b), c), d) is a subclass of URLSessionTask, that means that each one inherits all of the properties and methods of URLSessionTask.
 
 // 02:25 The most common data task and also the one that we will be using throughout this course is a) URLSessionDataTask, let's look at the documentation to see how to use our URLSession object to create a _DataTask. We search for "Adding Data Tasks to a Session" - we see here in developerDocumentation a lot of methods for creating Data tasks. For now I'am just going to focus on this one:
 
    // func dataTask(with: URLRequest, completionHandler: (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
 
    // Creates a task that retrieves the contents of a URL based on the specified URL request object, and calls a handler upon completion.
 
 // 02:54 As we can see this method takes two parameters (can see after clicking on this fx in developerDocumentation):

    // 1. URL - The URL to be retrieved i.e. a URL pointing to the location we want to download data from, and

    // 2. completionHandler - which is just a closure. 03:04 Looking at the completion handler, we can see that our response gives us three values;
        
        // 2.1 data - data is what we request from server
        // 2.2 response - response is a type URL response, which is the class representing an HTTP response. Remember that the response contains information whether or not a request was successful, such as status code. If the request fails, we also get an error ...
        // 2.3 error - 03:34 that contains specific details on what went wrong, so that our app can respond accordingly.

// 03:40 Great so we're almost ready to start making a request. But there is one more thing I would like to show you about this method - the return type URLSessionDataTask. Remember from earlier that DataTasks and other types of tasks are just subclasses of URLSessionTask. 04:00 Let's take a moment to check out URLSessionTask documentation. We can see that it lists different types of tasks, and then this note at the bottom:

    // Note:
    // All task properties support key-value observing.

// 04:05 As it is stated in developer documentation "After you create a task, you start it by calling its resume() method", that's strange. Why do we need to resume() a task if it has been already been started? Well just calling the func dataTask method does not actually start the DataTask. The task it creates is in a suspended state. 04:24 When your app is actually making the request, you should call the func resume() method...

// 04:30 This is a common error when making network requests on iOS. And if you ever wonder why DataTask is not doing anything It is probably that resume () method never gets called. That may sound like a lot to remember and it is. But it is enough to make our first network requests in Swift with just a few lines of code. Let's take what we have learned and actually make that request next.

// MARK: quiz1: A user installs an app from the App Store.
// Yes, a data task could be used, but since this is a file to be stored permanently, we can also use a URLSessionDownloadTask. This is necessary, because some apps are really large, and an iPhone would not have enough memory to download everything using a data task.

// MARK: quiz2: A user initiates a request for a ride in a taxi app (like Uber of Lyft). What type of task is used?
// Yes, this is probably an HTTP request, and in general URLSessionDataTask will be used for most network requests.

// MARK: In the Apple Music app, users can listen to songs over the network, but the songs are not stored permanently on the device. Which type of task is used?
// Yes,there's a continuous stream of data, and it's only used once, as the music plays, so a URLSessionStreamTask would be appropriate.

//: [Next](@next)
