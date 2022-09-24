import UIKit

// MARK: 1. Intro
// MARK: 2. 2. Interview with Kaya Thomas: Getting Started
/*
 let's begin with understanding the basics. Two most basic networking HTTP requests which are:
 
    1. Get: about receiving data from some type of API, or networking call ...
    2. Post: about sending data
 
 So above two are most essential networking requests.
 */

// MARK: 3. How Apps Get Data
/*
 Key Terms
    Client: The computer .Requesting the resource (ME MYSELF)
    Server: The computer that .Handles network requests / is providing resource (UDACITY)
 
 1:05 Now how does a client connects to a server? This is where the web address comes in. You type URL:
 
    URL: Uniform Resource Locator
 
 And the way these computers communicate is through HTTP
 
    HTTP: HyperText Transfer Protocol
 */

// MARK: 4. Postman
// MARK: 5. Using Postman
/*
 00:00 To show you what's happening behind the scenes, I am going to use postman app to (a -> B) make network requests and (B -> a) inspect the results that come back.
 
 I'll select Network Request and I'am prompted to save it for later - I just click cancel for now. And here we are - on screen is field to write in "Enter request URL".
 
 0:20 And here we are. On the left here, there is a pane that shows history, monitors, mock servers, environsments, APIs, Collections. We do not have any history... so I am just going to hide this pane with the toggle at the bottom - the same icon is used for the same purspose also in Xcode.
 
 At the top, there is a text field where you can ennter a URL much like we did in a web browser. 00:37 Using the drop down to the lef of it, we can also specify the type of HTTP request - GET, POST, PUT, PATCH... . There are quite few types of HTTP requests also called HTTP verbs. For now I will leave it as the default which is GET.
 
 00:55 There is also a section below here for customizing the request further (list named "Authorization"). We are going to skip this now, and just make a basic request. When you need to customize further, just know that Postman has a lot of options to configure.
 
 01:12 And below this, there is a big blank area for the response - "Response Area" that we want to get back.
 
 1:17 OK back at the top, let's type in the URL for the iOS Nanodegree program "udacity.com/ios" and hit SEND button and wow, the Response Area fills up with the text. Let's see what we have got.
 
 1:28 The first tab here is the body. This is the iOS Nanodegree landing page. Even though it does not look anything like what you see in the browser, this is just a code, the Raw HTML, CSS and JavaScript that make up the web-page. Normaly a web browser loads, interprets and renders the page. Postman cannot do that. But if we click on the PREVIEW button here, we can see a really simplified version of what this would look like in a web browser.
 
 1:58 Next let's look at some of the important information that Postman pulls out here to the right. Here it says, Status 200 OK. This is what is known as the "Status Code". It indicates whether the HTTP request succeeded, failed or something else like got redirected to different URL. There are many different possible status codes that could get returned for an HTTP request. If you hover over it, you get a more information.
 
 2:30 We will go over different types of status code shortly, but for now let's see what else there is here. Because we used the GET request, we are seeing the the entity that corresponds to the requested resource, which in this case was the iOS Nanodegree landing page.
 
 2:45 Also at the bottom of this description, it mentions a new type of request which is a POST request, which we will talk about later in this course.
 
 2:55 Next up is the time it took to execute our request in miliseconds. This is important to keep in mind. When we make requests over the network, it can take a varying amount of time to get a response. It is not instantaneous. So we will have to consider what we want our app to do while it's waiting for response.
 
 3:15 Now let's try a different URL, this time for a page that I know does not exist e.g. "google.com/nonExistentSiteTest". I'll hit SEND button and we still get a response, but notice this new status code, "404 not found". If we hover over the Status Code it says "The requested resource could not be found". Anytime we see a status code in the four or five hundreds, it indicates some kind of error. Even though we have an error, we still get a response and this response happens to include a body. On the PREVIEW page/list it is just a page that says: "The requested resource could not be found".
 
 3:56 OK, I have one more example. This time let's request to single image. Instead of whole web-page, this is the request we'll make when we build our first networked app. I am goig to paste the URL for a .jpeg of a wolf here and hit SEND button. You can find the URL for wolf .jpg here: https://cdn.pixabay.com/photo/2020/07/01/17/34/wolf-5360340_1280.jpg
 
 4:18 This time we get an image in the response body. The request was successful so we get 200 OK here and we can see how long time in ms did it took.
 
 2:29 Let's also take look at a header tab. Headers contain metadata about the response and here we can see that it its Contents-Type (indicates the resource's media type) is "image/jpeg". Take a few minutes to experinment with different URLs in Postman and see what responses you get. Then come back and let's take a closer look at all the moving parts we have seen including:
        - URLs           : Uniform Resource Locator(s)
        - status codes   : Status 200 OK, 404 not found...
        - HTTP verbs     : GET, POST, PUT, PATCH...
 */

