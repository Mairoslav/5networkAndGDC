//: [Previous](@previous)

import Foundation

// MARK: 6. Interview with Travis Bell: Auth Flow

// 00:00 So Travis, it looks like in order to access accou nt features like the watch list, we'll need a way to log into the movie database. Can you tell us little bit more about how this is done?

// 00:12 Yeah sure, so basically, to get a lot of the account features available on the API, so letting an account rate a movie at them, and remove them to your watch list, create custom lists, etc. you  need to get a TMDB user account. Once you have an account on a web site, you are able to go through an "Auth" flow on the API that lets you create a session that lets you do these account features via the API.

// 00:48 Ludwig: Cool so our goal is to create a session so we can access account features. Let's look at the documentation to see høw this can be done.

// 00:56 Being at site https://developers.themoviedb.org/3/getting-started/introduction we are looking for how to authenticate. So I am going to scroll down on the left pane here and click the "authentication" i.e. link: https://developers.themoviedb.org/3/authentication/how-do-i-generate-a-session-id First page says how do I generate a session ID. This page gives an overview of steps needed to authenticate with the movie database. There are three different steps, each with a different Endpoint and there are actually two different authentication flows from the user the user validates the request token.

// 01:21 The user can either login with a username and password directly from the app, or they can log in through the browser and redirect back to your app when successful. We'll start with the email and password, and see both authentication flows in this lesson, but the same steps are used. 1. Creating a request token, 2. Asking the user for permission, and 3. Creating a session ID.

// 01:42 To get familiar with the browsing the documentation, see if you can identify which Endpoints correspond to each of the pre-stages and to the Endpoints, and the boxes provided - see text under the video below.
/*
 
 // MARK: text under the video
 // Visit the documentation for authentication https://developers.themoviedb.org/3/authentication/how-do-i-generate-a-session-id and see if you can identify the methods (as in the paths) that correspond with each step in the auth flow.
 
 // Reflect 1: What is the endpoint to create a request token? No dwrong answer. My try: ...  Udacity: To get the request token the endpoint is /authentication/token/new.
 
 // Reflect 2: What is the endpoint to validate a request token? (there are actually two methods to do this) Now wrong answer. My try: ... Udacity: The two ways to either validate the request token are:
 
        // 1. Validate with email (username) and password: /authentication/token/validate_with_login check https://developers.themoviedb.org/3/authentication/validate-request-token
 
        // 2. Ask the user for permission as described in step 2. check https://developers.themoviedb.org/3/authentication/how-do-i-generate-a-session-id
 
 
 // Reflect 3: What is the endpoint to create a session ID? No wrong answer. My try: /authentication/session/new Udacity: To create a session ID, the endpoint is /authentication/session/new check https://developers.themoviedb.org/3/authentication/create-session
 */

//: [Next](@next)
