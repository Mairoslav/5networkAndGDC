//: [Previous](@previous)

import Foundation

// MARK: 5. Enable and Disable UI Appropriately
// see comments also in "TheMovieManager16.xcodeproj"

// MARK: video1
// 00:00 Ludwig: We just saw how we can use the network link conditioner to simulate a slow connection. These are the types of situations tha real user will encounter that we may overlook when first building our app. Are there any other places where our app behaves strangely over the slow connection?

// 00:20 Lin: Yes. So, on the login view, using the network link conditioner, we can see that we can actually attempt to login multiple times, which is not what the users expect. If I tap the Login button, I can see the activity indicator starts spinning. Now it looks like the usr is loggin in but I can still edit the email and password text fields, and then I tap Login again, and then one more time. So I've started the login process three times, and have no way of knowing when eah task will finish up.

// 00:47 There are a couple of ways that you can solve this problem, but a common way is to simply enable and disable the user interface to signal that the login is in progress, when the users can't edit the text field or login another time until the user request is complete.

// 01:04 Ludwig: Thanks, Jessica. Let's see how we can enable and disable the UI in the movie manager. We already know how to enable and disable a view, we just need to decide which UI elements should allow user interaction ans which ones hould not while the user is loggin in. Take a look at the LoginViewController and determine which views should be disabled, and feel free to modify the set UI state i.e. "setLoggingIn" method to enable and disable these views accordingly. We are going to do just that.

// MARK: Reflect - What views should be disabled while the user is logging in?
// me: Email text Field, Password text Field, Login Button, Login via Website Button
// Udacity: Yes correct. You should disable any view that the user could interact with that may cause unexpected results. To prevent the user from starting the login process twice, it makes sense to disable the login button and login via website button. There's also no need for the user to edit the text while being logged in, so you can disable the username text field and the password text field as well.

// MARK: video2
// 00:00 While the user is loggin in, we want to disable each view that the user can interact with: Email text Field, Password text Field, Login Button, Login via Website Button. Converselly, we want these views to be enabled when users are not loggin in just like how the activity indicator was shown and hidden.

// 00:28 So, "setLogginIn" method is a good place to configure these views. We'll start with the email text fields property, and we know to enable and disable a view, we use the property calls in isEnabled. ... see directly in comments of "TheMovieManager16.xcodeproj" ...

//: [Next](@next)
