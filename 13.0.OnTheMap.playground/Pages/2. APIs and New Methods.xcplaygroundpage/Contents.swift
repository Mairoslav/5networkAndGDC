//: [Previous](@previous)

import Foundation

// MARK: 2. APIs and New Methods
// TODO: Note - The "Udacity API Guide" and "Parse API Guide" are no longer Google Docs as seen in this video. We have moved all the information contained in both guides into the classroom. So, simply continue forward and learn how to use them both! ... see full note under the video called "Parse Closing its Services.

// 00:00 You might be thinking, waw this app looks cool, but how do I even get started? So let's go over a few quick basics.

    // 00:05 First, this app is similar to some of the previous apps we've made in this networking course. You should feed comfortable using those apps as references or even for some starting code.

    // 00:16 Secondly, in the previous apps we've made, we've used various client APIs to build out the app's functionality. For OnTheMap, you'll be using two such client APIs: A) "Udacity API Guide" and B) "Parse API Guide".

        // 00:30 You'll be using A) "Udacity API Guide" to authenticate users. You'll do this by working with a web service method that we've exposed for this purspose. The "Udacity API Guide" should take you through the process.

        // 00:41 The B) "Parse API Guide" you'll be using to access data for the student pin location and links. Parse is a common solution used by mobile apps for persisting data in the Cloud and is an alternative to using Core Data, which we'll actually be talking about in the next course. Note that while Parse does have an SDK available for iOS, we want you to use the Parse web API for the OnTheMap project. This "Parse API Guide" should take you through the process of using Parse for this purpose.

// .........LoginViaFbIsVoluntary............start
// 01:08 For this app, you'll also have the option to enable usrs to log in through Facebook. This feature is not required, but we still want to give you someinfo in case you decide to attempt it. To enable Facebook login, you'll need to do the following:

    // 1. Read through Facebook's documentation on their login feature,

    // 2. Connect your Udacity user account to your Fb account, which can be done oth the account settings page of the Udacity website.

    // 3. Implement a few extra methods ("Udacity API Guide"). At the bottom of the Udacity API Guide, you'll find some methods that you'll need to implement to get the Fb login working.
// .........LoginViaFbIsVoluntary..............end

    // 01:35 The last point I want to make is if you think of the app as one massive project, it can appear very daunting and make it hard to get started. That's why it's better to see the app as a buch of pieces that make a whole and tackle one chunk at a time. Making a simple wire-frame or setting up the networking code of one of the aforementioned clients is a good place to start. 


// MARK: Parse Closing its Service
/*
On January 28, 2017, Parse shut down its service. The full announcement can be found at Parse Blog: Moving On. But, don't worry! "On the Map" can still be completed because we have migrated off of Parse to a modern backend written in Go.
 
Note: The "Udacity API Guide" and "Parse API Guide" are no longer Google Docs as seen in this video. We have moved all the information contained in both guides into the classroom. So, simply continue forward and learn how to use them both!
*/
 
//: [Next](@next)
