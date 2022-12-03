//: [Previous](@previous)

import Foundation

// MARK: 1. Demo: "On the Map"
// Note under the video: Note: The interface shown in the above video is slightly out-dated, but otherwise, it is a valid example of "On the Map".

// 00:00 For the map, you'll be receiving w written spec for hwo tha app should work. But since I am kind of a visual person, I want to give you a demonstration of what it should look like. At the login screen, you're presented with the option of either loggin in with your Udacity Email and Password, or you can authenticate with Facebook. Since the Facebook authentication is optional and not required, I am going ahead and login with my Udacity Email and Password. After press Login.

// 00:28 The 1st screen I'll see is this tab view controller with two tabs: 1. one with the tab for map (icon of pin), and 2. second tab for list (icon of list).

    // 00:32 1. In the map view, I can drag around on the map and I can see pins of other students who have placed their locations. So there are some over here on the East Coast of th US, then we also have some over here on the West Coast near San Francisco. I've gone ahead and zoomed in on Florida, and if I tap this pin here, we can see that thisf was th e;in post about Jessica, and her link if for her LinkedIn profile. If I were to tap the link, this would take us directly to Jessica's LinkedIn page in Safari.

    // 00:58 I'll go ahead and switch over to the List view, and we can see the names of the same people that have posted pins. In the same way, if I were to tap any of these entries, they would take me to the links that these students have provided.

// 01:13 Now let's go back to the map. Here in the top-left corner, I have the option of posting a pin. The basic requirement of this app is that you could post as many pins as you would like. However, if you'd like to go the extra step, when you try to post a pin, you should check to see if a pin has already been posted for this user, and in my case, there already is a pin for me. So this Alert pop-up message/menu here is telling and asking me: "You Have Already Posted a Student Location. Would YouLike to Overwrite your Current Location?" giving me two options down in blue font: a) Overwrite and b) Cancel.

// 01:39 I'll go ahead and select "Overwrite", and now I am presented with this input view, with possibility to click button "Enter Your Location Here". I am going to overwrite my location to go back to my hometown of Huntsville Alabama, and by clicking on buttom "Find on the Map" I'll find it on the map.

// 01:52 Behind the scenes, the app Geocodes location into a longitude and latitude where this pill will be placed. For my link, I'll share my LinkedIn profile via button "Enter a Link to Share Here". And then I'll tap "Submit". So now the input process is done and my new pin is posted her in Huntsville Alabama.

// 02:11 And if I tap the pin, the pop up 'bubble' message (~annotation) shows up with my name and link to my LilnkedIn profile. And if I tap the annotation, then it takes me to my LinkedIn profile in Safari. These are the main user interactions for the app. If you are a visual learner like me, I hope this helps. 


//: [Next](@next)
