//: [Previous](@previous)

import Foundation

/*
 // MARK: 9. HTTP Request and Response
 00:00 OK so we have sent an HTTP request and gotten HTTP response. Postman's user interface made this very straightforward and organized all the information into our fields like the body, headers, status, time, and size. Well this is a very helpful way to look at responses.
 
 00:20 It is also up to knowing what the raw request and response look like, and what they contain. It turns out that HTTP requests and responses are sent as specially formated text. Both start with a single line that provides just enough information to read the remainder of the message.
 
 // MARK: 0:40 For request, the start line includes:
   - the "HTTP verb" describing the type of request
   - the "endpoint" or everything that comes after the host, and
   - the "HTTP version", so that the server can understand the request and respond appropriatelly
   - the "headers" ... then, comes additional information about the request called "headers", which include information such as the host name. If data called a body is sent along with the URL, for example, the size this data would also be included in a header.
    - the "blank line" - whether or not data is sent with request a new line follows.
    - the "Body"... and if data is sent, this is contained in the body, which comes last.
 
 // MARK: 1:30 For responses, the start line includes:
    - the "HTTP version"
    - the "status code" indicating success or failure
    - the "status text", short description of the status code
    - the "headers" like a Request, after this initial line come "headers" containing additional metadata about the response.
    - the "blank line" = again comes a new line
    - the "Body"... followed by the body of the response containing the data we wanted to retrive.
 
 1:58 When we asked Postman to get udacity.com/ios, the request that is created actually looks like this. You can see the startline followed by ... headers and a blank line, and this request did not include a body.
 
 GET /ios HTTP/1.1
 Host: udacity.com
 Cache-Control: no-cache
 Postman-Token: a6fef620-0793-418d-9bd7-cc23bd030432
 
 2:15 And the response folllows similar format. In this response you can see the startline, followed by headers and a blank line, as well as the body containing the HTML of the Udacity hopepage truncated here for brevity.
 
 HTTP/1.1 200 K
 KEY: VALUE ... can see this in Postman under list named "Headers"
 Date: Thu,...
 Content-Type: text/html
 ...
 
 Body... can see this in Postman under list named "Body"
 
 MARK: Note: not any more divided by blank line, instead Headers and Body are in two different lists.
 
 02:34 Do not worry if many of these headers don't make much sense. At this point it is enough to know that sometimes HTTP messages include headers that help the receiver to understand both read message overall and any included body.
 
 2:47 Now if this looks like just a lot of text, you'd be right. Thankfully, we'll never generate our requests manually. Just as we do in Postman, we will give Swift just a few key pieces of information and will drop messages for us, but this is in fact what Swift is doing behind the scenes on our behalf.
 */

/*
 To understand the format of headers and responses, send a request to: https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Swift_logo.svg/40px-Swift_logo.svg.png
 
 in Postman (use GET) and then answer the following questions.
 
 // MARK: 1. Check the "Headers" tab of the response in Postman. What is the Content-Length?
 1251
 
 // MARK: 2. According to the headers, what is the Content-Type?
 image/png
 
 // MARK: 3. What is the first line of the GET request sent to the server (upload.wikimedia.org)
 ???
 
 */





//: [Next](@next)
