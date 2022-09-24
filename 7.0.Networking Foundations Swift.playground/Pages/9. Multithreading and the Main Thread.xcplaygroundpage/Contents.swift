//: [Previous](@previous)

// MARK: 9. Multithreading and the Main Thread

import Foundation

/*
 00:00 So, why can we only set the image on the main thread? What is the main thread, and what is the thread anyway.
 
 00:14 The idea of thread is a bit abstract, so we'll use a real-world analogy. Let's see your phone's processor like a toll road, as we can think of each task, whether that's a) displaying a label, b) responding to a user tapping the screen, c) or making a network request... as one of the car(s) on the road blue/green/.
 
 00:32 When cars are approaching the toll bridge, they need to slow down so that they can pay the toll, allowing them to continue. Just as we can't have two cars using the same toll bridge at the same time the processor could only perform one task at a time. Each one is processed in the orders it's received.
 
 01:02 Now a toll road with one lane AND one checkout does not sound very efficient, as neither with a phone that only lets us do one task at once. Many years ago, it was big news when the iPhone allowed users to talk on the phone and surf the internet at the same time. For most users today, this is the type of multitasking we have come to expect. Our apps have a lot more going on, and our processor is not limited to only processing a single list of tasks. In reality, thephone's processor is more like a multi-lane highway i.e. we can execute multiple series of tasks at the same time. A thread is like an individual lane on the highway.
 
 01:47 Each lane has one tollbooth/tollbridge to process one car at a time. Similarly, each thread can process one task at a time. But unlike before, we can have multiple threads, allowing us to process multiple tasks simultaneously. This is what is called MARK: Multithreading
 
 02:04 So, we have multiple threads doing multiple tasks at once. But which one is MARK: the main thread?
 
    Well any of them could be, but I'd like to think of the main thread as another lane of the highway. This right one, we'll call it a cruise lane. It does not have a tollbooth/tollbridge at all. Instead as cars pass through, a picture is taken of their license plate so that they can be billed later. Cars in this lane do not need to slow down to pay the toll, making the traffic much faster.
 
 02:39 The point is that the main thread processes more requests faster than many other threads because its work is prioritized by the processor. But if you forgot to stay in the cruise lane (main thread) and instead use one of other lanes (xy background/multi-threads), then you are slowed down, and have to pay toll manually.
 
 02:52 If we executed a task on the xy background/multi-thread that instead should have been executed on the main thread, then the main thread will not know that the task has been completed, and the app will be slow to respond. That's definitely not something we want, but what types of tasks should run on the main thread?
 
 03:11 1A) VIEW RENDERING: Well as the name suggests, it is the default thread for your app. When iOS renders EVs(View rendering), this all happens on the main thread.
 
 03:18 1B) USER INPUT: And when your app responds to user input, that happens on the main thread too.
 
 03:22 1C) VIEW CONTROLLER LOGIC: In fact, all your View controller logic runs on the Main Thread by default. MARK: To keep your app responsive, you should limit work on the main thread, and to use a xy background/multi-thread where appropriate.
 
 03:39 2A) NETWORK REQUEST: That's why when you call a data task on URL session, the process of making a network request actually happens in xy background/multi-thread.
 
 Network requests take time. If the request were to happen on the Main Thread, then your users would be stuck with an unresponsive screen until the request does finish.
 
 03:51 DON'T UPDATE UI!: But this also means that your completion handler is executed on the same xy background/multi-thread. If you try to update the UI from the xy background/multi-thread like we did in the previous video, the image will take a while to display, if it even display at all.
 
 04:04 Thankfully there's a simple way to skip back to the main thread. Simply call MARK: DispatchQueue.main.async{ ...
 
 And between the curly braces place your code that updates the UI.
 
 04:23 Let's go back to our code, to update our UI on the main thread. we know that because network requests are executed in the background, all of the code so far in the completion handler, including setting the image runs on xy background/multi-thread.
 
 04:33 If we want to run the code on the main thread, we call MARK: DispatchQueue.main.async{
 
 And we'll use trailing closure syntax. 04:44 Let's move the code to update the imageView into the async block there. Now, our code should run on the main thread.
 
 04:49 Let's run the app to try it out. I'll load the image by pressing Load Image button, and we can see the image is displayed immediatelly, just as we expect. And we also notice that the warning is gone as well.
 
 05:03 So we have updated the UI on the main thread and our app is responding as it should. 
 
 */

//: [Next](@next)
