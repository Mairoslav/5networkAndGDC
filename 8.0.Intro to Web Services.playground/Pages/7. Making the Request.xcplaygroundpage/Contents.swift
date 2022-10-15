//: [Previous](@previous)

import Foundation

// MARK: 7. Making the Request

/*
 00:00 So we have our UI ready with an Image-View and we stored the endpoints in a dog API. Our next task is to make the HTTP request to that endpoint and to see what data we got back. Instead of just printing the URL, let's sote it in a constant instead. You can name the constant randomimageEndpoint.
 
 00:25 Now the remaining tasks are very similar to the stepts we already took when requewsting a static resource. We'll create a URL session data task and handle the response. We can use the shared URL sessioin for this. So, we'll set the task equal to URLSession.shared and choose the dataTask method with the URL and completion handler parameters. We can pass in our randomImageEndpoint for the URL, and then for the completion handler, if we double-click on parameter list, we can turn this into trailing closure syntax 00:58. This makes it much easier to just tab through and rename the parameters: data, response and error.
 
 01:12 Then to fill in the code that we want to run when the handler is called. This completion handler passes in a closure or a function. When the app receives a response from the server, the completion handler will be called. The dataTask method or URLSession task has no idea what we want to do with the data once it's been received. So, we tell it twhat code should be run when the request is complete. 01:35 The response is either the data we got back or an error. So, we need to figure out what kind of response we got. Let's use a guard statement to confirm that the data we got is not nil. We'll write, guard let data equals data else, we don't have the data we wanted and we can return from this function immediately.
 
 01:58 After the guard, we know that we do have data. So, let's print it out to see what's in here.
 
 02:02 Last but not least, do not forget to call task.resume(). Since tasks are created in a suspended state, we have to call .resume() to kick them off. OK, so let's run it and it's a 102 bytes. Hmmm, what's that? Is that an image file? Well, not yet. If you remember from looking at the documentation (02:24), 
 
 
 */

//: [Next](@next)
