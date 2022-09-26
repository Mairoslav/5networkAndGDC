//: [Previous](@previous)

// MARK: 11. Summary

import Foundation

/*
 00:00 In these lessons you used your understanding of HTTP to make your first network request in Swift. Our simple app probably doesn't look too impressive, but it does demonstrate the basics of making simple HTTP r equests on iOS.
 
 00:19 You saw how we can represent URLs in Swift, and that when we send a request, we get a response. In our case, the response was a single image. But what if we want to request more data like a list of images, or what if we want to use data from an outside service such as photo-sharing website?
 
 00:40 We'll answer both of these questions in the next lesson. As always, take a break if you need and I'll see you there. 
 */

/*
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <dict>
     <key>NSAppTransportSecurity</key>
     <dict>
         <key>NSExceptionDomains</key>
         <dict>
             <key>www.kittenswhiskers.com</key>
             <dict>
                 <key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
                 <true/>
             </dict>
         </dict>
     </dict>
     <key>UIApplicationSceneManifest</key>
     <dict>
         <key>UIApplicationSupportsMultipleScenes</key>
         <false/>
         <key>UISceneConfigurations</key>
         <dict>
             <key>UIWindowSceneSessionRoleApplication</key>
             <array>
                 <dict>
                     <key>UISceneConfigurationName</key>
                     <string>Default Configuration</string>
                     <key>UISceneDelegateClassName</key>
                     <string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
                     <key>UISceneStoryboardFile</key>
                     <string>Main</string>
                 </dict>
             </array>
         </dict>
     </dict>
 </dict>
 </plist>
 */

// MARK: Info.plist from 25 Sept
/*
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <dict>
     <key>NSAppTransportSecurity</key>
     <dict>
         <key>NSAllowsArbitraryLoads</key>
         <false/>
         <key>NSExceptionDomains</key>
         <dict>
             <key>www.kittenswhiskers.com</key>
             <dict>
                 <key>NSIncludesSubdomains</key>
                 <true/>
                 <key>NSExceptionAllowsInsecureHTTPLoads</key>
                 <true/>
                 <key>NSExceptionMinimumTLSVersion</key>
                 <string>TLSv1.0</string>
                 <key>NSExceptionRequiresForwardSecrecy</key>
                 <false/>
             </dict>
         </dict>
     </dict>
     <key>CFBundleDevelopmentRegion</key>
     <string>$(DEVELOPMENT_LANGUAGE)</string>
     <key>CFBundleExecutable</key>
     <string>$(EXECUTABLE_NAME)</string>
     <key>CFBundleIdentifier</key>
     <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
     <key>CFBundleInfoDictionaryVersion</key>
     <string>6.0</string>
     <key>CFBundleName</key>
     <string>$(PRODUCT_NAME)</string>
     <key>CFBundlePackageType</key>
     <string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
     <key>CFBundleShortVersionString</key>
     <string>1.0</string>
     <key>CFBundleVersion</key>
     <string>1</string>
     <key>LSRequiresIPhoneOS</key>
     <true/>
     <key>UIApplicationSceneManifest</key>
     <dict>
         <key>UIApplicationSupportsMultipleScenes</key>
         <false/>
         <key>UISceneConfigurations</key>
         <dict>
             <key>UIWindowSceneSessionRoleApplication</key>
             <array>
                 <dict>
                     <key>UISceneConfigurationName</key>
                     <string>Default Configuration</string>
                     <key>UISceneDelegateClassName</key>
                     <string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
                     <key>UISceneStoryboardFile</key>
                     <string>Main</string>
                 </dict>
             </array>
         </dict>
     </dict>
     <key>UILaunchStoryboardName</key>
     <string>LaunchScreen</string>
     <key>UIMainStoryboardFile</key>
     <string>Main</string>
     <key>UIRequiredDeviceCapabilities</key>
     <array>
         <string>armv7</string>
     </array>
     <key>UISupportedInterfaceOrientations</key>
     <array>
         <string>UIInterfaceOrientationPortrait</string>
         <string>UIInterfaceOrientationLandscapeLeft</string>
         <string>UIInterfaceOrientationLandscapeRight</string>
     </array>
     <key>UISupportedInterfaceOrientations~ipad</key>
     <array>
         <string>UIInterfaceOrientationPortrait</string>
         <string>UIInterfaceOrientationPortraitUpsideDown</string>
         <string>UIInterfaceOrientationLandscapeLeft</string>
         <string>UIInterfaceOrientationLandscapeRight</string>
     </array>
 </dict>
 </plist>
 */

/*
 // MARK: Info.plist from 26 Sept
 
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <dict>
     <key>NSAppTransportSecurity</key>
     <dict>
         <key>NSAllowsArbitraryLoads</key>
         <false/>
         <key>NSExceptionDomains</key>
         <dict>
             <key>www.kittenswhiskers.com</key>
             <dict>
                 <key>NSIncludesSubdomains</key>
                 <true/>
                 <key>NSExceptionAllowsInsecureHTTPLoads</key>
                 <true/>
                 <key>NSExceptionMinimumTLSVersion</key>
                 <string>TLSv1.0</string>
                 <key>NSExceptionRequiresForwardSecrecy</key>
                 <false/>
             </dict>
         </dict>
     </dict>
     <key>CFBundleDevelopmentRegion</key>
     <string>$(DEVELOPMENT_LANGUAGE)</string>
     <key>CFBundleExecutable</key>
     <string>$(EXECUTABLE_NAME)</string>
     <key>CFBundleIdentifier</key>
     <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
     <key>CFBundleInfoDictionaryVersion</key>
     <string>6.0</string>
     <key>CFBundleName</key>
     <string>$(PRODUCT_NAME)</string>
     <key>CFBundlePackageType</key>
     <string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
     <key>CFBundleShortVersionString</key>
     <string>1.0</string>
     <key>CFBundleVersion</key>
     <string>1</string>
     <key>LSRequiresIPhoneOS</key>
     <true/>
     <key>UIApplicationSceneManifest</key>
     <dict>
         <key>UIApplicationSupportsMultipleScenes</key>
         <false/>
         <key>UISceneConfigurations</key>
         <dict>
             <key>UIWindowSceneSessionRoleApplication</key>
             <array>
                 <dict>
                     <key>UISceneConfigurationName</key>
                     <string>Default Configuration</string>
                     <key>UISceneDelegateClassName</key>
                     <string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
                     <key>UISceneStoryboardFile</key>
                     <string>Main</string>
                 </dict>
             </array>
         </dict>
     </dict>
     <key>UILaunchStoryboardName</key>
     <string>LaunchScreen</string>
     <key>UIMainStoryboardFile</key>
     <string>Main</string>
     <key>UIRequiredDeviceCapabilities</key>
     <array>
         <string>armv7</string>
     </array>
     <key>UISupportedInterfaceOrientations</key>
     <array>
         <string>UIInterfaceOrientationPortrait</string>
         <string>UIInterfaceOrientationLandscapeLeft</string>
         <string>UIInterfaceOrientationLandscapeRight</string>
     </array>
     <key>UISupportedInterfaceOrientations~ipad</key>
     <array>
         <string>UIInterfaceOrientationPortrait</string>
         <string>UIInterfaceOrientationPortraitUpsideDown</string>
         <string>UIInterfaceOrientationLandscapeLeft</string>
         <string>UIInterfaceOrientationLandscapeRight</string>
     </array>
 </dict>
 </plist>
 
 */

//: [Next](@next)
