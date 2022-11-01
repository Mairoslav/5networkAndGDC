//: [Previous](@previous)

import Foundation

// MARK: 1. Intro: The Movie Manager

// 00:00 So far you have gotten a lot of practive working with web services in Swift by making Git requests and parsing JSON responses. This is a great start to building network apps. It's finally time to start building more complex aps that can do more than simply request and display data. Let's take a look at a new app, "The Movie Manager", which you will be building over the next three lessons of this course.

// 00:26 Here we have a view with multiple tabs, and in the first tab, we can search (1st icon down) for a movie. Selecting your results brings us to the detail screen. At the bottom of the screen, we have two buttons:
    // 1. one that adds the movie to the watchlist, and
    // 2. one that adds the movie to the favourite list. You can see here that I've added it to both the watchlist and favorites list.

// 00:51 Navigating back, let's check out the other tabs. Here on the watchlist (2nd icon down), we have a table and if we scroll to the bottom, you can see the movie we have just added.

// 01:01 The next tab is our favourites list, which has the same movie. Now, a lot of this looks like what we've already been doing, getting data from a server and displaying in in an app, and you should be great.

// 01:14 The difference is that not only are we presenting data that's publicly available, we are also interacting with data that belongs to a specific user.
// 01:29 If I tap the logout button in the corner, yu can see where users can sign into the Movie Manager app.

// 01:28 To build the Movie Manager app, you're going to use a new API called THe Movie Database or TMDb for short. THe TMDb lets you browse movies, maintain a watchlist and favourite list, among many other features, perfect for building our app you will learn:

// MARK: as per text under the video

/*
 Lesson Objectives
    Create an API key for use with a web service. - You'll learn how APIs like MDBb can identify requests form your app using an API key.
    Learn about authentication for user data.
    Learn to make HTTP POST requests in Swift. 01:51 - You'll also learn how to update data on the server using HTTP post requests,
    Learn how authentication works with a username and password.
    Learn how authentication works using the browser (OAuth-like). - And you'll learn about authentication to allow each user to access their own account.
    Log out using a DELETE* request.
 */

// 02:33 This lesson is focused on authentication, we explain the different ways in which users' login credentials like an email and password can be used to access the functionality of a web service as you'll implement the login screen in the Movie Manager app, making your 1st POST and DELETE* requests in Swift.

// In the process, you'll gaina lot more experience working with web APIs. To get started, let's hear a little more about the Movie Database and what this service has to offer. 

//: [Next](@next)
