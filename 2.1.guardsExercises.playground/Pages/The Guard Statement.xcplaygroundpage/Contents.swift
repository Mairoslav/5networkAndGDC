//: [Previous](@previous)
//: ### The Guard Statement
//: - Callout(Exercise):
func showStory(downloadComplete: Bool, pageInitialized: Bool) {
    guard downloadComplete else { return }
    guard pageInitialized else { return }
    
    print("story time!")
}
//: If `downloadComplete` is false and `pageInitialized` is true, then will `showStory(downloadComplete:pageInitialized:)` exit early?
//: YES it will exit early, because 1st parameter downloadComplete is false
showStory(downloadComplete: false, pageInitialized: true)
//: in below case the "story time!" is reached/printed out:
// showStory(downloadComplete: true, pageInitialized: true)

//: - Callout(Exercise):
func showComic(downloadComplete: Bool, panelsLoaded: Bool) {
    guard downloadComplete else {
        print("download not complete")
        return
    }
    
    guard panelsLoaded else {
        print("panels not loaded")
        return
    }
    
    print("comic time!")
}
//: If `downloadComplete` is true and `panelsLoaded` is false, then what is printed when `showComic(downloadComplete:panelsLoaded:)` is invoked?
showComic(downloadComplete: true, panelsLoaded: false)
// panels not loaded is printed out
// interesting, that in case both parameters are flase only first statement is printed out and after it function does "early exit", so 2nd guard is not reached any more, neither final print is reached.
// showComic(downloadComplete: false, panelsLoaded: false)

//: [Next](@next)
