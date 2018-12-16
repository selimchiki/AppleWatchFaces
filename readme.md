
![APPLEWATCHFACES USAGE](gameplay.gif)

**An iOS r the Apple Watch.**

## F.A.Q.

1. **Can I download this from the app store ?**

**TLDR:** At this time, Apple is not ready for devloper created watch faces. Below is a typical response if you submit a watchOS enabled app that tells the time.

**Typical reponse from Apple if you submit an iOS app that has a wach face:**
Guideline 4.2.4 - Design - Minimum Functionality

We continued to notice that your Apple Watch app is primarily a clock app with time-telling functionality, which provides a lower quality user experience than Apple users expect. Specifically, users must launch the app or swipe through glances to see the time.

The native clock app already allows users to customize how time is displayed on their devices and offers the best possible time-telling experience. Users are able to switch colors, add more functionality and complications on a watch face such as an alarm, the weather, stocks, activity rings, moon phases, or sunrises and sunsets. Users also have the ability to tap on certain complications to get more information from their corresponding apps.

Next Steps

We encourage you to review your Apple Watch app concept and incorporate different content and features that are in compliance with the [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/), as well as the [watchOS Human Interface Guidelines](https://developer.apple.com/watchos/human-interface-guidelines/).

If you want to show the time in your Apple Watch app, you may use the specialized Date Labels to display time-related values on Apple Watch.

2. **Can I join your testFlght and help you beta test?**

No. Apple also will block developers from *external* beta testing because of the H.I.G. ( see FAQ 1 ), so if you have a large developer team ( which I do not ), then you might be able to do an *internal* beta test on testflight.

3. **How do I get this on my phone / watch?**

Follow the installation instructions below to compile from the source and you can *side load* this application on to your phone and watch.

4. **How can I create my own watch hands / background shapes?**

Currently, the watch hands are using UIKit paths, but the plan is to switch these our for loaded SVG soon and allow for designers to easily add shapes into the project. 

5. **How can I create my add my own images for use as a background in the watch faces ?**

1. Crop the image to a square at approximately 512x512 pixels ( 72 ppi )
2. Drop it into the **/Shared/Resources/Materials** folder
in the folder

## Installation / Side Load

1. Install [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12) on your macintoch computer

2. Open a Terminal instance and go to your working directory.

3. Do 
<code>git clonehttps://github.com/orff/AppleWatchFaces.git</code>

4. Navigate to the "AppleWatchFaces" folder in your working directory.

5. Open AppleWatchFaces.xcodeproj in Xcode

6. Run on your device:
  1. Make sure you have an Apple developer account
  2. Select your development team under the `Signing` area for each target (`AppleWatchFaces`, `face`, and `face (notifications)`)
  3. Change the `Bundle Identifier` for each of the above targets to something unique. For example, `AppleWatchFaces` uses `com.mikehill.applewatchfaces`, so change that to something like `com.YOUR_USERNAME.applewatchfaces` 
  4. *important note:* Bundle identifiers for watch extensions are really specific.  `face` uses `com.mikehill.applewatchfaces.watchkit`  & `face (notifications)` uses `com.mikehill.applewatchfaces.watchkit.extension`
  4. Select the `face` scheme in the top left corner with your devices selected and run.

If you are still having issues, please following the tutorial provided by [Redmond Pie](http://www.redmondpie.com/install-giovanni-game-boy-emulator-on-apple-watch-heres-how-tutorial/)

## Usage

Games are loaded from your iPhone's documents directory. In iTunes, drop `.gb` or `.gbc` files into the Giovanni app documents folder, and they'll show up automatically on your Apple Watch. When you play a game for the first time, it'll download to your watch and get cached in the watch's documents directory. Subsequent loads are immediate.

UPDATE: Giovanni can open ROMs natively, allowing you to bypass iTunes entirely. [More info](https://github.com/gabrieloc/GIOVANNI/pull/9).

Emulator saving and loading is automatic, and happens whenever the app gets closed/inactivated or opened/activated. In-game saving and loading is completely separate. If for some reason the emulator save gets corrupted, force-touching the screen will bring up the option to reset the emulator, allowing you to resume from your in-game save.

The control scheme is as follows:

![Controls](controls.png)

## Troubleshooting

Disclaimer: Due to the constraints of watchOS, you may experience crashes or graphical glitches. Keep in mind that this project likely does not align with what Apple expects from the platform, which in turn makes it difficult to optimize and debug.

If for some reason the app becomes unresponsive and must be force-quit, you can do so by having the app in the foreground, pressing the side button, then pressing and holding the Digital Crown for about 5 seconds.

### Games don't show up
Because Giovanni relies on your iPhone for transferring games, ensure your paired iPhone is on and within reach.

### Garbled (or all white) pixels
Video memory often gets corrupt, in which case you will have to force emulation to be reset. While in-game, force touch the screen and select Reset. If the app closes after that, you will have to re-open, and repeat the process until it works.

### Colors wrong
Some games appear to format pixel data differently. The rendering work is done in [GameCoreSnapshots.swift](https://github.com/gabrieloc/GIOVANNI/blob/master/gambatte_watchOS/GameCoreSnapshots.swift), you may have luck adjusting how the Core Graphics context is created.

## Known Issues

### Games sometime crash when trying to fill the sound buffer
The sound buffer isn't even used, but required by Gambatte. The issue goes away after re-opening the app, but is a huge pain regardless.

## TO DO:
- ring cells less / more with edit mode on by default

- get ring settings / editor working
- scroll to new item ( esp. important for long list )
- UX for patterns ?

- allow editing of hand movments ( need thumbnails ? )
- undo / redo in editor ( save prev state each time )

- crash when sending to watch 5 times -- https://stackoverflow.com/questions/52860566/error-when-running-xcode-simulator-framework-cuithemestore-no-theme-regist
- !! save json data into JPEG for import / export over social  https://stackoverflow.com/questions/40175160/exif-data-read-and-write
- switch to SVG files for shapes : https://github.com/mchoe/SwiftSVG or https://github.com/pocketsvg/PocketSVG
- push app to hockeyapp for beta testing

## REFACTORS:
- guard lets instead of if lets
- refactor AppUISettings
- rename KKInterfaceController
- test with other screen sizes - fix layouts

## IDEAS:
- allow for user to choose background from camera roll ( memory only ), on save it copies to /docs folder
- options for main screen
- screen saver mode where it switches face on each new watch rise
- skin-see thru / tattoo watch
- show name of current face on watch when first starting ( then fade it out )
- better highlighting of the parts ( zoomed in outline )
- tinting colors for textures?

## COMPLETED
- switch to sending JSONData for watch comms
- add color picker
- add color for minute hand ( and subclass color picker controller )
- get rid of digital time from watch app ( from original tutorial )
- fix warnings in IB 
- fix warnings in logs
- save load themes / default faces
- add some buttons to swap out a few watch faces for testing
- start drawing the rings / fonts ( can test using default data )
- choose current options in CVs ( after loading a new faceSetting )
- add textures for backgrounds ( so we can have things like vinyl record ), if material does not have #, then try its name as a texture
- save / revert for current settings
- add a watch "frame" to the top left of the layout to better see what full screen textures look like
- send to watch sends whole list
- watch cycles thru designs using crown
- organize source files for settings view into group for view 
- fix app icon -- cannot have alpha channel in app store 
- add background shapes ( circle / square / side by side 2 color )
- make watch face chooser on main view TV + CV to allow for more settings 
- test on larger watch in simulator
- anti aliasing shapes!
- enable saving thumbnails when saving a watch
- copy thumbs from bundle to docs folder for loading in the main view, but do this only once ( save in preferences )
- BUG: settings arent loading in properly when selecting a watch from chooser ( seems to take two times )
- get textures working for hands
- enable swiping controls on the watch face ( L/R for prev/next , up for send to watch )
- clean up layout / UI for settings 
- move save to top action
- hide revert button ( not needed )
- add more buttons for random ( color, face )
- add edit table modal for chooser to be able to reorder, delete and add faces
- add third color to ring materials
- add watch frame to chooser edit view
- show title & allow editing of titles in settings ( tap on it fo a popup )
- clean up title table cell ( tighten height )
- add decorator themes to main selector table
- make new button ( debug only )  that regenerates all the default thumbnails
- bug when rendering text items < 12 ( IE 6 or 4 showg wrong numbers )
- fix the need for always having a spacer as first item ( better top level scale / drawing ) 
- add option to show hand outlines
- draw hand outlines ( white initially )
- add option for hand outline color
- implement some of the smooth animations for second / minute hand
- fix default the indicators to work better for watch
- ring editor: select cell when editing any of the items
- ring editor: show selected cell in preview ( just bloom effect current item )

