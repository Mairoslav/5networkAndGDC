//: [Previous](@previous)

import Foundation

// MARK: 2. Movie Manager Code Review

// 00:00 Ludwig: Thank you for taking time to reviewing our movie manager app. I know I mentioned that our app was not production ready. Can you tell us little bit more about what we're missing?

// 00:11 Jessica Lin: Yes. So, for us to call the Movie Manager production ready, we need to consider the situations that real users will face. Here are MARK: situations to consider:

// 1. Network dat is limited.
// Not everyone has unlimited data and not all connections have the same speed. So it's important to be thoughtful about how you make network requests and if it't even necessary to make a request at all.

// 2. Networks can be unreliable.
// While you may have network connection that can stream this video while you open your app, mobile devices can be used anywhere. And if a user is in a rural area, they may have limited data, if not zero connectivity, and your app should be able to react accordingly.

// 3. Something can go wrong.
// Whether that's the threaded 404 page or the server just failing, your app should be able to do its best to handle the unexpected so that the user knows what went wrong.

// 01:06 So far, we've only tested the app on our device, but if we simulate the experience of actual end-users, the Movie Manager will offer a much better experience for our users.

// 01:17 Ludwig: Thanks Jessica, testing our ap in real environments is important to uncovering issues and it looks like many of these issues are common challenges we face when working with any network data. Let's look at each one and see how we can address it in our app. 

//: [Next](@next)
