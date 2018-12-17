# AppleWatchFaces
**Design your own watch faces for the apple watch. They are not *real* watch faces, but a watchOS app running on the watch that tells you the time.**

![APPLEWATCHFACES USAGE](AppleWatchFacesQuickDemo.gif)

## Frequently Asked Questions

1. **Can I download this from the app store ?**

  At this time, Apple is not ready for developer created watch faces -- **Typical reponse from Apple if you submit an iOS app that has a watch face:**

  Guideline 4.2.4 - Design - Minimum Functionality

  We continued to notice that your Apple Watch app is primarily a clock app with time-telling functionality, which provides a lower quality user experience than Apple users expect. Specifically, users must launch the app or swipe through glances to see the time.

  The native clock app already allows users to customize how time is displayed on their devices and offers the best possible time-telling experience. Users are able to switch colors, add more functionality and complications on a watch face such as an alarm, the weather, stocks, activity rings, moon phases, or sunrises and sunsets. Users also have the ability to tap on certain complications to get more information from their corresponding apps.

  We encourage you to review your Apple Watch app concept and incorporate different content and features that are in compliance with the [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/), as well as the [watchOS Human Interface Guidelines](https://developer.apple.com/watchos/human-interface-guidelines/). If you want to show the time in your Apple Watch app, you may use the specialized Date Labels to display time-related values on Apple Watch.

2. **Can I join your testFlight and help you beta test?**

  No. Apple also will block developers from *external* beta testing because of the H.I.G. ( see FAQ 1 ). If you have a large developer team ( which I do not ), then you might be able to do an *internal* beta test on testflight.

3. **How do I get this on my phone / watch?**

  Follow the installation instructions below to compile from the source and you can *side load* this application on to your phone and watch.

4. **How can I create my own watch hands / background shapes?**

  Currently the watch hands are using UIKit paths, but the plan is to switch these out for loaded SVG files in a folder and load them up when the app starts. This should better allow for designers and non-developers to easily add shapes into the project. 

5. **How can I create my add my own images for use as a background in the watch faces ?**

    1. Crop the image to a square at approximately 512x512 pixels ( 72 ppi )
    2. Drop it into the **/Shared/Resources/Materials** folder
    3. Add it into the /AppleWatchFaces/Colors.plist file
    
6. **Which versions of apple watches does this work with ?**

Any watchOS that can run spriteKit should be fine

7. **Are you planning to do complications ?**

Maybe, Ive seen some open source battery / date ones. Those would be the simplest to implement. Positioning out of the way of the other things might be one initial problem to solve

8. **Are all the designs round  ?**

The current code renders the items by rotating spriteKit nodes which puts everything nicely in a circle. I have an upcoming [issue for non-circular path support](https://github.com/orff/AppleWatchFaces/issues/6) which should get more "traditional" apple watch rounded rectangles and also support any arbitrary path like a star, oval, or spiral. Hopefully it would eventually play nice with SVG file support as well

8. **What about digital clocks  ?**

I havent thought much about the interface or settings for a digital clock that would make it interesting other than font, position, or flipping animation. A flip clock or nixue tube watch face might be pretty interesting to look at.  Feel free to create an issue or wiki with your ideas 

## Installation / Side Load

1. Install [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12) on your mac

1. Open a Terminal instance and go to your working directory

1. Do 
<code>git clone https://github.com/orff/AppleWatchFaces.git</code>

1. Navigate to the "AppleWatchFaces" folder in your working directory

1. Open AppleWatchFaces.xcodeproj in Xcode

1. Run on your device:
    1. Make sure you have an Apple developer account
    1. Select your development team under the `Signing` area for each target (`AppleWatchFaces`, `face`, and `face (notifications)`)
    1. Change the `Bundle Identifier` for each of the above targets to something unique. For example, `AppleWatchFaces` uses `com.mikehill.applewatchfaces`, so change that to something like `com.YOUR_USERNAME.applewatchfaces` 
    1. *important note:* Bundle identifiers for watch extensions are really specific.  `face` uses `com.mikehill.applewatchfaces.watchkit`  & `face (notifications)` uses `com.mikehill.applewatchfaces.watchkit.extension`
    1. Select the `face` scheme in the top left corner with your devices selected and run.

  If you are still having issues, please check out a [sideloading tutorial](http://osxdaily.com/2016/01/12/howto-sideload-apps-iphone-ipad-xcode/) on OSXDaily 

## Usage

### iOS App

1. The main view is for previewing all the faces and deciding if you want to edit one of the them.  You can also create a new one or tapping edit to re-order the list or delete.  Tapping *send all to watch* will send all current designs to the watch and go to the first one.
1. On the editor view, you can modify settings for that watch face, like the colors, hands, or indicators ( the parts that make up the face like the shapes and numbers that the hands point to ).  
  1. On the editor view, swipe left and right to go to other faces in the list and swipe up to preview this design on the watch -- same as the *send to watch* button
  1. On the indicators view you can edit the shapes and numbers that make up the face backgrounds.  The designs are rendered on the watch as shapes like circle or squares and text numbers that are *rings* from the outside to the inside of the watch face.  By editing the list of shapes and text items and *empty space* items, you can change the design of the items in the face and see in the preview watch on the top.
  1. You can also just choose from pre-definied *color themes* or *indicator themes* which will override current color or parts with known good settings
  
  ![APPLEWATCHFACES THEMES](AppleWatchFacesThemes.gif)

### Watch App

1. When AppleWatchFaces is open on the watch, use the digital crown to cycle through the different designs in the iOS app

2. Set your watch to wake on last activity
  
    1. Open the Settings app  on your Apple Watch.
    2. Go to General > Wake Screen, and make sure Wake Screen on Wrist Raise is turned on.
    3. Scroll down and choose when you want your Apple Watch to wake to the last app you used: Always, Within 1 Hour of Last Use, Within 2 Minutes of Last Use, or While in Session (for apps like Workout, Remote, or Maps).
    4. Choose While in Session if you want your Apple Watch to always wake to the watch face (except when you’re still using an app).
    5. You can also do this using the Apple Watch app on your iPhone: Tap My Watch, then go to General > Wake Screen.
      
3. Keep the Apple Watch display on longer

    1. Open the Settings app  on your Apple Watch.
    2. Go to General > Wake Screen, then tap Wake for 70 Seconds.


## Known Issues

### Sometimes when sending to watch the watch app crashes -- I think this has to do with using resources folders vs. Asset folders in spriteKit, but I have not had time do dive into it.
