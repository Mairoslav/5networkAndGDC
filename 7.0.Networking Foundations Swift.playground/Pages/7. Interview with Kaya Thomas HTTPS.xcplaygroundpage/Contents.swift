//: [Previous](@previous)

// MARK: 7. Interview with Kaya Thomas: HTTPS

import Foundation

// 00:00 Mark: So Kaya, It sounds like Apple makes us go to a lot of trouble to use unsecured endpoints. Why that's so important that we use HTTPS? And, what can go wrong if we use an usecured endpoint?

// 00:15 Katya: that's a great question. It's so important to use HTTPS because it's a security protocol that makes sure any data being passed to or from is encrypted. If you use HTTP there's no way to know if the data that you're passing could be read maliciously by someohe who should't be reading it. For example, if you're passing account information like a username or password to unsecured endpoint, that data could be read and someone can use that to sing into your account.

// 00:45 Well that does't sound like good news. Sometimes, we do need to use an usecured endpoint when working with certain web services. We'll see how we can do ths by enabling exceptions for App Transport Security next. 

//: [Next](@next)
