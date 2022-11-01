//: [Previous](@previous)

import Foundation

// MARK: 16. Interview with KT JSON Parsing

// 00:00 Mark: So we've learned a lot of techniques for JSOn parsing with codable. But in the real world, there's not going to be a step by step guide every single time we make a network reqeust. When working with a new web service, is there a strategy you use to transleate the JSON response into model objects?

// 00:21 Katya: Yes. This is when reading the documentation is key. So you need to read the documentation of whatever web service or API are you using very thoroughly to make sure that you know exactly what the response is going to be and you can map your model object directly to that response.

// 00:35 If you do not read the documentation and then you miss something that's in the JSON response, your object won't be able to translate into the Codable protocol because you're missing something that you didn't read in the documentation. So that's when reading the documentation is really the number one strategy for translating those model objects.

// 00:56 Mark: That sounds like a great advice. In the next lesson, when we start working with a new API, we're going to spend a lot of time reading the documentation, and I think you'll find this invaluable in your work as an iOS developer. 

//: [Next](@next)
