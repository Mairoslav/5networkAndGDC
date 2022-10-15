//: [Previous](@previous)

import Foundation

// MARK: 4. An App Idea

/*
 Let's see how we would use the Dog API to build an app - https://dog.ceo/dog-api/
 There is a demo app on the Dog API website... could not find it, the site has been changed vs what is in lesson
 */

/*
 Something Simpler
 It looks pretty cool—you can pick a breed of dog, then see an photo of a dog from that breed. And you can request more photos if you want. Let's keep this in mind as our end goal.

 But first, let's start by making a simpler app that can be a waypoint on our way to building out the app with all those features.

 We can start with a first goal of getting a random dog image into the image view:
 */

/*
 Features
 For now we won't worry about making the image dependent on breed.

 Let's just focus on requesting a single image, which will require handling the back-and-forth for a single endpoint. Once we have those basics down, we can update the app to build out the breed list selection feature.

 Alright, so we know we're going to need to make an API call to get a random image from any breed. Look through the Dog API Documentation: https://dog.ceo/dog-api/documentation/. Can you find an endpoint that meets our needs? It is under ENDPOINTS/RANDOM IMAGE, That's it! We can get a random image from the full collection of dog images at https://dog.ceo/api/breeds/image/random.
 */

//: [Next](@next)
