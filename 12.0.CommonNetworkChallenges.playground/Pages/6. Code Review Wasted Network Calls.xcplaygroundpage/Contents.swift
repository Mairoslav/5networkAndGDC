//: [Previous](@previous)

import Foundation

// MARK: 6. Code Review: Wasted Network Calls
// see comments also in "TheMovieManager17.xcodeproj"

// 00:00 Ludwig: So we've seen how we can show the user that the app is using the network. Because data is limited, our apps should be transparent about how the're using the user's network resources. Similarly, we should also make sure we're only downloading data that we need to. Looking back to the movie manager app, are there any places where we're making unnecessary network requests? An if so, what can we do about it?

// 00:29 Lin: We actually have an interesting case here with the search feature. Again this is best observed with a slow connection such as with the network link conditioner. I have a profile set to very bad network. I can start typing as I search for the movie. The results should update each time the text changes. Now because this is low connection, the search results update slower than expected. But after typing the name, the search results will keep updating and keep updating again. Now it's doing this every time the text changes.

// 00:57 Updating the serach results as the user types was meant to make app feel fast and responsive. But on our slower connection, the opposite's happening. What happens with the search feature is not the intended user experience. Not only the users have to wait for the updated search results, but the app makes many number of requests that are not actually needed.

// 01:16 It would be really great if there was a way to cancel a data task to not waste network resources.

// 01:23 Ludwig: This is yet another problem not easily observed with a fast connection, but will cause serious frustration for real users. Let's see how we can cancel data tasks to prevent unnecessary network usage. Move to "TMDBClient.swift" within "TheMovieManager17.xcodeproj" to see the comments within code ...


// MARK: Tip:  Getting warnings about the unused return type from taskForGETRequest? Use the "@discardableResult" annotation to silence them.
// @discardableResult class func taskForGETRequest
// check also https://www.avanderlee.com/swift/discardableresult/


// MARK: Reflect - What are some situations where an app should cancel a task?
// me: We should cancel a task when there are more tasks possible in relatively short time. So it is better to update/cancel the current task by new one. Important with low speed internet connection.
// Udacity: Thanks for your response! In general, a task should be canceled when the data is retrieves is no longer needed, just like we canceled our old search tasks when a new character was typed.

// additional info sources:
// https://www.avanderlee.com/concurrency/tasks/


//: [Next](@next)
