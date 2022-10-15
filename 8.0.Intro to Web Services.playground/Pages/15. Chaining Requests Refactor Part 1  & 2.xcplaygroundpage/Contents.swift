//: [Previous](@previous)

import Foundation

// MARK: 15. Chaining Requests Refactor Part 1

/*
 00:00 Okay. So, we've come along way. We started with the end point for a random image of a dog and now we have an image displayed in our app. This looks great, but our code is starting to get a bit messy.
 
 00:14 Notice how we're chaining different request together:
 
        1. using the URL returned by the first request
           
           let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
           let taskOne = URLSession.shared.dataTask(with: randomImageEndpoint) { (dataOne, response, error) in
                guard let dataOne = dataOne else {
                    print("under dataOne there are no data")
                    return
                }
                taskOne.resume()
 
 
        2. to fetch the image with the sedond request.
           
           let imageLocation = imageData.message
           guard let imageUrl = URL(string: imageLocation) else {
                print("cannot create URL from given String defined under constant imageLocation")
                return
           }
           let taskTwo = URLSession.shared.dataTask(with: imageUrl) { (dataTwo, response, error) in
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
 
 00:22 With these two requests, in some places we have, let's see one, two, three, four, five levels of indenting (i.e five "}" closing sharp brackets). What if we had to chain three requests together? That could get quite messsy. Developers have a name for this. The Pyramid of Doom. https://levelup.gitconnected.com/escape-the-pyramid-of-doom-c58edd326225 Sounds funny, but it's certainly not something we'd want in our code.
 
 00:46 Another problem is that we're making network requests inside of the ViewController. While technically this works, network request deals direcly with data which belong to the Model(M) component of the MVC diagram. The ViewController whould only be concerned with how that data represented by our model objects is displayed to the user.
 
 01:05 You may hear MVC get called "massive" ViewController, check: https://medium.com/divar-mobile-engineering/what-is-massive-view-controller-and-how-to-avoid-it-in-swift-2fca3e7dc00 , but this is often the result of bad architecture like this, and it does not have to be this way.
 
 01:15 For proper MVC design and to save us from the Pyramid of Doom, let's fix these issues to make our netwoking code easier to deal with.
 
 01:21 Let's start with the second request, the one that downloads the actual image file. We want the code that performs networks requests to live in the Model(M) group of MVC. So we're going to go into DogAPI.swift file and add a helper method to perform this request. I am going to call this method func requestImageFile. It needs to know which file we're downloading, so it will take a URL as a parameter. This is the URL we got from our previous request, and I am going to mark it as a class method because we don't need an instance of the DogAPI class in order to use it.
 
 01:57 Then from the ViewController, let's copy in our code that makes the network request. (this valid for video: For the parameter, you just called this url:. So I'll update the name of the URL passed into dataTask) VS. I kept
 
 02:13 And of course remember to call task.resume() method.
 
 02:16 Now we are at the point where we have the image data and we need to pass it back to our ViewConntroller where our method will be called. 02:23 Remember that we can't return a value from requestImageFile from mwithin data task with request closure. This is where completion handler pattern comes in. Just like dataTask with request, our requestImageFile method can take a closure OR a function as a parameter that we can pass the data to. It's up to the caller or the ViewController in our case, to determine what to do with that data. 02:48 We'll let a completion handler to our function next.
 
 02:51 Here after the URL parameter, let's add another parameter called "completionHandler", and its type is going to be a closure that returnns Void. Remember that a completionHandler will ultimately be called by another function, possibly after request image file is finished executing, so we'll need to mark it as @escaping. The parameters of the values that will get passed back to our ViewController.
 
        03:17
        1. The first one is the image of optional type UIImage.
        2. THe second is the error of optional type error.
 
 Our download may fail, so passing the error back to the ViewController allows us to respond accordingly. 03:31 And because we're using UIImage in this file, we also need to import UIKit.
 
 03:36 This is Okay so long as we're not directly modifying the View from our Model code, but in practice it may be better to not assume that our downloaded data will actually be used as an UIImage.
 
 03:49 Looking back at the completion handler, notice that I marked both of these paramaters as optional. Why is that? Well, we know that if we get image data then an error did not occur. So, the error is nil. However, if the download fails for some reason, we know we're going to have some error, but the image data will not esxist, and should be nil.
 
 
 04:11 Let's handle both the cases when we call our completion handler. Firstly, when the download is successful, we have some image data to pass back to the ViewController. So we're going to call our completion hadler down here, passing in the downloaded image for the image is nil for the error.
 
 04:31 THe else body of our guard statement is executed when an error occurs. So, we need to call our completio handler here as well. This time no image data is returned, so we pass in nil for the image, and we'll also pass in the error we received from URL session dataTask completion handler.
 
 04:48 So, we're done implementing request image file. Now, it's time to call it from our ViewController. We'll do this once we have the URL by calling DogAPI. request image file.
 
 05:11 we will pass in the URL or the imgageURL we created within the guard let. For completion handler, we receive an optional UIImage, I'll call that image as well as an error. Just like before, we'll need to add a call to async to ensure updates happen on the main thread, and set the image in the imageView. 05:35 If an error occurred, then this image will be nil, and this will have no effect. So we've moved one network requ4est out of the ViewController, but we still have a lot of indenting. Let's take care of that next.
 */

// MARK: 15. Chaining Requests Refactor Part 2

/*
 II-00:00 The socond step in refactoring our request to reduce the amount of indenting, is to create a helper method so that we can get this code that updates the UI out of the completion handler.
 
 II-00:14 I am going to add a new method to our ViewController called HandleImageFileResponse. Like the request image file methods completion handler, it will take two parameters, one for the image and one for the error.
 
 II-00:32 Inside this method, we'll move our async call that updates the ImageVIew (we just comment it out in above code). Again, I am not worried about the error case here since the imageView.iimage property can be set to nil if the call fails (click on image and can see that it can be nil because of ?).
 
 II-00:45 Remember, that the functions and closures are one and the same. So we can simplify this code by just passing our function into the completionHandler. So, I'll remove the closure we've passed in and I'll pass in self. handleImageFileResponse(image:error:). Perfect. Now, if we run our app, we can see that the random dog image is still being loaded. Our code is looking much better now but we still need to refactor the other request, the one that requests a random image URL into the DogAPI class. I am leaving this as a challenge exercise for you to complete. I've created a list of tasks below thhe video that are needed to refactor the request. 
 */

//: [Next](@next)


       
