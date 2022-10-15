//: [Previous](@previous)

import Foundation

// MARK: 2. The Dog API

/*
 00:00 You can find the Dog API at https://dog.ceo/dog-api/ OK so let's see what do we have here. It is the Internet's biggest collection of open-source dog pictures. And there's an example of how you can use it.
 
 // MARK: "fetching data"
 00:20 In this text fields, there's an URL for fetching a random image of a dog. And when we click on the "Fetch!" button, we can see that the image here changes. Fetch is not just a game to play with hour dog, but you'll often hear the term of "fetching data" when talking about a network request. Try fetching an image a few times and it keeps changin.
 
 
00:40 There's also this response here which changes every time we fetch image:

    MARK: JSON
    {
        "message": "https://images.dog.ceo/breeds/malinois/n02105162_5706.jpg",
        "status": "success"
    }

 Now, the format is new but you can still make out some of what's going on. Looks like there's a status that tells us the request was successful and a message that contain the URL of the image that go loaded. So this must be the response from the "fetch".
 
 01:04 The format of this data is called JSON (JavaScript Object Notation). You don't need to know anything about JSON quite yet, except that it's a format for exchanging data between our app and service, such as the Dog API. By the end of this lesson, we'll request and ue this JSON response in an iOS app.
 
 01:21 Now, let's click on the documentation to find out what else this web service has to offer. You have alrady seen Apple's documentation which provides a complete list of functionality available to iOS developers. Web services like the Dog API have documentation as well.
 
 01:37 Here is the section called Endpoints, that word is also new to us // MARK: Endpoints https://dog.ceo/dog-api/documentation/
 
 If we look at the options we can see that it lists different types of tasks, like:
 
    - List all breeds https://dog.ceo/api/breeds/list/all
    - Random image https://dog.ceo/api/breeds/image/random
    - Random images by breed
    - Random images by sub-breed
 
 01:54 Every Endpoint has a URL or convention for forming the URL. Note that they all start with "dog.ceo/api". Then, to list all the breeds, its "breeds/list/all" that's added to the base URL. https://dog.ceo/api/breeds/list/all
 
 02:09 To get a random image, it offers to press Fetch! button for link: https://dog.ceo/api/breeds/image/random
 
 02:13 Those two are always the same. However, some of these are also cusomizable. If we wanted to get the image for a specific kind of breed like hound, we'd also need a URL that has the word hound in it, like breed/hound/images. 02:30 If we wanted to get images for a different breed like Beagle, we'd substitute Beagle here where it says hound.
 
        https://dog.ceo/api/breed/hound/images
        https://dog.ceo/api/breed/...../images
 
 02:38 Remember how we dynamicall built URLs in the prerevious lesson? This is quite useful when working with APIs. These Endpoints are simply components of the URLs, we'll use when making our requests.
 
 02:51 The last thing I want you to look at is how much it costs to use the Dog API. Go to bottom of site and can see:
 
    "Sorry for running ads but hosting is expensive :(
    If you're feeling generous you can buy us some dog treats" ***
 
 03:01 Basically it says that the site pays for itself with advertisements, *** but we can also contribute. I am going to click on the "buy us some dog treats" button. And cool, hre is a form I can use to template developer. The Dog API is a small service that doesn't require us to sign up or anything to get started, which makes it a perferct API for us to start with, which leads me to an imporant question. I said that we will be workig with web services, and here this thing is calling itsel an API. MARK: Why is it the Dog API and not the Dog web service? Let's get clear on those terms next. 
 */

//: [Next](@next)
