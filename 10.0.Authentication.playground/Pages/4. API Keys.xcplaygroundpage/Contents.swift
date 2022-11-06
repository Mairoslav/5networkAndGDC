//: [Previous](@previous)

import Foundation

// 00:00 Now that you had a time to play around the movie database and added movies to your favourites and watchlist, let's get back to the topic of APIs. Like the dogAPI or the images we have used in previous lessons, TMDb provides endpoints that let us interact with its various features from our app's code.

// 00:18 To get started, scoll up to the top and click the API button. It should take you to this overview page: https://www.themoviedb.org/documentation/api. If we start reading we can see that the API is free for everyone to use. And here it says "TMDb user account is required to request an API key". The last part "API key" may sound unfamiliar if you haven't worked with many web services before. What is an API key?

// 0:44 An API key is an identifier for your app. It's often stored as just a String of characters or numbers and lets the surfer know which app made the request. An App like an Movie Manager would have its own API key. Another student's version of the Movie Manager would have a separate API key and an entirely different app that also uses the movie database, would again have a separate API key for the movie database.

// 01:11 Any request made from your version of the Movie Manager app, regardless of who's devide is using it, will use the same API key. It just gives the server a way to identify the different apps using a given API. So why would an API need to identify your app?

    // MARK: Hosting costs
    // 01:25 For one, hosting a web service costs money and in return for the value provided by the service, the API may wants to limit a certain apps usage. Commercial users would pay for the number of requests they need and it's the API key would be used to keep track.

    // MARK: Rate-limiting
    // 01:43 The Movie Database API is free to use but still limits the number of request. This practice known as "rate-limiting" ensures that one user doesn't overuse the API. If this were allowed to happen, it would decrease the quality of service for other users, placing limits on eadch app or site that uses the API to ensure a fast and reliable service for everyone.

    // MARK: Better service. 
    // 02:04 So, using an API key benefits both the provider of the web service, as well as the developer using the API key. That's why the're common in web services like the Movie Database.

/* // MARK: text/task under the video
 Follow the steps to create an API key for The Movie Database - https://www.themoviedb.org/?language=en-US. This will be used when we start to add authentication to the movie manager.

 - Click your profile image in the top right, and click settings.
 - On the left pane, select "API" (you can also navigate directly here: https://www.themoviedb.org/settings/api)
 - Click "Create an API key"
 - Fill in the form information (the project name should be "The Movie Manager" and the purpose should be "Education"
 - // TODO: When you're finished, copy the string under "API Key (v3 auth)"***. This is the API key you'll be using for the movie manager app.
 */

// MARK: Reflect
// API keys are used to identify apps that use a web service. What do you think would happen if one developer's API key fell into someoe else's hands?

/*
 Creating API key
 API Key (v3 auth):
 841622fb8a5a4f75f298f96cb8ba7cd9 // TODO: copy this String, this is the API key you'll be using for the movie manager app
 
 Example API Request:
 https://api.themoviedb.org/3/movie/550?api_key=841622fb8a5a4f75f298f96cb8ba7cd9
 
 API Read Access Token (v4 auth):
 eyJhbGciOiJIUzI1Ni.eyJhdWQiOiI4NDE2MjJmYjhhNWE0Zjc1ZjI5OGY5NmNiOGJhN2NkOSIsInN1YiI6IjYzNjAyZTExMzM5NmI5MDA5MWQ4NjQ1ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vj6ERuoX1oCxb9-YNrzuxUF_5CgmGzE8TOj3b_o84lY
 */

//: [Next](@next)
