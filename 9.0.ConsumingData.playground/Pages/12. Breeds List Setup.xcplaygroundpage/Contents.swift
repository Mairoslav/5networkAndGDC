//: [Previous](@previous)

import Foundation

// MARK: 12. Breeds List Setup

// 00:00 It's time to get back to the ranDog app and implement the breeds list feature. There's not anything specific to networking or working with the dogAPI here, but I am going to walk you through the steps to get the breeds list feature set up, just so you'll be familiar with the rest of the code. In order to implement the breeds list feature, we need a way to select a breed from the list.

// 00:22 UKKit provides a view for that called the UIPickerView. You may not have used a UIPickerView as a developer, but you have probably seen it many times as a user. Apple likens it to a slot machine. The UIPickerView presents a list of options, in our case, dog breeds, and lets users go preview the options by scrolling up and it's down.

// 00:44 We are going to add the pickerView above this image view here ("ranDogCodableFetchRefactorIIChallenge12"). To make things easier, we'll use a vertical stack view.
        // So I'll make sure I have the imate selected
        // 00:54 In Editor menu/ Embed in/ StackView

// 01:00 Let's check our stackView in the attributes inspector, and we can see that it is "vertical" by default. If it is not you can change it in the drop-down menu. When we first added the imageView in the last lesson, we added constraints so that there would be margins on all sides. 01:16 But if I click the imageView again in the document's outline and then check on the size inspector, the constraints are gone. That's because these constraints won't work when embedded in a sack view.
// 01:29 The stack view is the root view. So let's give it those constraints next, and the default margins on all sides will be fine (just click on icon "add new constraints" and select all 4 sides so they become red). So, we're all set to add the picker view.
// 01:39 I'll go into the Object Library, and type picker view and see that I can drag it onto the vertical stack view. When this blue line shown up above the ImageView, that means the picker view will be added above the image.
// 01:52 One last thing, I'll add a height constraits to the ImageView, like this (not sure how he did it, just click on icon "add new Constraints" icon). Images returned from the DogAPI can be of various different sizes and ensuring a fixed height ensures our image and picker won't grow or whrink beyond the image size. That's all we need to do for the layout.
// 02:10 Now to use the pickerView in the code, we need to create an outlet. So I'll go to the assistant editor, and drag from the pickerView to the viewController file (just under the already existing "@IBOutlet weak var pickerView: UIPickerView!"). I'll call it pickerView.

// 02:24 Now, to use the pickerView in code we need to understand a little bit more about how it works by heading over tho the documentation, and down there within the "Overview" section it is written:
    /// You provide the data to be displayed in your picker view using a picker data source—an object that adopts the UIPickerViewDataSource protocol. Use your picker view delegate—an object that adopts the UIPickerViewDelegate protocol—to provide views for displaying your data and responding to user selections.

// 02:54 This sounds like a tableView wich also let's you to scan through a list of values. The details of how pickerViews work are not important, and I encourage you to read through the documentation links below if you'd like to learn more. Right now I am going to go back into Xcode, and run through how we can get the pickerView up and running.
// 03:14 For our convenience, let's just make our ViewController to conform to UIPickerViewDataSource and UIPickerViewDelegate, see: https://developer.apple.com/documentation/uikit/uipickerview/ We will do this using an extenstion.
// 03:23 Remember that we need to make sure that our pickerView knows which object is the data source and delegate. So we'll scroll up to viewDidLoad and set the dataSource to self which is our ViewController.
    /*
     pickerView.dataSource = self
     pickerView.delegate = self // and do the same thing for the delegate
     */

// 03:39 All right, now to add the dataSource and delegate methods, this is just like a table view.
    // UITableView (as it is shown in video)

// All tables can have one or more sections which contain one or more rows. To specify the number of sections, we use the medhod "numberOfSections" in UITableView: https://developer.apple.com/documentation/uikit/uitableview/1614924-numberofsections/

    // 03:54 A cection in a pickerView is called the component as the method is called "numberOfComponents in picker view: https://developer.apple.com/documentation/uikit/uipickerview/1614368-numberofcomponents/

// 04:01 Similarly, with a table view, each section has one or more rows. This is specified by the method "numberOfRowsInSection": https://developer.apple.com/documentation/uikit/uitableview/1614952-numberofrowsinsection/

    // 04:10 And in the pickerView, the equivalent is "numberOfRowsInComponent": https://developer.apple.com/documentation/uikit/uipickerview/1614381-numberofrowsincomponent/

// 04:14 Let's implement these methods now.
// 04:17 In "numberOfComponents" in pickerView, we'll return one. We're just having the user select one value, the breed name.

// 04:25 For a number of rows and component, we'll return breeds.counts.
// 04:30 Where does breeds come from? Well, just like a table view, a picker view can be populated with an Array. Let's add the breeds property to the ViewController byh scrolling up here (line 18), making it equal to an Array of Stings. And after = I'am going to add some breeds just so our picker has omething to display.

// 04:49 So our app knows how to determine the number of components and rows, let's impement the rest of these methods.

// 04:58 Recall from working with table views to determine what data or view to show at each row, we had a method "cellForRow at:IndexPath": https://developer.apple.com/documentation/uikit/uitableview/1614983-cellforrow/

    // 05:05 With picker views, we're just working with Strings, but again, it's very similar to tables. The method is called "titleForRowComponent" which returns a String: https://developer.apple.com/documentation/uikit/uipickerviewdelegate/1614384-pickerview/

// 05:14 And to handle when a row is selected in a table view, we implemented "didSelectRowAtIndexPath": https://developer.apple.com/documentation/uikit/uitableviewdelegate/1614877-tableview/

    // 05:22 The picker view equivalent is "didSelectRowInComponent": https://developer.apple.com/documentation/uikit/uipickerviewdelegate/1614371-pickerview/

// 05:23 Let's implement these in the ViewController.
// 05:28 Title for row and component just returns a String that will be displayed in the picker view. This is the name of the breed to be selected by the user. And we have an integer for the row the breed will be displayed in. So, we'll return the value in the breeds Array using the row as the index.

// 05:44 For didSelectRowInComponent, this is called when the pickerView stops spinning and a breed has been selected.
// 05:51 When this happens, we want to fetch a new image from the DogAPI which we can do by calling our "requestRandomImage" method passing "handleRandomImageResponse" method as the completion handler.
// 06:04 This replaces the request we made in viewDidLoad, so I'am going to remove it. We'll only be requesting a random image if we have a breed.
// 06:14 So let's run it and test it out. I'll move the pickerView to select an image and when the picker view value changes, an image is loaded. However, there's no guarantee that the image we get back will be of the selected breed. In order to correctly filter by breed, we need to modify the way our endpoint is stored so that it specifies that dog breed each time we make a request.




//: [Next](@next)


