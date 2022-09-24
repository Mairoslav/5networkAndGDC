//: [Previous](@previous)

import Foundation

// MARK: 8. HTTP Verbs
/*
 Check out the MDN web docs for more on different HTTP verbs.
 
 https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods
 
 00:00 HTTP verbs are also known as HTTP methods. In order to avoid confusion with Swift methods, we will refer to them as HTTP verbs in this course.
 
 00:15 HTTP verbs allow us to perform different operations with data on the server just like they were different actions you perform in your app.
 
 00:23 Basic operations on a website or database fall under the acronym CRUD, which stands for:
        C - Create
        R - Read
        U - Update - Replace/Modify
        D - Delete
 
 So far we have only seen examples of reading (R) from the server such as fetching an entire web page or an image, but going forward, we want to be able to also write (C) to and update (U) the data on the server.
 
 00:45 We'll use the following HTTP verbs to create HTTP requests specific to each kind of task.
 
 // MARK: HTTP Verb     CRUD Operation
 
 // MARK: POST          Create (C)
 But sometimes, we want the clients to send its own data to be stored on the server. In that case we use POST request, which is Create (C) operation.
 
 // MARK: GET           Read (R)
 GET requests like we have seen already in the Postman, retrieved data stored on the server, this is a READ operation.
 
 // MARK: PUT           Update (U) / Replace
 A PUT request is similar to a POST request in structure but instead of sending new data, a PUT request is meant to update existing data that has already been posted on a server.
 
 // MARK: PATCH         Update (U) / Modify
 01:30 Similarly, a PATCH request is also used to update data but only specific parts, while with a PUT request we updated/replaced all the previously posted data. But with PATCH request, we can specify which part of the data to modify without updading/replacing the whole thing. Both PUT and PATCH requests  are Update (U) operations.
 
 // MARK: DELETE        Delete (D)
 01:58 Finally, delete removes data from the server and of course, this is a Delete (D) operation.
 */

// 02:00 There were other HTTP verbs, but there are the most common you'll encounter when making network requests in iOS apps. We'll start by working with GET requests and then use other HTTP verbs later in the course.

// MARK: QUIZ_1
// Above are the correct matches.
// Correct – Right on! HTTP verbs can do more than fetch webpages. They can also add, update, and remove resources on a server.

// MARK: QUIZ_2
// Consider the example of a social media app like Facebook. Match the user interaction with its appropriate HTTP Verb.
/*
 // MARK: HTTP Verb     CRUD Operation
 
 // MARK: POST          Create (C)
                        Add a new friend
 
 // MARK: GET           Read (R)
                        Show a user's public posts
 
 // MARK: PUT           Update (U) / Replace
                        Edit an entire post
 
 // MARK: PATCH         Update (U) / Modify
                        Change only the status message of the public profile
 
 // MARK: DELETE        Delete (D)
                        Remove a post
 
 Perfect! Real-world user interactions in an app can be described by different HTTP verbs.
 */

//: [Next](@next)