// MARK: 6. Anatomy of a URL
/*
 We just used a URL to load a website "http://classroom.udacity.com/nanodegrees/nd003/".
 
    - The beggining part "http://" (http, column, double-slash)
    - "classroom.udacity.com"
    - "/nanodegrees/nd003/" and everything that follows it
 
 00:19 Let's check each of these parts in more detail:
 
    1. SCHEME "http://" this is the scheme that specifies how the communication will happen. HTTP is a protocol or a set of rules for how the two computers should talk to each other. When your browser sees http followed by colon double slash, it creates a HTTP request, which is a request for Internet content. 00:47 They got some other schemes for other purposes, like:
            - "https" for secure communication
            - "mailto" for including email addresses in webpages, or
            - "tel" for phone numbers
            note: We will only be using "http" and its secure variant "https" in this course but URLs are used for more that just network resources.
 
    2. HOST "classroom.udacity.com" is the host address. This part gets our request to the right computer. 01:20 Now we call it an address but it's really more like a name. 1:26 There is a numerical literacy for every computer called an IP address. Which is a String of numbers separated by periods/dots e.g.: IP address 52.84.146.241 But this gets looked up for us by something called a Domain Name Server or DNS, so we do not have to think about it. We can just send the request to a name and the DNS will help determine the actual IP address.
 
    3. PATH 1:46 "/nanodegrees/nd003/": in our case this is the path to the iOS nanodegree program, which can optionally be followed by additional information called queries to load certain lessons and pages in the course. This part of the path is knows as an endpoint. If we were to leave the path off, we just get to the Udacity classroom homepage.
 
 2:11 To sum up this URL happens to contain three parts: Scheme, Host, Path. These are not the only three possibilities. URLs can contain a scheme, user, password, host, port, path, queries, and fragment.
 
 scheme:[//[user[:password]@]host[:port][/path][?query][=+-_)0)9([/?.>,,lL;;''\|]}[#fragment]
 
 But not all are required to to build a valid URL. For the most part, we'll mainly be using the scheme, host, path as query, but just know that URL can contain a lot more information for making a request.
 */

/*
 MARK: quiz question_1:
 Correct – You got it!
    https://    is the scheme,
    swift.org   is the host, and
    /about/     is the path.
 */

/*
 MARK: quiz question_2:
 Arrange the following URL components in the order in which they appear in a URL
    yes scheme, user, password, host, port, path, queries, and fragment.
 */

/*
 MARK: quiz question_3:
 Given the following components, build the URL:
    
    Scheme: https (remember :// after the scheme)
    Host: www.google.com
    Path: search
    Query: ?query=udacity
 
 Yes, simply concatenate the scheme, host, path, and query and the resulting URL is https://www.google.com/search?query=udacity.
 */

// MARK: 7. Status Codes

/*
 Video 00:00 As we saw in a Postman, when making an HTTP request we get an HTTP response, that includes a "Status Code" indicating either success or error. There are many HTTP Status Codes, but they all fit different categories, and each has a description of the Status Code. Here are few common HTTP Status Codes.
 
 00:30 Status codes
 Check out the MDN web documentation for more information on specific status codes.

 // MARK: Status Code  Short Description         Category
 // MARK: 100          Continue                  Information
 Any status code in the 100s is know as information response. Information Status Codes update the clients that the request is being processed as expected but the request is not necessarily complete.
 
 // MARK: 200          OK                        Success
 Status Code 200 is returnted if a request succeeds. Any Status Code in the 200s indicates a successful request.
 
 // MARK: 301          Moved Permanently         Redirection
 Status Code 301 Moved Permanently tells the clients that the resource has been moved to a different URL. You may not have encountered 300 status codes before, as typically the response from the server includes the new URL of the resource. Simply, this is what happens when a browser redirects you to another page.
 
 // MARK: 403          Forbidden                 Client Error
 Status Codes 400 indicates that someting was wrong with the client's request. For example 403 Forbidden is returned if the client does not hape permission to access a requested resource.
 
 // MARK: 404          Not Found                 Client Error
 Status Code 404 if the requested resource could not be found.
 
 // MARK: 418          I'm a teapot              Client Error
 And there are many other status codes such as 418 I'm a teapot and yes this was real status code that made it into the HTTP spec.
 
 // MARK: 500          Internal Server Error     Server Error
 Finally, Status Codes in the 500s occur if there is a problem with the server. For example, status code 500 stands for internal server error. You can find examples of each of these and many more status codes in the links below.
 
 https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
 
 02:05 We generate hopeful responses in the 200s which indicates success. However when we do get error responses back, we can see it at glance whether that problem was on the client side, for 400s. Or the server side, for 500s. And that is helpful information.
 
 02:23 Specific Status Codes will become familiar as you work with them. For now it's enough to focus on understanding the different categories of status codes.
 */


