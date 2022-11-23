//: [Previous](@previous)

import Foundation

// MARK: 5. Finish Refactoring taskForPOSTRequest

// 00:20 Two generic types, ... see "TheMovieManager8.xcodeproj" comments

// MARK: Reflect - We won't be making any more DELETE requests in our app, but a similar approach could be used to refactor the code for making DELETE requests. If you were to implement a taskForDELETERequest method, what would be the parameters? What could would the function run?

// check "TheMovieManager8.xcodeproj" for solution and comments ...

// MARK: Things to think about

/*
 Answers may vary, but there will probably be some similarities to "TaskForPOSTRequest", passing in a type for the request body.

 For logging out, we don't care about parsing the result, so you may or may not include parsing code in "taskForDELETERequest". But for some DELETE requests you may care about the result and use a "ResponseType" generic. In that case, the method would also parse the JSON and handle the errors.
 */

//: [Next](@next)

