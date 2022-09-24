//: [Previous](@previous)
//: ### Handle Errors
//: - Callout(Exercise):
//: Modify the error handling for `whatsThatError` so it catches the specific error being thrown when the `url` is set to the main bundle URL.
//:
import Foundation

/*
func whatsThatErrorOriginal(url: URL) {
    do {
        let content = try String(contentsOf: url, encoding: .utf8)
        print(content)
    } catch {
        print(error)
    }
}

whatsThatErrorOriginal(url: Bundle.main.bundleURL)
*/

func whatsThatError(url: URL) {
    do {
        let content = try String(contentsOf: url, encoding: .utf8)
        print(content)
    } catch CocoaError.fileReadInapplicableStringEncoding {
        print("cannot read file into a string / CocoaError.fileReadUnknown")
        /*
    } catch CocoaError.fileReadUnknown {
        print("file unknown, cannot read it")
        */ // note, when I keep CocoError.fileReadUnknown, it is printed out
    } catch CocoaError.fileReadNoPermission {
        print("no permission to read the file ")
    } catch {
        print(error)
        // print(error)
        // print(error.localizedDescription)
        // print("ohh error")
    }
}
 
whatsThatError(url: Bundle.main.bundleURL)
 
/*
whatsThatErrorOriginal(url: Bundle.main.bundleURL) prints:
Error Domain=NSCocoaErrorDomain Code=256 "The file “Handle Errors” couldn’t be opened." UserInfo={NSFilePath=/Users/mairo/Library/Developer/XCPGDevices/90D16949-5B7F-4D2D-8695-AA1445AAEBC4/data/Containers/Bundle/Application/F6813AE9-596B-4679-8032-8E5D0D52271E/Handle Errors-1064-19.app, NSUnderlyingError=0x60000296a5e0 {Error Domain=NSPOSIXErrorDomain Code=21 "Is a directory"}}
*/

/*
whatsThatError(url: Bundle.main.bundleURL) prints:
Error Domain=NSCocoaErrorDomain Code=256 "The file “Handle Errors” couldn’t be opened." UserInfo={NSFilePath=/Users/mairo/Library/Developer/XCPGDevices/90D16949-5B7F-4D2D-8695-AA1445AAEBC4/data/Containers/Bundle/Application/F6813AE9-596B-4679-8032-8E5D0D52271E/Handle Errors-1064-19.app, NSUnderlyingError=0x6000022d2610 {Error Domain=NSPOSIXErrorDomain Code=21 "Is a directory"}}
*/

//: [Next](@next)

