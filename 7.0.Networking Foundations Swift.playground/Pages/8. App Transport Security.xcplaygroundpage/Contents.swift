//: [Previous](@previous)

// MARK: 8. App Transport Security

import Foundation

/*
 00:00 To load our wolf/kitten image from unsecured HTTP, we need to configure the App Transport Security settings. We can do this, by modifying our Info.plist file. Now, you probably haven't interacted with the Info.plist too much, but there were just a few steps needed for us to load from this URL.
 
 00:19 The Info.plist file or property list file is like a dictionary, with keys and values, and it can contain many nested dictionaries as well.
 
 00:27 We create a separate sub-dictionary for AppTransportSecurity. Start by clicking the root of first dictionary at the top, that says "Information Property List", then click the plust button. 00:39 This adds a new property that acts as a key in this dictionary. If I start typing App T, Xcode fills in some suggetions, and from from the drop-down list I am going to select MARK: "App Transport Security settings"
 
 00:52 We want to keep App Transport Security but also enable an exceptio nfor a different domain. So, on the App Transport Security settings dictionary, I'll click the disclosure arrow to the left, so we can add a new property. I'll click the plus button again, and the name of this sub-dictionary is MARK: "Exception domains"
 
 01:13 Each exception domain is another dictionary. So, click the disclosure arrow again on Exceptions Domains, and add a new property:
 
01:21 With the key, we'll put the domain for which we want to enable exceptions for, and that's "kittenwhiskers.com" and change the type to Dictionary, wow! Tha's a lot of dictionaries, but we can finally set the properties to allow requests to this unsecured URL.
 
 01:38 click the disclosure arrow of "kittenwhiskers.com" again, so we're adding properties to this dictionary, and then click the plus button. To anable this domain, we need the key NSThirdPartyException, to allow insecure HTTP loads. For this property choose Boolean from the list (note that info.plist does offer YES/NO options rathere than TRUE/FALSE as per Boolean). From the next list choose YES.
 
 02:00 That means, that is a third-party service, in which we do not control the security settings, and we want to load an image from it anyway. There are many other "App Transport Security" settings for different pusposes, and more information is provided below the video.
 
 02:15 All right. It's almost time to run it. But there is one more thing to keep in mind, when editing AppTransportSecurity settings. Sometimes when we're installling the App, it keeps old settings. So, just to be safe, I'am going to go back to the simulator and delete the app from its screen by long pressing just like we do on a real iPhone device. Now we can be sure that we're testing our new settings.
 
 02:35 Let's run the app, and click Load Image. All right. I'am not seeing any complaints about App Transport Security, so I assume a request is being made. But I am not seeing an image yet, and there's something new. If we go back to our code, the code setting the image is highlighted, and it says MARK: "UIImageView.image must be used from the main thread only.
 
 03:01 This is strange, so we're in the completion hander of our request, but our image still isn't being set correctly. Before we move forward to address this issue, make sure you have the App Transport Security setup correctly in your App, then we'll tackle this one last error message preventing our request from working.
 */

/*
 // MARK: text under the video
 
 - Key to copy/paste: NSThirdPartyExceptionAllowsInsecureHTTPLoads
 - App Transport Security Documentation (scroll down to the second table to see the Exception Domains dictionary keys)
 
 QUIZ Question: Match the following ATS Exception Domain Keys with their Usage
 
 Key: NSIncludesSubdomains
 Usage: When set to YES, applies exceptions to both the top-level domain such as udacity.com AND to any subdomains such as classroom.udacity.com
 
 Key: NSExceptionAllowsInsecuredHTTPLoads
 Usage: When set to YES, allows you to make insecure connections(e.g. to an HTTP server, or to an untrusted HTTPS server) for a domain whose security attributes you _do control.
 
 Key: NSThirdPartyExceptionAllowsInsecuredHTTPLoads
 Usage: When set to YES, allows you to make insecure connections(e.g. to an HTTP server, or to an untrusted HTTPS server) for a domain whose security attributes you _don't control.
 
 */

//: [Next](@next)
