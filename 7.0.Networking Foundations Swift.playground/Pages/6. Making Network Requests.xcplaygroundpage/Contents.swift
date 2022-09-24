//: [Previous](@previous)

// MARK: 6. Making Network Requests

import Foundation

// 00:00 It's time we finally make our first network request. As we planed, lets' go out and retrieve an image and then show it in our app. Let's create a new single view application which we can call ImageRequest. In WiewController.swift I am going to clean up the left side here just a bit to conform just a bit to conform to Model View Controller (MVC) arthitecture. So that it's a bit more organized.

// 00:25 I am going to group ** the Main.storyboard and the Assets.xcassets (and note that he also has chosen LaunchScreen.storyboard), into the View, and the other files into the Controller Group.

        // *two finger click on file named ImageRequest (name of the project) and choose new group, so can create new groups/subFiles named Model, View and Controller

// 00:39 Next swith to the Main.storyboard and we're  going to need two UI elements:
    
        // 1. button to press to initiate the image load, and
        // 2. then an image view to hold the image

// 00:50 Let's add a button with the text Load Image, and center it horizontally and verticaly in Safe Area of screen - click + control + drag to any place within safe area and table with contraints options and centering do appear + also note that when I click on option alternative options do appear, I can choose multiple otpions with command + clicks. The bottom might stay at current position with horizontal and vertical center highlighted > just click on warning and choose fix misplacement issue.

// 00:58 We also need an image view, I am going to drag this (UIIvameView) over and by dragging it wider I give it the default margins as designated by the blue linnes shown by Xcode. And I am also going to add constraints to each side of the ImageView, even though after drag-widening of UIImageView the constraints are as follows:

/*
            0
        16      16
            0
 
 still I have to click on line segments so that they all four become red > click add 4 constraints.
 */

// 01:13 Finally, so our image is distorted, we'll set its content mode to Aspect Fit in Attributes Inspector/View/ContentMode/AspectFit.

// 01:20 Now, to hook these up to view controller, let's open the Assistant Editor and create an image view outlet for the ImageView.
// 01:29 An an IBActioin for the button.

/*
 01:37 We can then close the Assistant Editor and focus on the code. Now we are going to watch to load an image from a URL. I have provided three URL strings below the video, one http, one https and one string that isn't a real URL, so that we can test what happens if we have a typo or a bad URL. 01:59 We are going to be fetching an image of a kitten. So, let's store these in an enum called KittenImageLocation of type String. For now let's just put this enum above the class ViewController: UIViewController.
 
 02:14 Now inside the viewController: UIViewController class right below the imageView outlet, let's create an image location String constant, so that we can easily change which of these values we're working with. I'll set it equal to the HTTP rawValue for now.
 */

/*
 02:30 So, we know the address of the image we want to retrieve (thanks to let imageLocation = KittenImageLocation.http.rawValue). And we know we're going o use HTTP to get it, which means we have two steps:
 
        1. creating and sending off the HTTP request, and
        2. receiving and handling the HTTP response
 
 It is time to set the whole thing in motion. It is going to be our actions' job to turn that String into a URL and then go out and try to fetch the resource at that URL. 02:55 We know the address of the image we want to retrieve. So our 1st task is to convert it into a URL. That might succeed or fail, so we're going to use a guard statements, and if we can't create the URL, let's print an error to the connsole and exit early 03:05.
 
 At this point we have an unwrapped URL. 03:13 Next, we need to create the HTTP get request to fetch the image from this URL. We do this by creating a URLSessionDataTask.... let task = URLSessiondataTask ... You might be tempted to instantiate it directly, but as the name suggests, the task needs to be associated with a URL session.
 
 For now, we can use the URLSession.shared singleton, and so I'll pick the nethod for creating a DataTask that takes a URL and a completion handler as parameters. Time will pass between when we send the request and when we receive the response, so passing in a closure allows us to specify what code should run when the response does come.
 
 03:55 The URL is going to be the image URL we just created, and for the completion handler, because it is the last parameter, we can use trailing closure syntax and specify the three parameters: data, response and error, and we have the in keyword to signal that this is the code that we want to execute. Great, so now the DataTask will load any data we successfufllyfetch right into memory. But watch out, it seems like we have kicked off the task, but remember that when you create a DataTask, it starts in a suspennded state. So, in order to actually run the task, you need to call task.resume(). Now, we can be sure that the task will actually run. At this point, we could run our app and it would send off an HTTP request, but we're not handling the response yet, so let's hold off.
 
 04:49 We specified a completion handler or a closure that should be executed to handle a response. Let's implement it to check whether or not we got data back, and if we did, convert it to a UIImage and then update the UI. If the request was not successfull, let's exit early using guard. We can do this by ensuring that we got data back, and if not, that means an error occured. Below the guard, we know that we do have data. So let's try using it to create a UIImage.
 
 05:20 Now, this will return an optional, but that's totally OK, because we consider ImageViews image to either an image or nil, so we do not need to unwrap this. Once we do have the downloaded image, we can set it in the ImageView, and because we're using a closure, I'll need to use self, and we're going to set the image property to the downloaded image.
 
 05:44 OK, so our DataTask is ready to go. Let's run it and test, we see our Loadimage button on the screen, and if I press it, hmm hothing, that's not what we expected but it looks like our console output exploded. Let's expand it to see what it has to say. Hemmm Interestning. It says "App Transport Security has blocked a clear text HTTP resource load since it is incesure. Temporary exceptions can be configured in your apps info.P list file". What does this mean? Well, it means that we're trying to retrieve data using the older HTTP protocol of the newer and safer HTTPS protocol.
 
 06:32 We know that we should use HTTPS if at all possible, but the reality is some servers still use HTTP. Apple does make it possible for us to load data from select HTTP connections, but the dafault security settings only allow secured connections over HTTPS.
 */

/*
 MARK: quiz1: What are the data types of the values passed back by the dataTask method's completion handler?
 
 Correct answer is: Data?, URLRespponse?, Error?
 Correct! The dataTask method passed back 3 values, all of which are optional - Data?, URLResponse?, and Error?.
 */

/*
 MARK: text under the video
 Why use an enum for URLs?
 Previously, we stored the different parts of the URL in a struct. Now we're storing URLs in an enum. Do we have to use one or another?

 Not really. You could use an enum like we did here.
 */

enum X: String {
    case http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
    case https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
    case error = "not a url"
}

// Or a struct...

struct XX {
    static let http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
    static let https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
    static let error = "not a url"
}

// Or a class...

class XXX {
    static let http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
    static let https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
    static let error = "not a url"
}

// Or even just constants by themselves...

let http = "http://www.kittenswhiskers.com/wp-content/uploads/sites/23/2014/02/Kitten-playing-with-yarn.jpg"
let https = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Kitten_in_Rizal_Park%2C_Manila.jpg/460px-Kitten_in_Rizal_Park%2C_Manila.jpg"
let error = "not a url"

/*
 We've already grouped the related parts of URLs into structs. But for enums, there are some additional benefits for what we're doing here:

    1. Enums store related values (cases) of the same thing. In our case, that thing is the URL we need to fetch.
 
    2. Enum cases work well with switch statements. If you handle one case (url) then the Swift compiler makes you handle all of them. You may have seen this when using associated values, which will come in handy for URLs (hint hint).
 
 So any of these are possibilities, and you may see each of them in production code, but the goal in this course is to use a clean networking architecture, incorporating best practices without adding too much complexity.
 */

//: [Next](@next)
