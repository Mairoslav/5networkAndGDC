//: [Previous](@previous)

import Foundation

// MARK: 11. Interview with Travis Bell: Another Auth Question

// 00:00 Ludwig: we are all set to start using account features of the Movie Database, but there is another way that apps can authenticate. Many apps have the option to authenticate via the browser, such as the login with Google or with Facebook buttons. Many of these authentication options use the OAuth specification, which stands for Open Authentication. The Movie Database also lets users to authenticate via the browser. Let's go back to Travis and hear about how this works. Hi Travis, can you can explain how we can authenticate via website and why did you use this approach instead of OAuth?

// 00:37 Travis: Yeah for sure, so back when I did the 1st pass of authentication, OAuth was just a little bit of a mess. And you know, instead of trying to force this system, that was just kind of broken onto our users, I just decided to do something that was close to OAuth but ultimately our own. You'll see as you go through the principles of OAuth and our AuthFlow are almost identical. You do all the credential checking on the website, so you are not passing usernames and passwords over the air. They are really almost identical. It's just that we thought it was more easier to do it ourselves.

// 01:22 Ludwig: Thank you Travis, while defining your own solutions can make things simpler, authenticating with TheMovieDatabase is quite similar to OAuth. Let's see how this AuthFlow work.

// 01:30 Example via screen: in the Udacity app for example. you are presented with the login screen where you can enter your email address and password. However there are also another sign in options here, like signing in with Google. If I tap the sign in with Google button, I am being redirected outside of the app into Safari (or other browser), where I can log in onto the Google Account website. When I am done with logging in there, I am automatically redirected back to the Udacity app and still login process is complete. This is really cool and offers a lot of convenience for users, if they are already signed in in the browser/account, then they do not even have to re-enter the username & password. This authentication flow is common in many apps. We will see how to implement it in our app next.

// MARK: Reflect - What are some possible advantages and disadvantages of using the OAuth-like approach of logging in via the browser?

// Some benefits include security (not giving login credentials to a third party app developer) and convenience (not having to type the username and password again). Here is a good discussion of both the pros and cons of using OAuth specifically. https://cloudinfrastructureservices.co.uk/saml-vs-oauth-whats-the-difference-explained/

//: [Next](@next)
