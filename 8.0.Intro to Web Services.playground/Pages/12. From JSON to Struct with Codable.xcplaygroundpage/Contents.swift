//: [Previous](@previous)

import Foundation

// MARK: 12. From JSON to Struct with Codable

/*
 00:00 Previously, we converted the raw JSON data into a dictionary, allowing us to retrieve individual values. As we'll be working with ore complex JSON later, let's take the time now to refractor our code, to use the Codable protocol and convert our JSON into a struct.
 
 00:20 First off, let's create a new swift file under the model group and call it DogImage.swift.
 
 00:28 As we'll define a struct called DogImage, the successful response we get from the DogAPI consists of two values: status and message, both being of String type. A String containing the URL of the DogImage.
 
 00:45 To convert JSON into an instance of our struct, DogImage will need to conform to the Codable protocol. Let's add that up here.
 
 00:55 String conforms to Codeable, so that makes our work super easy, since all the properties are already Codeable. Our struct doesn't have to do anything more. We'll explore Codable in more detail after this example, but for now, let's see how we can instantiate our DogImage struct from the JSON data.
 
 01:13 To do this, we'll use a JSON decoder. A JSON decoder's whole job is to take JSON and turn it into another type, such as a struct.
 
 01:24 Here we can create a JSON decoder using its initializer, which does not require any parameters.
 01:30 Now we are going to create an instance of the DogImage struct. So I am going to create a new constant. This constant will use type inference to become of type DogImage in a moment. Now I'll call the decoder's decode function. It takes two parameters, 1. a type to decode into and 2. the data that it should decode from.
 01:55 For the 1. type I'll pass in DogImage.self. Here, self just means we're referring to the definition of the DogImage structs we just created, not an instance of the struct.
 02:06 For the from data, I'll pass in the "data" we've unwrapped, and know they exist, the bytes representing our JSON response.
 02:14 And the compiler is remindi me that this call can throw an error. You've already seen how we handled errors, with JSON serialization. 02:23 So, for now I'll just disable error propagation with try exclamation point. This is not something we should do in a production app but we'll discuss more about what to do when an error occurs later in the course.
 02:34 And that's it, our data will be decoded into an instance of the DogImage struct. With just these two steps to create the decoder, hence to decoe it into a custom type.
 02:44 THe kye difference here, between using JSON decoder and JSON's serialization, is that our networking code doesn't have to extract each property from the JSON. THe response is just converted into an instance of DogImage.
 02:58 Let's print the imageData that got parsed and see what it says. ... ... ... And we'll run it and it's cool. We have a DogImage struct, which contains:
        status: "success",
        message: "https://images.dog.ceo/breeds/..." the URL of the DogImage
 03:15 Note that whatever our JSON object contains, so long as our struct properties are the same as the keys, JSON decoder will corretly parse the data. There's no need to pull individual values out of a dictionary. Our data is parsed directly into our own model object. Like before, the messasge only contains the URL of the image, which means we don't have the imageData yet. In order to get it we need to make another network request. Fortunately, we've done this before, so that should be pretty straighforward. When you are ready let's do it. 
 
 */

/*
 MARK: QUIZ QUESTION

 You've already used URLSession to fetch an image. It's time to get some more practice making a request. Now that we have a "DogImage" struct containing a "message", (the image's URL), add code ...starting below the parsing code... to fetch the image and display it in the image view.
 
    a) Create a constant that stores "message" property of "imageData". You'll need to convert it to a "URL" to make the request.
 
    b) Create a "URLSessionDataTask" to download the image.
 
    c) Convert the downloaded data into a "UIImage". Check for errors as appropriate.
 
    d) Set the image view to display this image. Be sure to use the main thread!
 
 */

//: [Next](@next)
