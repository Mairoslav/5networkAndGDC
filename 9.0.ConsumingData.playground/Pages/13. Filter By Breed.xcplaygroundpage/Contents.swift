//: [Previous](@previous)

import Foundation

// MARK: 13. Filter By Breed

// 00:00 We're all set up with a functioning pickerView and we even have some hard-coded dog breeds. Now we need to modify the request so that we can request an image of a certain breed.
// 00:12 This URL here "https://dog.ceo/api/breed/bulldog/images/random" gives us a random image of a breed.
// 00:16 We have "malinois" passed into the URL. NOTE: in newer version what breed is randomly passed in is not visible in link, only is displayed as image.
// 00:24 I'll add a new "case" and we'll call it "randomImageForBreed" equal to the URL which we can copy from the documentation - note had to adjust it because in newer version what breed is randomly passed in is not visible in link, only is displayed as image. As a breed I limit it to randomimages within "malinois" breed.
// 00:35 Now this works. But keep in mind that it can only fetch the images of a malinois. What we really wannt is to construct a URL for any breed that we give it. This is a lot like what you may have seen associated values used for. We have enum cases that given some information can generate their values. In this case, we'd supply a breed and use String interpolation to build the URL. 00:59 Even with/so associated values cannot have a raw value.
// 01:02 So I am going to remove String here *** (after enum Endpoint), instead let's create a computed property. I'll call it stringValue, see few lines below. We'll switch on self which is whatever the enum case happens to be.
// 01:16 Now instead of specifying the URL from "randomImageFromAllDogsCollection" let's handle that specific case and we can return the URL.
// 01:25 Now for "randomImageForBreed" this is where using the associated value comes in. We can specify a parameter of type String - (adding (String) after "randomImageForBreed"). This String is going to be the dog breed.
// 01:36 Now we'll add a case for random image for breed and place let breed inside the parentheses.
// 01:45 Like before, instead of specifying the URL up here (now " = "https://dog.ceo/api/breed/malinois/images/random" commented out ), let's return it from our enum case.
// 01:50 Now this URL is still stacit with "malinois as the breed. But whenever we use this enum case, we need to specify a String which is the breed to fetch. So using String interpolation, instead of the "malinois" let's pass in the breed.
// 02:07 Finally, since the raw value was no longer a String, we need to update the URL property to convert "self.stringValue" into the URL, and there we go.

// 02:18 We have a way to generate the randomImage URL that takes a dog breed as part of the path. Now you certainly don't have to build the URLs in this way, but using associated values you can generate URLs based on some value like a dog breed without making a case for each URL and that makes your code much more readable.
// 02:38 Let's modify our image request to use the new "randomImageForBreed" URL. Here in func "requestRandomImage" we will add a String parameter called "breed" and instead of fetching a random image for all breeds i.e. "randomImageFromAllDogsCollectio", let's use "randomImageForBreed" case, passing in the "breed" as the associated value.

/// from here not in project...
// 02:57 All right. So we're almost done. We just need to modify where we can call this method to provide the breed. In didSelectRow and component (switch to ViewController.swift file), let's fill in the breed parameter. We'll get this from the breeds Array at the row that was just selected. Cool. So in our pickerView data source and delegate are fully implemented and we can now get a randomimage just specifying the dog breed.
// 03:21 But we're still using hard coded values for dog breeds up here (see up "let breeds: ["malinois", "poodle"]). With everything setup, let's finish implementing the breeds list feature by using our JSON parsing knowledge to get a list of breeds from theh dogAPI.

//: [Next](@next)
