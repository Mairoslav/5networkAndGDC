//: [Previous](@previous)

import Foundation

/*
 // MARK: Interview with Kaya Thomas:
 
 00:00 So we have talked a lot about HTTP networking, and it sounds like there is a lot of concepts and terminology to absorb. Looking back at your experience first learning iOS networking, do you have any tips we can use as we translate this knowledge into Swift?
 
 00:15 Sure a lot of the parts of HTTP networking are in relation to the actual URLs you're going to use to make a request, and as you look at all of the different components of the URLs, what's really important is making sure to separate those into different Strig variables.
 
 00:35 A lot of times you are going to reuse those components, so it's great to have them separated, instead of all in one variable.
 */

// MARK: TEx`T under the Video:
/*
 You just saw a lot of terminology related to networking. Before we start working with URLs in Swift, take a moment to look over the list and go back in the lesson if anything is unclear.

 // MARK: Networking Terms
    - Data: (Usually in the raw form) anything that is sent over the network.
    - Client:
    - Server:
    - HTTP: Hypertext Transfer Protocol
    - HTTPS: HTTP Secure
 
 // MARK: Requests and Responses
 A HTTP response consists of a body and a status code.

    - Body: Content of a response (such as the HTML that makes up a webpage
    - Status code: 3 digit number signaling the type of response (success, failure, etc.)
 (note about what is sent as part of a request?)

 // MARK: HTTP Verbs
 HTTP verbs, also known as methods correspond to the different types of network requests.

    - GET: Retrieves data from the server, such as getting a list of search results.
    - POST: Submits data to be stored in the server, such as when submitting a form.
    - PUT: Updates data on the server, replacing the old data with the new data.
    - PATCH: Updates data on the server, by changing specific values.
    - DELETE: Used when removing data from the server.
 
 // MARK: HTTP Status Codes
 HTTP status codes fall into 5 ranges based on the type of response.

    - 100: Informational response (request has been received by the server but is not finished yet)
    - 200: Successful response (request has been processed and completed by the server)
    - 300: Redirection (client needs to do something to complete the request)
    - 400: Unsuccessful (problem with the client's request)
    - 500: Unsuccessful (problem with the server)
 
 A complete list of status codes can be found here: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
 */

//: [Next](@next)
