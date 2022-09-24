//: [Previous](@previous)

import Foundation

/*
 HTTPS
 There's one final detail about general networking communication that we need to cover before jumping back over to Swift, and that is the subject of HTTP vs. HTTPS.
 
 What is HTTPS?
 Before providing sensitive data to a website, for example, payment information or personal credentials such as usernames and passwords, you need to trust the website to keep your information safe.

 You can check whether a site uses a secure connection by looking for a little lock icon in the address bar:
 
 closed padlock/lock icon in front of the website link, when clicking on it, it says encrypted ...
 
 When you see the padlock icon, it means that the client and server have set up an encrypted connection. This protects against anyone else reading and/or altering the content while it's en route.

 In other words, it means that the site is using HTTPs, a secure extension of HTTP.

 Some websites and web services use HTTP, and some use HTTPs. Let's look at what that means for us as mobile developers.
 */

/*
 HTTPS on iOS
 
 How to make sure that app is using a secure connection to get its data?
 
 Article from Udacity suggestion (2016):
 https://techcrunch.com/2016/06/14/apple-will-require-https-connections-for-ios-apps-by-the-end-of-2016/?guccounter=1&guce_referrer=aHR0cHM6Ly9sZWFybi51ZGFjaXR5LmNvbS8&guce_referrer_sig=AQAAAAd51bidyR5BV0jX1HYFIct3ej4vxdvW-RlkZNzz5Izvb9wNU9U2Hm91FtpndSCP3S9kmuDtSkViHWTkn7_8jLJ9D1Lw__iKKEWqM2MZc8wvrI4wToQzp5aHmqCyEZECy3UOuw50N2454jSouW3OcfFlvOtjTOURnHhZy7lAmK94
 
 Article/s from google search "How to make sure that app is using a secure connection to get its data?"
 https://developer.apple.com/news/?id=jxky8h89
 */

//: [Next](@next)
